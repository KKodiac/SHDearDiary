import ComposableArchitecture
import Foundation
import Domain

@Reducer
public struct SetUpCore {
    public init() { }
    
    @ObservableState
    public struct State {
        var expanded: Bool
        var personalities: [Personality]
        
        @Shared var name: String
        @Shared var personality: Personality
        
        public init(
            expanded: Bool = false,
            personalities: [Personality] = Personality.allCases,
            name: @autoclosure () -> String = "",
            personality: @autoclosure () -> Personality = .none
        ) {
            self.expanded = expanded
            self.personalities = personalities
            self._name = Shared(wrappedValue: name(), .appStorage("diary_name"))
            self._personality = Shared(wrappedValue: personality(), .appStorage("diary_personality"))
        }
    }
    
    public enum Action: BindableAction {
        case didTapPicker(_ personality: Personality)
        case didTapGetStarted
        
        case navigateToDiary
        
        case binding(_ action: BindingAction<State>)
    }
    
    public var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case let .didTapPicker(personality):
                state.personality = personality
                state.expanded.toggle()
                return .none
            case .didTapGetStarted:
                return .send(.navigateToDiary)
            default:
                return .none
            }
        }
    }
    
}
