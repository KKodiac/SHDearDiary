import Dependencies
import Foundation

public struct UserUseCase {
    var authenticate: (_ form: AuthenticationForm) async throws -> Void
    var register: (_ form: RegistrationForm) async throws -> Void
}
