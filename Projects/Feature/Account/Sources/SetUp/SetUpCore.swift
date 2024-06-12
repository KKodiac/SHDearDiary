import ComposableArchitecture
import Foundation
import Domain

@Reducer
public struct SetUpCore {
    public init() { }
    
    @ObservableState
    public struct State {
        var isExpanded: Bool
        var name: String
        var selectedPersonality: Personality
        var personalities: [Personality]
        
        public init(
            isExpanded: Bool = false,
            name: String = "",
            selectedPersonality: Personality = .none,
            personalities: [Personality] = Personality.allCases
        ) {
            self.isExpanded = isExpanded
            self.name = name
            self.selectedPersonality = selectedPersonality
            self.personalities = personalities
        }
    }
    
    public enum Action: BindableAction {
        case didTapPersonalityPicker(Personality, Bool)
        case didTapGetStarted
        
        case navigateToDiary
        
        case binding(_ action: BindingAction<State>)
    }
    
    @Dependency(\.defaultAppStorage) var appStorage
    
    public var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .didTapPersonalityPicker(let personality, let expandedState):
                state.selectedPersonality = personality
                state.isExpanded = expandedState
                return .none
            case .didTapGetStarted:
                return .send(.navigateToDiary)
            default:
                return .none
            }
        }
    }
    
}
