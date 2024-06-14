import ComposableArchitecture
import Domain
import Firebase

@Reducer
public struct RegistrationCore {
    @ObservableState
    public struct State {
        var email: String
        var name: String
        var password: String
        var confirmPassword: String
        
        var error: UserUseCase.DomainError?
        var isPresented: Bool
        
        init(
            email: String = "",
            name: String = "",
            password: String = "",
            confirmPassword: String = "",
            isPresented: Bool = false,
            error: UserUseCase.DomainError? = nil
        ) {
            self.email = email
            self.name = name
            self.password = password
            self.confirmPassword = confirmPassword
            self.isPresented = isPresented
            self.error = error
        }
    }
    
    public enum Action: BindableAction {
        case didTapSignUpWithEmail
        
        case didSucceedSignUp(DomainUser.User)
        case didFailDomainAction(UserUseCase.DomainError?)
        
        case didTapNavigateToBack
        case didTapNavigateToSignIn
        
        case navigateToSetUp
        case navigateToDiary
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.dismiss) private var dismiss
    @Dependency(\.user) private var user
    
    // MARK: User Unique UID
    // MARK: Will be used to initialized unique ModelContainer for SwiftData
    @Shared(.appStorage("uid")) private var uid = ""
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .didTapSignUpWithEmail:
                return .run { [state] send in
                    let user = try await user.register(
                        RegistrationForm(
                            name: state.name,
                            username: state.email,
                            password: state.password,
                            confirmPassword: state.confirmPassword
                        ).validated()
                    )
                    await send(.didSucceedSignUp(user))
                } catch: { error, send in
                    let error = error as? UserUseCase.DomainError
                    await send(.didFailDomainAction(error))
                }
            case .didFailDomainAction(let error):
                if let error = error {
                    state.error = error
                    state.isPresented.toggle()
                }
                return .none
            case .didSucceedSignUp(let user):
                uid = user.uid
                return .run { send in
                    if let isNewUser = user.isNewUser, isNewUser {
                        await send(.navigateToSetUp)
                    } else {
                        await send(.navigateToDiary)
                    }
                }
            case .didTapNavigateToBack:
                return .run { _ in await dismiss() }
            default:
                return .none
            }
        }
    }
}
