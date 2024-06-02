import ComposableArchitecture
import SwiftUI
import Shared

public struct AuthenticationView: View {
    @Bindable var store: StoreOf<AuthenticationCore>
    
    public var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("Welcome Back").primaryTextStyle().padding(.bottom)
                
                HStack(spacing: 25) {
                    CircularButton(image: UserInterfaceAsset.google) {
                        store.send(.signInWithGoogleTapped)
                    }
                    CircularButton(image: UserInterfaceAsset.apple) {
                        store.send(.signInWithAppleTapped)
                    }
                }
                
                PrimaryDivider()
                
                Form {
                    VStack {
                        Text("Email")
                        TextField("", text: $store.email, prompt: Text("Your email..."))
                    }
                }
            }
        }
    }
}
