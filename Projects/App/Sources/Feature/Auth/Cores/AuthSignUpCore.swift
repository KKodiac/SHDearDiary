import ComposableArchitecture

@Reducer
struct SignUpCore {
    @ObservableState
    struct State {
        
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        EmptyReducer()
    }
}
