import ComposableArchitecture
import SwiftUI
import Combine
import Domain
import OSLog


@Reducer
public struct SettingCore {
    public init() { }
    @ObservableState
    public struct State {
        
    }
    
    public enum Action {
        
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
            
        }
    }
}
