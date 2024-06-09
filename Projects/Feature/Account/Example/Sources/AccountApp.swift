import ComposableArchitecture
import SwiftUI
import Account

@main
struct AccountApp: App {
    @Bindable private var store: StoreOf<AccountCore> = .init(initialState: AccountCore.State()) { AccountCore() }
    
    var body: some Scene {
        WindowGroup {
            AccountView(store: store)
        }
    }
}
