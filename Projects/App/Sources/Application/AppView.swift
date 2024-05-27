import ComposableArchitecture
import SwiftUI
import Shared

struct AppView: View {
    @Bindable var store: StoreOf<AppCore>
    
    var body: some View {
        ZStack {
            UserInterfaceAsset.ddPrimaryBackground.swiftUIColor.ignoresSafeArea()
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}
