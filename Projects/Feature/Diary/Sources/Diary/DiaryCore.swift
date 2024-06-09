import ComposableArchitecture
import SwiftUICalendar
import Foundation
import SwiftData
import Domain

@Reducer
struct DiaryCore {
    @Dependency(\.dismiss) private var dismiss
    
    @ObservableState
    struct State {
        var focusDate: YearMonthDay = YearMonthDay.current
        var isPresented: Bool = true
        var dialogues: [Dialogue] = []
        var focusedEntries: [Entry] = []
        var path = StackState<Path.State>()
    }
    
    enum Action: BindableAction {
        case diaryCardTapped(Entry)
        case settingsTapped
        case memoirTapped
        case onSuccessfulFetch([Entry])
        
        case calendarDateTapped(YearMonthDay)
        case fetchSelectedMemoir
        case backNavigationTapped
        
        case binding(_ action: BindingAction<State>)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .fetchSelectedMemoir:
                return .none
            case let .onSuccessfulFetch(entries):
                state.focusedEntries = entries
                return .none
            case let .calendarDateTapped(date):
                state.focusDate = (date != state.focusDate ? date : YearMonthDay.current)
                return .send(.fetchSelectedMemoir)
            case .diaryCardTapped(let entry):
                state.path.append(.detail(.init(entry: entry)))
                return .none
            case .memoirTapped:
                
                return .none
            case .backNavigationTapped:
                return .run { _ in
                    await dismiss()
                }
            default:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            Path()
        }
    }
    
    @Reducer
    struct Path {
        @ObservableState
        enum State {
            case settings
            case detail(DiaryDetailCore.State)
            case log(MemoirCore.State)
        }
        
        enum Action: BindableAction {
            case settings
            case detail(DiaryDetailCore.Action)
            case log(MemoirCore.Action)
            
            case binding(_ action: BindingAction<State>)
        }
        
        var body: some ReducerOf<Self> {
            BindingReducer()
            Scope(state: \.log, action: \.log) {
                MemoirCore()
            }
            Scope(state: \.detail, action: \.detail) {
                DiaryDetailCore()
            }
        }
    }
}
