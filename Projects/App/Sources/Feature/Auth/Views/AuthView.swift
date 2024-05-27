import ComposableArchitecture
import SwiftUI
import Shared

struct AuthView: View {
    @Bindable var store: StoreOf<AuthCore>
    
    var body: some View {
        if let store = store.scope(state: \.destination?.home, action: \.destination.home) {
            AuthHomeView(store: store)
        }
        if let store = store.scope(state: \.destination?.signIn, action: \.destination.signIn) {
            SignInView(store: store)
        }
        if let store = store.scope(state: \.destination?.signUp, action: \.destination.signUp) {
            SignUpView(store: store)
        }
    }
}

#Preview {
    AuthView(store: .init(initialState: AuthCore.State(), reducer: { AuthCore() }))
}
