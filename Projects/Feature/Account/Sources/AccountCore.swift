import ComposableArchitecture
import Foundation

@Reducer
public struct AccountCore {
    public init() { }
    @ObservableState
    public struct State {
        var path = StackState<Path.State>()
        
        public init() { }
    }
    
    public enum Action: BindableAction {
        case signInWithGoogleTapped
        case signInWithAppleTapped
        case signInWithEmailTapped
        case signUpWithEmailTapped
        case binding(BindingAction<State>)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    @Reducer
    public enum Path {
        case signIn(AuthenticationCore)
        case signUp(RegistrationCore)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}

