import AuthenticationServices
import ComposableArchitecture
import Foundation
import SwiftUI

@Reducer
public struct AccountCore {
    @Dependency(\.appleProvider) private var apple
    @Dependency(\.googleProvider) private var google
    
    public init() { }
    
    @ObservableState
    public struct State {
        @Presents var destination: Destination.State?
        
        public init() { }
    }
    
    public enum Action: BindableAction {
        case didTapSignInWithGoogle
        case didTapSignInWithApple(AuthorizationController)
        case didTapSignInWithEmail
        case didTapSignUpWithEmail
        
        case didAppear
        case didReceiveOpenURL(URL)
        
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
            case .didAppear:
                google.initialize()
                return .none
            case .didReceiveOpenURL(let url):
                google.handleURL(url)
                return .none
            case .didTapSignInWithGoogle:
                return .run { send in
                    let user = try await google.execute()
                }
            case .didTapSignInWithApple(let controller):
                return .run { send in
                    let user = try await apple.execute(controller)
                }
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

