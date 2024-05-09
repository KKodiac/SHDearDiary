import ComposableArchitecture
import SwiftUI

struct AppView: View {
    @Bindable var store: StoreOf<AppCore>
    
    var body: some View {
        EmptyView()
    }
}
