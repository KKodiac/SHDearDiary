import ComposableArchitecture

@Reducer
struct SignInCore {
    @ObservableState
    struct State {
        var email: String
        var password: String
    }
    
    enum Action: BindableAction {
        case didTapAppleSignInButton
        case didTapGoogleSignInButton
        
        case didTapLogInButton
        case didTapBackNavigationButton
        
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.dismiss) private var dismiss
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .didTapBackNavigationButton:
                return .run { _ in await dismiss() }
            default: return .none
            }
        }
    }
}
