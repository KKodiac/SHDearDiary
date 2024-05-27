import Foundation

struct CreateRunResponseDTO: Decodable {
    let id: String
    let object: String
    let createdAt: Int
    let assistantId: String
    let threadId: String
    let status: String
    let startedAt: Int
    let expiresAt: Int?
    let cancelledAt: Int?
    let failedAt: Int?
    let completedAt: Int
    let lastError: String?
    let model: String
    let instructions: String?
    let incompleteDetails: String?
    let tools: [Tool]
    let fileIds: [String]
    let metadata: [String: String]
    let usage: String?
    let temperature: Int
    let maxPromptTokens: Int
    let maxCompletionTokens: Int
    let truncationStrategy: TruncationStrategy
    let responseFormat: String
    let toolChoice: String
    
    struct Tool: Decodable {
        let type: String
    }
    
    struct TruncationStrategy: Decodable {
        let type: String
        let lastMessages: [String]?
    }
}
