import ComposableArchitecture

@Reducer
public struct AuthenticationCore {
    @ObservableState
    public struct State {
        var email: String = ""
        var password: String = ""
    }
    
    public enum Action: BindableAction {
        case didTapSignInWithApple
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
            case .didTapNavigateToBack:
                return .run { _ in await self.dismiss() }
            default:
                return .none
            }
        }
    }
}
