import ComposableArchitecture

@Reducer
struct AppCore {
    @ObservableState
    struct State {
        @Presents var destination: Destination.State?
    }
    
    enum Action {
                
        case destination(PresentationAction<Destination.Action>)
    }
    
    var body: some ReducerOf<Self> {
        EmptyReducer()
    }
        
    @Reducer
    enum Destination {
    }
}
