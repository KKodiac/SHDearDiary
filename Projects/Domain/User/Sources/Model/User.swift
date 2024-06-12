import Foundation

public struct User {
    public var email: String?
    public var name: String?
    public var isNewUser: Bool?
    
    public init(email: String?, name: String?, isNewUser: Bool?) {
        self.email = email
        self.name = name
        self.isNewUser = isNewUser
    }
}

