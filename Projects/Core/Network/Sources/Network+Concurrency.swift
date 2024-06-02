import Foundation
import Moya

extension Network {
    public class NetworkConcurrency {
        private let provider: MoyaProvider<MultiTarget>
        
        init(provider: MoyaProvider<MultiTarget>) {
            self.provider = provider
        }
        
        func request<T: Decodable>(_ target: MultiTarget) async throws -> T {
            return try await withCheckedThrowingContinuation { continuation in
                provider.request(target) { result in
                    switch result {
                    case .success(let response):
                        guard let res = try? JSONDecoder.default.decode(T.self, from: response.data) else {
                            continuation.resume(throwing: MoyaError.jsonMapping(response))
                            return
                        }
                        continuation.resume(returning: res)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
        
        func request<T: Decodable>(for type: T.Type, target: MultiTarget) async throws -> T {
            return try await withCheckedThrowingContinuation { continuation in
                provider.request(target) { result in
                    switch result {
                    case .success(let response):
                        guard let res = try? JSONDecoder.default.decode(T.self, from: response.data) else {
                            continuation.resume(throwing: MoyaError.jsonMapping(response))
                            return
                        }
                        continuation.resume(returning: res)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
        
        func request<T: Decodable>(for type: T.Type, target: MultiTarget, progressHandler: @escaping (Double) -> Void) async throws -> T {
            return try await withCheckedThrowingContinuation { continuation in
                provider.request(target, progress: { response in
                    progressHandler(response.progress)
                }) { result in
                    switch result {
                    case .success(let response):
                        guard let res = try? JSONDecoder.default.decode(T.self, from: response.data) else {
                            continuation.resume(throwing: MoyaError.jsonMapping(response))
                            return
                        }
                        continuation.resume(returning: res)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    var async: NetworkConcurrency {
        NetworkConcurrency(provider: self.provider)
    }
}
