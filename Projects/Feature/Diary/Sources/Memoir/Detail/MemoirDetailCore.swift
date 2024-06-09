import ComposableArchitecture
import Domain
import Foundation

@Reducer
public struct MemoirDetailCore {
    @ObservableState
    public struct State {
        var content: String
        var entry: Entry
        var editable: Bool
        
        public init(content: String, entry: Entry, editable: Bool) {
            self.content = content
            self.entry = entry
            self.editable = editable
        }
    }
    
    public enum Action: BindableAction {
        case didAppear
        case didTapEditButton
        case didTapSaveButton
        case didTapBackButton
        
        case didTapNavigateToDiary
        
        case didFailDiaryLoggin
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
