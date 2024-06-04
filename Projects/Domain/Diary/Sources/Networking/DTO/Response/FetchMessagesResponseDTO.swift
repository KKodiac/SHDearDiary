import Foundation

struct FetchMessagesResponseDTO: Decodable {
    let object: String
    let data: [CreateMessageResponse]
    let firstId: String
    let lastId: String
    let hasMore: Bool
    
}
