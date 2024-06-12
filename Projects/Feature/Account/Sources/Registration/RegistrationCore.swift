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
        case didTapSignUpWithEmail
        
        case didFinishSignUpWithEmail(DomainUser.User)
        
        
        case didFailDomainAction(UserUseCase.DomainError?)
        
        case didTapNavigateToBack
        case didTapNavigateToSignIn
        case didRequireNewSetup
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.dismiss) private var dismiss
    @Dependency(\.user) private var user
    
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
                    if let isNewUser = user.isNewUser, isNewUser {
                        await send(.didRequireNewSetup)
                    }
                    await send(.didFinishSignUpWithEmail(user))
                } catch: { error, send in
                    let error = error as? UserUseCase.DomainError
                    await send(.didFailDomainAction(error))
                }
            case .didFinishSignUpWithEmail(let user):
                return .none
            case .didTapNavigateToBack:
                return .run { _ in await dismiss() }
            default:
                return .none
            }
        }
    }
}
