import AuthenticationServices
import ComposableArchitecture
import SwiftUI

@Reducer
public struct AuthenticationCore {
    @Dependency(\.appleProvider) private var apple
    @Dependency(\.googleProvider) private var google
    
    @ObservableState
    public struct State {
        var email: String = ""
        var password: String = ""
    }
    
    public enum Action: BindableAction {
        case didTapSignInWithApple(AuthorizationController)
        case didTapSignInWithGoogle
        case didTapSignInWithEmail
        
        
        case didTapNavigateToBack
        case didTapNavigateToSignUp
        
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.dismiss) private var dismiss
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .didTapSignInWithGoogle:
                return .run { send in
                    let user = try await google.execute()
                }
            case .didTapSignInWithApple(let controller):
                return .run { send in
                    let user = try await apple.execute(controller)
                }
            case .didTapNavigateToBack:
                return .run { _ in await self.dismiss() }
            default:
                return .none
            }
        }
    }
}
