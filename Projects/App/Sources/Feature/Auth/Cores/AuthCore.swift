import ComposableArchitecture

@Reducer
struct AuthCore {
    @ObservableState
    struct State {
        @Presents var destination: Destination.State?
    }
    
    enum Action: BindableAction {
        case didTapSignInButton
        case didTapAppleSignInButton
        case didTapGoogleSignInButton
        case didTapSignUpButton
        
        case binding(BindingAction<State>)
        case destination(PresentationAction<Destination.Action>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .didTapSignInButton:
                state.destination = .signIn(SignInCore.State())
                return .none
            case .didTapSignUpButton:
                state.destination = .signUp(SignUpCore.State())
                return .none
            default:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
    
    @Reducer
    enum Destination {
        case home(AuthCore)
        case signIn(SignInCore)
        case signUp(SignUpCore)
    }
}
