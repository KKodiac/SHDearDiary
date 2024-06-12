import Foundation

extension UserUseCase {
    public enum DomainError: Error {
        case didFailEmailValidation
        case didFailNewPasswordValidation
        case underlying(any Error)
    }
}
