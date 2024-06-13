import ComposableArchitecture
import SwiftUI
import Shared

public struct AuthenticationView: View {
    @Bindable var store: StoreOf<AuthenticationCore>
    @Environment(\.authorizationController) private var controller
    
    public var body: some View {
        ZStack {
            UserInterfaceAsset.ddPrimaryBackground.swiftUIColor.ignoresSafeArea()
            VStack {
                Spacer()
                Text("Welcome Back")
                    .secondaryTextStyle()
                    .padding(.bottom, 30)
                
                HStack(spacing: 25) {
                    CircularButton(image: UserInterfaceAsset.google) {
                        store.send(.didTapSignInWithGoogle)
                    }
                    CircularButton(image: UserInterfaceAsset.apple) {
                        store.send(.didTapSignInWithApple(controller))
                    }
                }
                
                PrimaryDivider().padding(.vertical, 15)
                
                VStack(spacing: 30) {
                    PrimaryTextField("Your Email", text: $store.email)
                    PrimarySecureField("Password", text: $store.password)
                }
                .textFieldStyle(SecondaryTextFieldStyle())
                
                Spacer()
                
                PrimaryButton(label: "Log In") {
                    store.send(.didTapSignInWithEmail)
                }
                .padding(.vertical)
                
                Button {
                    store.send(.didTapNavigateToSignUp)
                } label: {
                    Text("Go to Sign Up")
                        .font(UserInterfaceFontFamily.Pretendard.bold.swiftUIFont(size: 14))
                        .foregroundStyle(UserInterfaceAsset.ddAccent.swiftUIColor)
                }
                .padding(.bottom, 30)
            }
            .primaryHorizontalPadding()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    store.send(.didTapNavigateToBack)
                } label: {
                    UserInterfaceAsset.back.swiftUIImage
                }
            }
        }
    }
}
