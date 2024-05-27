import Dependencies
import Foundation
import SwiftData
import Moya

protocol AssistantServiceProvider {
    func start() async throws
    func send(message: String) async throws -> CreateMessageResponseDTO
    func run() async throws -> CreateRunResponseDTO
    func fetch() async throws -> FetchMessagesResponseDTO
    func runStream() async throws -> (URLSession.AsyncBytes, URLResponse)
}

final class AssistantService: AssistantServiceProvider {
    
    private static let plugins: [PluginType] = [
        NetworkLoggerPlugin(),
        AccessTokenPlugin(tokenClosure: { target in PropertyReader.assistantId })
    ]
    
    enum AssistantError: Error {
        case failedThreadIdFetch
        case invalidURL
    }
    
    init(
        defaults: UserDefaults = UserDefaults.standard,
        network: MoyaProvider<AssistantClient> = MoyaProvider<AssistantClient>(plugins: plugins)
    ) {
        self.defaults = defaults
        self.network = network
    }
    
    private let network: MoyaProvider<AssistantClient>
    private let defaults: UserDefaults
    
    func start() async throws {
        let data = try await network.async.request(
            for: CreateThreadResponesDTO.self,
            target: .createThread
        )
        
        defaults.set(data.id, forKey: .assistantThreadId)
    }
    
    func send(message: String) async throws -> CreateMessageResponseDTO {
        guard let threadId = defaults.string(forKey: .assistantThreadId) else {
            throw AssistantError.failedThreadIdFetch
        }
        
        return try await network.async.request(
            .createMessage(
                threadId: threadId,
                dto: CreateMessageRequestDTO(
                    role: .user,
                    content: message
                )
            )
        )
    }
    
    func run() async throws -> CreateRunResponseDTO {
        guard let threadId = defaults.string(forKey: .assistantThreadId) else {
            throw AssistantError.failedThreadIdFetch
        }
        
        return try await network.async.request(
            .createRun(
                threadId: threadId,
                assistantId: PropertyReader.assistantId
            )
        )
    }
    
    func fetch() async throws -> FetchMessagesResponseDTO {
        guard let threadId = defaults.string(forKey: .assistantThreadId) else {
            throw AssistantError.failedThreadIdFetch
        }
        
        return try await network.async.request(.fetchOne(threadId: threadId))
    }
    
    func runStream() async throws -> (URLSession.AsyncBytes, URLResponse) {
        guard let threadId = defaults.string(forKey: .assistantThreadId) else {
            throw AssistantError.failedThreadIdFetch
        }
        
        guard let url = URL(string: "https://api.openai.com/v1/threads/\(threadId)/runs") else {
            throw AssistantError.invalidURL
        }
        
        let encodable = CreateRunRequestDTO(assistantId: PropertyReader.assistantId)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder.default.encode(encodable)
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(PropertyReader.openAIToken)",
            "OpenAI-Beta": "assistants=v1"
        ]
        
        return try await URLSession.shared.bytes(for: request)
    }
}
