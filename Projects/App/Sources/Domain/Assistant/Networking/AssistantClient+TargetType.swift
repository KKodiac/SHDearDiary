import Foundation
import Moya

extension AssistantClient: TargetType, AccessTokenAuthorizable {
    var baseURL: URL {
        URL(string: "https://api.openai.com/v1")!
    }
    
    var path: String {
        switch self {
        case .createThread:
            return "/threads"
        case let .createMessage(threadId, _):
            return "/threads/\(threadId)/messages"
        case let .createRun(threadId, _):
            return "/threads/\(threadId)/runs"
        case let .fetchOne(threadId):
            return "/threads/\(threadId)/messages"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchOne: .get
        default: .post
        }
    }
    var task: Moya.Task {
        switch self {
        case .createThread:
            return .requestPlain
        case let .createMessage(_, dto):
            return .requestCustomJSONEncodable(dto, encoder: JSONEncoder.default)
        case let .createRun(_, assistantId):
            return .requestCustomJSONEncodable(assistantId, encoder: JSONEncoder.default)
        case .fetchOne:
            return .requestParameters(parameters: ["limit": 1], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "OpenAI-Beta": "assistants=v1"
        ]
    }
    
    var authorizationType: AuthorizationType? {
        return .bearer
    }
}
