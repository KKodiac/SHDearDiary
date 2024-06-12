import ComposableArchitecture
import SwiftUICalendar
import Foundation
import SwiftData
import Domain

@Reducer
public struct DiaryCore {
    @Dependency(\.dismiss) private var dismiss
    
    @ObservableState
    public struct State {
        var focusDate: YearMonthDay
        var isPresented: Bool
        var dialogues: [Dialogue]
        var focusedEntries: [Entry]
        var path = StackState<Path.State>()
        
        public init(
            focusDate: YearMonthDay = YearMonthDay.current,
            isPresented: Bool = true,
            dialogues: [Dialogue] = [],
            focusedEntries: [Entry] = []
        ) {
            self.focusDate = focusDate
            self.isPresented = isPresented
            self.dialogues = dialogues
            self.focusedEntries = focusedEntries
        }
    }
    
    public enum Action: BindableAction {
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
    
    public var body: some ReducerOf<Self> {
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
    public struct Path {
        @ObservableState
        public enum State {
            case settings
            case detail(DiaryDetailCore.State)
            case log(MemoirCore.State)
        }
        
        public enum Action: BindableAction {
            case settings
            case detail(DiaryDetailCore.Action)
            case log(MemoirCore.Action)
            
            case binding(_ action: BindingAction<State>)
        }
        
        public var body: some ReducerOf<Self> {
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
