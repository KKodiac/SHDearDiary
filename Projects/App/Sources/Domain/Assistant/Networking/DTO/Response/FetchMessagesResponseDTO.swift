import Foundation

struct FetchMessagesResponseDTO: Decodable {
    let object: String
    let data: [CreateMessageResponseDTO]
    let firstId: String
    let lastId: String
    let hasMore: Bool
    
}
