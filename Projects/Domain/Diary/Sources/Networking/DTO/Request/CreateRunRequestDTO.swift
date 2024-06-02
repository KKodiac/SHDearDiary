import Foundation

struct CreateRunRequestDTO: Encodable {
    let assistantId: String
    let stream: Bool = true
}
