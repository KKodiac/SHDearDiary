import Foundation

struct OpenAICredential: Decodable {
    let openAIToken: String
    let assistantID: String
    
    enum CodingKeys: String, CodingKey {
        case openAIToken = "OpenAIToken"
        case assistantID = "AssistantID"
    }
}
