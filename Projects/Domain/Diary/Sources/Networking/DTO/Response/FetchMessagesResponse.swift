import Foundation

struct FetchMessagesResponse: Decodable {
    let object: String
    let data: [CreateMessageResponse]
    let firstId: String
    let lastId: String
    let hasMore: Bool
    
}
