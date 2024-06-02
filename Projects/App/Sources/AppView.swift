import ComposableArchitecture
import Feature
import SwiftUI
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
