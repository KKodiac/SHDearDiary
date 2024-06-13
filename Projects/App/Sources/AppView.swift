import ComposableArchitecture
import Feature
import SwiftUI
import Shared

struct AppView: View {
    @Bindable var store: StoreOf<AppCore>
    
    var body: some View {
        NavigationStack {
            ZStack {
                UserInterfaceAsset.ddPrimaryBackground.swiftUIColor.ignoresSafeArea()
                Text("Dear Diary").primaryTextStyle().offset(y: -50)
                if let store = store.scope(state: \.destination?.auth, action: \.destination.auth) {
                    AccountView(store: store)
                }
            }
            .onAppear {
                store.send(.didAppear)
            }
            .navigationDestination(
                item: $store.scope(
                    state: \.destination?.diary,
                    action: \.destination.diary
                )
            ) { store in
                DiaryView(store: store)
                    .navigationBarBackButtonHidden()
            }
        }
    }
}
