import ComposableArchitecture
import SwiftUI
import Combine
import Domain
import OSLog


@Reducer
public struct MemoirCore {
    @ObservableState
    public struct State {
        var memoirText: String = "Hi"
        var chatInitialized: Bool = false
        var dialogues: [Dialogue] = []
        var progress: Double = 0.0
        var threadId: String?
        var dialogue: String = ""
        @Presents var destination: Destination.State?
    }
    
    public enum Action: BindableAction {
        case didTapNavigateToBack
        
        case binding(BindingAction<State>)
        case destination(PresentationAction<Destination.Action>)
    }
    
    @Reducer
    public enum Destination {
        case detail(MemoirDetailCore)
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
        .ifLet(\.$destination, action: \.destination)
    }
}
