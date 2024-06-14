import Foundation
import SwiftUI

extension UserUseCase {
    public enum DomainError: LocalizedError {
        case didFailEmailValidation
        case didFailNewPasswordValidation
        case underlying(any Error)

        public var errorDescription: String? {
            switch self {
            case .didFailEmailValidation:
                return NSLocalizedString("didFailEmailValidation", comment: "Please check your email address.")
            case .didFailNewPasswordValidation:
                return NSLocalizedString("didFailNewPasswordValidation", comment: "Please check your new password.")
            case .underlying(let error):
                return error.localizedDescription
            }
        }

        /// A localized message describing the reason for the failure.
        public var failureReason: String? {
            switch self {
            case .didFailEmailValidation:
                return NSLocalizedString("Invalid Email Address", comment: "The email address provided is not valid.")
            case .didFailNewPasswordValidation:
                return NSLocalizedString("Invalid Password", comment: "The new password provided does not meet the required criteria.")
            case .underlying(let error):
                return (error as? LocalizedError)?.failureReason ?? NSLocalizedString("Unknown Error", comment: "An unknown error occurred.")
            }
        }

        /// A localized message describing how one might recover from the failure.
        public var recoverySuggestion: String? {
            switch self {
            case .didFailEmailValidation:
                return NSLocalizedString("Please enter a valid email address.", comment: "Suggestion to correct the email address.")
            case .didFailNewPasswordValidation:
                return NSLocalizedString("Please enter a password that meets the criteria.", comment: "Suggestion to correct the new password.")
            case .underlying(let error):
                return (error as? LocalizedError)?.recoverySuggestion ?? NSLocalizedString("Please try again.", comment: "Generic recovery suggestion.")
            }
        }

        /// A localized message providing "help" text if the user requests help.
        public var helpAnchor: String? {
            switch self {
            case .didFailEmailValidation:
                return NSLocalizedString("Email Help", comment: "Help for email validation failure.")
            case .didFailNewPasswordValidation:
                return NSLocalizedString("Password Help", comment: "Help for password validation failure.")
            case .underlying(let error):
                return (error as? LocalizedError)?.helpAnchor ?? NSLocalizedString("Contact support for assistance.", comment: "Generic help suggestion.")
            }
        }
    }

}
