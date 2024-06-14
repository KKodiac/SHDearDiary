import Foundation

struct CreateThreadResponse: Decodable {
    let id: String
    let object: String
    let createdAt: Int
    let metadata: [String: String]
}
