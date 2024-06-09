import ComposableArchitecture
import Domain

@Reducer
public struct DiaryDetailCore {
    
    @ObservableState
    public struct State {
        var entry: Entry
    }
    
    public enum Action: BindableAction {
        case didTapNavigateToBack
        
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.dismiss) var dismiss
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .didTapNavigateToBack:
                return .run { _ in await dismiss() }
            default:
                return .none
            }
        }
    }
}
