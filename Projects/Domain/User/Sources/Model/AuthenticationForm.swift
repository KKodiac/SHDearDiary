import Foundation

public struct AuthenticationForm {
    var username: String
    var password: String
    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    public func validated() throws -> Self {
        guard self.username.isValidEmail else {
            throw UserUseCase.DomainError.didFailEmailValidation
        }
        
        guard self.password.isValidPassword else {
            throw UserUseCase.DomainError.didFailPasswordValidation
        }
        return self
    }
}
