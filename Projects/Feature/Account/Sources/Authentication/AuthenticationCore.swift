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
        
        var error: UserUseCase.DomainError?
        var isPresented: Bool
        
        public init(
            user: @autoclosure () -> String = "",
            email: String = "",
            password: String = "",
            isPresented: Bool = false,
            error: UserUseCase.DomainError? = nil
        ) {
            self._user = Shared(wrappedValue: user(), .appStorage("user"))
            self.email = email
            self.password = password
            self.isPresented = isPresented
            self.error = error
        }
    }
    
    public enum Action: BindableAction {
        case didTapSignInWithApple(AuthorizationController)
        case didTapSignInWithGoogle
        case didTapSignInWithEmail
        
        case didSucceedSignIn(User)
        case didTapNavigateToBack
        case didTapNavigateToSignUp
        
        case didFailDomainAction(UserUseCase.DomainError?)
        
        case navigateToSetUp
        case navigateToDiary
        
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.dismiss) private var dismiss
    @Dependency(\.user) private var user
    @Dependency(\.appleProvider) private var apple
    @Dependency(\.googleProvider) private var google
    
    // MARK: User Unique UID
    // MARK: Will be used to initialized unique ModelContainer for SwiftData
    @Shared(.appStorage("uid")) private var uid = ""
    
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
                    await send(.didSucceedSignIn(user))
                } catch: { error, send in
                    let error = error as? UserUseCase.DomainError
                    await send(.didFailDomainAction(error))
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
            case .didTapSignInWithGoogle:
                return .run { send in
                    let user = try await google.execute()
                    await send(.didSucceedSignIn(user))
                } catch: { error, send in
                    // TODO: Handle didFailSign
                    print(error)
                }
            case .didFailDomainAction(let error):
                if let error = error {
                    state.error = error
                    state.isPresented.toggle()
                }
                return .none
            case .didTapSignInWithApple(let controller):
                return .run { send in
                    let user = try await apple.execute(controller)
                    await send(.didSucceedSignIn(user))
                } catch: { error, send in
                    // TODO: Handle didFailSign
                    print(error)
                }
            case .didTapNavigateToBack:
                return .run { _ in await self.dismiss() }
            default:
                return .none
            }
        }
    }
}
