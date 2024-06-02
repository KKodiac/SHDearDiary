import AuthenticationServices
import ComposableArchitecture
import SwiftUI
import Shared

public struct AccountView: View {
    @Bindable var store: StoreOf<AccountCore>
    
    public init(store: StoreOf<AccountCore>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            ZStack {
                UserInterfaceAsset.ddPrimaryBackground.swiftUIColor.ignoresSafeArea()
                Text("Dear Diary").primaryTextStyle().offset(y: -50)
                
                VStack {
                    Spacer()
                    HStack(spacing: 25) {
                        CircularButton(image: UserInterfaceAsset.google) {
                            store.send(.signInWithGoogleTapped)
                        }
                        
                        CircularButton(image: UserInterfaceAsset.apple) {
                            store.send(.signInWithAppleTapped)
                        }
                    }
                    
                    PrimaryDivider()
                    
                    PrimaryButton(label: "Sign Up with Email") {
                        store.send(.signUpWithEmailTapped)
                    }
                    .padding(.vertical)
                    
                    HStack(spacing: 3) {
                        Text("Have an Existing Account?")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        
                        Button { store.send(.signInWithEmailTapped)
                        } label: { 
                            Text("Log In")
                                .font(UserInterfaceFontFamily.Pretendard.bold.swiftUIFont(size: 16))
                                .foregroundStyle(UserInterfaceAsset.ddAccent.swiftUIColor)
                        }
                    }
                }
                .padding(.all)
                .padding(.horizontal)
            }
        } destination: { store in
            if let store = store.scope(state: \.signIn, action: \.signIn) {
                AuthenticationView(store: store)
            } else
            if let store = store.scope(state: \.signUp, action: \.signUp) {
                RegistrationView(store: store)
            }
        }
    }
}
