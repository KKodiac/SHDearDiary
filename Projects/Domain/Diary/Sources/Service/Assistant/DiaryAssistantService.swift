import Core
import ComposableArchitecture
import Foundation
import SwiftData
import Moya

protocol AssistantServiceProvider {
    func start() async throws
    func send(message: String) async throws -> CreateMessageResponse
    func run() async throws -> CreateRunResponse
    func fetch() async throws -> FetchMessagesResponse
    func runStream() async throws -> (URLSession.AsyncBytes, URLResponse)
}

final class AssistantService: AssistantServiceProvider {
    @Shared(.appStorage("ThreadId")) var threadId = ""
    
    private var network: Network
    
    private static let plugins: [PluginType] = [
        NetworkLoggerPlugin(),
        AccessTokenPlugin(tokenClosure: { target in PropertyReader.assistantId })
    ]
    
    enum AssistantError: Error {
        case failedThreadIdFetch
        case invalidURL
    }
    
    init(network: Network = Network(provider: .init(plugins: plugins))) {
        self.network = network
    }
    
    func start() async throws {
        let data: CreateThreadResponse = try await network.async.request(
            .target(AssistantClient.createThread)
        )
        threadId = data.id
    }
    
    func send(message: String) async throws -> CreateMessageResponse {
        return try await network.async.request(
            .target(AssistantClient.createMessage(
                threadId: threadId, 
                dto: CreateMessageRequest(role: .user, content: message))
            )
        )
    }
    
    func run() async throws -> CreateRunResponse {
        return try await network.async.request(
            .target(AssistantClient.createRun(
                threadId: threadId,
                assistantId: PropertyReader.assistantId)
            )
        )
    }
    
    func fetch() async throws -> FetchMessagesResponse {
        return try await network.async.request(
            .target(AssistantClient.fetchOne(
                threadId: threadId)
            )
        )
    }
    
    func runStream() async throws -> (URLSession.AsyncBytes, URLResponse) {
        guard let url = URL(string: "https://api.openai.com/v1/threads/\(threadId)/runs") else {
            throw AssistantError.invalidURL
        }
        
        let encodable = CreateRunRequest(assistantId: PropertyReader.assistantId)
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
