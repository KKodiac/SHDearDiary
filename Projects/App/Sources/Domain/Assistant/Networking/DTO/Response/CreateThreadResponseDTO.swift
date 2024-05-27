import Foundation

struct CreateThreadResponesDTO: Decodable {
    let id: String
    let object: String
    let createdAt: Int
    let metadata: [String: String]
}
