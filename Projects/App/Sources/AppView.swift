import ComposableArchitecture
import SwiftUI
import Feature
import Shared

struct AppView: View {
    @Bindable var store: StoreOf<AppCore>
    
    var body: some View {
        ZStack {
            UserInterfaceAsset.ddPrimaryBackground.swiftUIColor.ignoresSafeArea()
            AccountView(store: StoreOf<AccountCore>(initialState: AccountCore.State()) {
                AccountCore()
            })
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}
