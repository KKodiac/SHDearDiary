import Foundation

struct CreateMessageResponseDTO: Decodable {
    let id: String
    let object: String
    let createdAt: Int64
    let assistantId: String?
    let threadId: String
    let runId: String?
    let role: Role
    let content: [MessageContent]
    let fileIds: [String]
    let metadata: [String: String]
    
}

struct MessageContent: Decodable {
    let type: String
    let text: MessageContentText
}

struct MessageContentText: Decodable {
    let value: String
    let annotations: [String]
}
