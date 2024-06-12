import Foundation

extension UserUseCase {
    public enum DomainError: Error {
        case didFailEmailValidation
        case didFailPasswordValidation
        case didFailNewPasswordValidation
        case underlying(any Error)
    }
}
