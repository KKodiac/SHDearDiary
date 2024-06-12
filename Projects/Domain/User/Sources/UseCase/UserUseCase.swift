import Dependencies
import Foundation

extension DependencyValues {
    public var user: UserUseCase {
        get { self[UserUseCase.self] }
        set { self[UserUseCase.self] = newValue }
    }
}

public struct UserUseCase {
    public var authenticate: (_ form: AuthenticationForm) async throws -> User
    public var register: (_ form: RegistrationForm) async throws -> User
}

