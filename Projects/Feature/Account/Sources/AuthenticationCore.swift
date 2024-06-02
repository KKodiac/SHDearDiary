import ComposableArchitecture

@Reducer
public struct AuthenticationCore {
    @ObservableState
    public struct State {
        var email: String = ""
        var password: String = ""
    }
    
    public enum Action: BindableAction {
        case signInWithAppleTapped
        case signInWithGoogleTapped
        case signInWithEmailTapped
        
        case accountRecoveryTapped
        
        case navigateToBackTapped
        
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.dismiss) private var dismiss
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .signInWithGoogleTapped:
                return .none
            case .signInWithAppleTapped:
                return .none
            case .signInWithEmailTapped:
                return .none
            case .navigateToBackTapped:
                return .run { _ in await self.dismiss() }
            default:
                return .none
            }
        }
    }
}
