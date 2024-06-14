import Foundation

struct CreateMessageRequest: Encodable {
    let role: Role
    let content: String
}
