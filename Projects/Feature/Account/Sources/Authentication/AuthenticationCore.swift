import AuthenticationServices
import ComposableArchitecture
import Domain
import SwiftUI

@Reducer
public struct AuthenticationCore {
    @Dependency(\.appleProvider) private var apple
    @Dependency(\.googleProvider) private var google
    
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
        
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.dismiss) private var dismiss
    @Dependency(\.user) private var user
    
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
                    await send(.didFinishSignInWithEmail)
                } catch: { error, send in
                    let error = error as? UserUseCase.DomainError
                    await send(.didFailDomainAction(error))
                }
            case .didTapSignInWithGoogle:
                return .run { send in
                    let user = try await google.execute()
                }
            case .didTapSignInWithApple(let controller):
                return .run { send in
                    let user = try await apple.execute(controller)
                }
            case .didTapNavigateToBack:
                return .run { _ in await self.dismiss() }
            default:
                return .none
            }
        }
    }
}
