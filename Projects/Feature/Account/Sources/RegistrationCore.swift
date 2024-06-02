import ComposableArchitecture

@Reducer
public struct RegistrationCore {
    @ObservableState
    public struct State {
        
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.dismiss) private var dismiss
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
    }
}
