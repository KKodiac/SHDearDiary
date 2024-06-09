import AuthenticationServices
import ComposableArchitecture
import SwiftUI
import Shared

public struct AccountView: View {
    @Bindable var store: StoreOf<AccountCore>
    
    public init(store: StoreOf<AccountCore>) {
        self.store = store
    }
    
    @ViewBuilder
    public var socialSection: some View {
        HStack(spacing: 25) {
            CircularButton(image: UserInterfaceAsset.google) {
                store.send(.didTapSignInWithGoogle)
            }
            
            CircularButton(image: UserInterfaceAsset.apple) {
                store.send(.didTapSignInWithApple)
            }
        }
    }
    
    @ViewBuilder
    public var emailSection: some View {
        VStack {
            PrimaryDivider()
            
            PrimaryButton(label: "Sign Up with Email") {
                store.send(.didTapSignUpWithEmail)
            }
            .padding(.vertical)
        }
    }
    
    @ViewBuilder
    public var confirmSection: some View {
        HStack(spacing: 3) {
            Text("Have an Existing Account?")
                .font(.footnote)
                .foregroundStyle(.secondary)
            
            Button {
                store.send(.didTapSignInWithEmail)
            } label: {
                Text("Log In")
                    .font(UserInterfaceFontFamily.Pretendard.bold.swiftUIFont(size: 16))
                    .foregroundStyle(UserInterfaceAsset.ddAccent.swiftUIColor)
            }
        }
        .padding(.bottom, 30)
    }
    
    public var body: some View {
        NavigationStack {
            ZStack {
                UserInterfaceAsset.ddPrimaryBackground.swiftUIColor.ignoresSafeArea()
                Text("Dear Diary").primaryTextStyle().offset(y: -50)
                VStack {
                    Spacer()
                    socialSection
                    emailSection
                    confirmSection
                }
                .primaryHorizontalPadding()
            }
            .navigationDestination(
                item: $store.scope(
                    state: \.destination?.signIn,
                    action: \.destination.signIn
                )
            ) { store in
                AuthenticationView(store: store)
                    .navigationBarBackButtonHidden()
            }
            .navigationDestination(
                item: $store.scope(
                    state: \.destination?.signUp,
                    action: \.destination.signUp
                )
            ) { store in
                RegistrationView(store: store)
                    .navigationBarBackButtonHidden()
            }
            .navigationDestination(
                item: $store.scope(
                    state: \.destination?.setUp,
                    action: \.destination.setUp
                )
            ) { store in
                SetUpView(store: store)
                    .navigationBarBackButtonHidden()
            }
        }
    }
}
