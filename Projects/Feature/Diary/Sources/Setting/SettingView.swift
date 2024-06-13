import ComposableArchitecture
import SwiftUI

public struct SettingView: View {
    @Bindable var store: StoreOf<SettingCore>
    
    public init(store: StoreOf<SettingCore>) {
        self.store = store
    }
    
    public var body: some View {
        EmptyView()
    }
}
