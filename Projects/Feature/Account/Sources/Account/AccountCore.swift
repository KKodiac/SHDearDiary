import AuthenticationServices
import ComposableArchitecture
import Domain
import Foundation
import SwiftUI

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
        case didTapSignInWithApple(AuthorizationController)
        case didTapSignInWithEmail
        case didTapSignUpWithEmail
        
        case didAppear
        case didAppInitialize
        case didReceiveOpenURL(URL)
        case didSucceedSignIn(User)
        
        case navigateToSetUp
        case navigateToDiary
        
        case binding(BindingAction<State>)
        case destination(PresentationAction<Destination.Action>)
    }
    
    @Reducer
    public enum Destination {
        case signIn(AuthenticationCore)
        case signUp(RegistrationCore)
        case setUp(SetUpCore)
    }
    
    @Dependency(\.appleProvider) private var apple
    @Dependency(\.googleProvider) private var google
    @Shared(.appStorage("uid")) private var uid = ""
    
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
                    await send(.didSucceedSignIn(user))
                } catch: { error, send in
                    // TODO: Handle didFailSignIn
                    print(error)
                }
            case .didTapSignInWithApple(let controller):
                return .run { send in
                    let user = try await apple.execute(controller)
                    await send(.didSucceedSignIn(user))
                } catch: { error, send in
                    // TODO: Handle didFailSignIn
                    print(error)
                }
            case .didSucceedSignIn(let user):
                uid = user.uid
                return .run { send in
                    if let isNewUser = user.isNewUser, isNewUser {
                        await send(.navigateToSetUp)
                    } else {
                        await send(.navigateToDiary)
                    }
                }
            case .navigateToSetUp:
                state.destination = .setUp(SetUpCore.State())
                return .none
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
            case .destination(.presented(.signUp(.navigateToSetUp))):
                state.destination = .setUp(SetUpCore.State())
                return .none
            case .destination(.presented(.signIn(.navigateToSetUp))):
                state.destination = .setUp(SetUpCore.State())
                return .none
            default:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

