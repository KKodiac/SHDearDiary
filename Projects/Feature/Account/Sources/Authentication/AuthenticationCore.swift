import AuthenticationServices
import ComposableArchitecture
import Domain
import SwiftUI

@Reducer
public struct AuthenticationCore {
    
    @ObservableState
    public struct State {
        @Shared var user: String
        var email: String
        var password: String
        
        public init(
            user: @autoclosure () -> String = "",
            email: String = "",
            password: String = ""
        ) {
            self._user = Shared(wrappedValue: user(), .appStorage("user"))
            self.email = email
            self.password = password
        }
    }
    
    public enum Action: BindableAction {
        case didTapSignInWithApple(AuthorizationController)
        case didTapSignInWithGoogle
        case didTapSignInWithEmail
        
        case didFinishSignInWithEmail
        case didTapNavigateToBack
        case didTapNavigateToSignUp
        
        case didFailDomainAction(UserUseCase.DomainError?)
        
        case navigateToSetup
        
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.dismiss) private var dismiss
    @Dependency(\.user) private var user
    @Dependency(\.appleProvider) private var apple
    @Dependency(\.googleProvider) private var google
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .didTapSignInWithEmail:
                return .run { [state] send in
                    let user = try await user.authenticate(
                        AuthenticationForm(
                            username: state.email,
                            password: state.password
                        ).validated()
                    )
                    if let isNewUser = user.isNewUser, isNewUser {
                        await send(.navigateToSetup)
                    }
                    await send(.didFinishSignInWithEmail)
                } catch: { error, send in
                    let error = error as? UserUseCase.DomainError
                    await send(.didFailDomainAction(error))
                }
            case .didTapSignInWithGoogle:
                return .run { send in
                    let user = try await google.execute()
                    if let isNewUser = user.isNewUser, isNewUser {
                        await send(.navigateToSetup)
                    }
                    await send(.didFinishSignInWithEmail)
                }
            case .didTapSignInWithApple(let controller):
                return .run { send in
                    let user = try await apple.execute(controller)
                    if let isNewUser = user.isNewUser, isNewUser {
                        await send(.navigateToSetup)
                    }
                    await send(.didFinishSignInWithEmail)
                }
            case .didTapNavigateToBack:
                return .run { _ in await self.dismiss() }
            default:
                return .none
            }
        }
    }
}
