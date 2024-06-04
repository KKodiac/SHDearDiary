import Core
import Dependencies
import Foundation
import Moya

extension DependencyValues {
    var assistant: AssistantServiceProvider {
        get { self[AssistantService.self] }
        set { self[AssistantService.self] = newValue }
    }
}

extension AssistantService: DependencyKey {
    static var liveValue: AssistantServiceProvider = AssistantService()
    
    static var testValue: AssistantServiceProvider = AssistantService(
        network: Network(
            provider: MoyaProvider(stubClosure: MoyaProvider.immediatelyStub)
        )
    )
}
