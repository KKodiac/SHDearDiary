import Foundation

struct CreateRunRequest: Encodable {
    let assistantId: String
    let stream: Bool = true
}
