import ComposableArchitecture

@Reducer
public struct RegistrationCore {
    @ObservableState
    public struct State {
        var email: String
        var name: String
        var password: String
        var confirmPassword: String
        
        init(
            email: String = "",
            name: String = "",
            password: String = "",
            confirmPassword: String = ""
        ) {
            self.email = email
            self.name = name
            self.password = password
            self.confirmPassword = confirmPassword
        }
    }
    
    public enum Action: BindableAction {
        case didTapNavigateToBack
        case didTapNavigateToSignIn
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.dismiss) private var dismiss
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .didTapNavigateToBack:
                return .run { _ in await dismiss() }
            default:
                return .none
            }
        }
    }
}
