import Foundation

struct CreateMessageRequestDTO: Encodable {
    let role: Role
    let content: String
}
