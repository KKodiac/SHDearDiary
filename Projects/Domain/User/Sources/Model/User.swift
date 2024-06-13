import Foundation

public struct User {
    public var uid: String
    public var email: String?
    public var name: String?
    public var isNewUser: Bool?
    
    public init(uid: String, email: String?, name: String?, isNewUser: Bool?) {
        self.uid = uid
        self.email = email
        self.name = name
        self.isNewUser = isNewUser
    }
}

