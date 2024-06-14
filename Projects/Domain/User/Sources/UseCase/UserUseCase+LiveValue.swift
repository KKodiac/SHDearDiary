import Dependencies
import Foundation
import Firebase

extension UserUseCase: DependencyKey {
    public static var liveValue = UserUseCase(
        authenticate: { form in
            do {
                let firebase = Firebase.Auth.auth()
                let data = try await firebase.signIn(
                    withEmail: form.username,
                    password: form.password
                )
                
                return User(
                    uid: data.user.uid,
                    email: data.user.email,
                    name: data.user.displayName,
                    isNewUser: data.additionalUserInfo?.isNewUser
                )
            } catch {
                throw UserUseCase.DomainError.underlying(error)
            }
        },
        register: { form in
            do {
                let firebase = Firebase.Auth.auth()
                let data = try await firebase.createUser(
                    withEmail: form.username,
                    password: form.password
                )
                return User(
                    uid: data.user.uid,
                    email: data.user.email,
                    name: data.user.displayName,
                    isNewUser: data.additionalUserInfo?.isNewUser
                )
            } catch {
                throw UserUseCase.DomainError.underlying(error)
            }
        }
    )
}
