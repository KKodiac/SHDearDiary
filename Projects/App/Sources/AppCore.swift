import ComposableArchitecture
import Feature

@Reducer
struct AppCore {
    @ObservableState
    struct State {
        @Presents var destination: Destination.State?
    }
    
    enum Action {
        case onAppear
        case destination(PresentationAction<Destination.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
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
        case home
    }
}
