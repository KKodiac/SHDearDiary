import Foundation

public struct RegistrationForm {
    var name: String
    var username: String
    var password: String
    var confirmPassword: String
    
    public init(name: String, username: String, password: String, confirmPassword: String) {
        self.name = name
        self.username = username
        self.password = password
        self.confirmPassword = confirmPassword
    }
    
    public func validated() throws -> Self {
        guard self.username.isValidEmail else {
            throw UserUseCase.DomainError.didFailEmailValidation
        }
        guard self.password == self.confirmPassword else {
            throw UserUseCase.DomainError.didFailNewPasswordValidation
        }
        return self
    }
}

