import ComposableArchitecture
import Domain

@Reducer
public struct DiaryDetailCore {
    public init() { }
    @ObservableState
    public struct State {
        var entry: Entry
        
        public init(entry: Entry) {
            self.entry = entry
        }
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
