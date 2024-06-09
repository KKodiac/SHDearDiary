import ComposableArchitecture
import Foundation

@Reducer
public struct AccountCore {
    public init() { }
    
    @ObservableState
    public struct State {
        @Presents var destination: Destination.State?
        
        public init() { }
    }
    
    public enum Action: BindableAction {
        case didTapSignInWithGoogle
        case didTapSignInWithApple
        case didTapSignInWithEmail
        case didTapSignUpWithEmail
        
        case binding(BindingAction<State>)
        case destination(PresentationAction<Destination.Action>)
    }
    
    @Reducer
    public enum Destination {
        case signIn(AuthenticationCore)
        case signUp(RegistrationCore)
        case setUp(SetUpCore)
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .didTapSignUpWithEmail:
                state.destination = .signUp(RegistrationCore.State())
                return .none
            case .didTapSignInWithEmail:
                state.destination = .signIn(AuthenticationCore.State())
                return .none
            case .destination(.presented(.signUp(.didTapNavigateToSignIn))):
                state.destination = .signIn(AuthenticationCore.State())
                return .none
            case .destination(.presented(.signIn(.didTapNavigateToSignUp))):
                state.destination = .signUp(RegistrationCore.State())
                return .none
            default:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

