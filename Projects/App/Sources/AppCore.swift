import ComposableArchitecture
import Feature

@Reducer
struct AppCore {
    @ObservableState
    struct State {
        @Presents var destination: Destination.State?
    }
    
    enum Action {
        case didAppear
        case navigateToFeature
        case destination(PresentationAction<Destination.Action>)
    }
    
    @Dependency(\.continuousClock) private var runner
    @Shared(.appStorage("uid")) private var uid = ""
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didAppear:
                return .run { send in
                    try await runner.sleep(for: .seconds(1))   
                    await send(.navigateToFeature)
                }.animation(.easeIn)
            case .navigateToFeature:
                if uid.isEmpty { state.destination = .auth(AccountCore.State()) }
                else { state.destination = .diary(DiaryCore.State()) }
                return .none
            case .destination(.presented(.auth(.navigateToDiary))):
                state.destination = .diary(DiaryCore.State())
                return .none
            default:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
        
    @Reducer
    enum Destination {
        case auth(AccountCore)
        case diary(DiaryCore)
    }
}
