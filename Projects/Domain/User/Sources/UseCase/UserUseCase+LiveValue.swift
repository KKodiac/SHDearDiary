import Dependencies
import Foundation

extension UserUseCase: DependencyKey {
    public static var liveValue = UserUseCase(
        authenticate: { form in
            
        },
        register: { form in
            
        }
    )
}
