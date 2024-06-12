import ComposableArchitecture
import SwiftUI
import Shared

public struct RegistrationView: View {
    @Bindable var store: StoreOf<RegistrationCore>
    
    public var body: some View {
        ZStack {
            UserInterfaceAsset.ddPrimaryBackground.swiftUIColor.ignoresSafeArea()
            VStack {
                Spacer()
                Text("Sign Up")
                    .secondaryTextStyle()
                    .padding(.bottom, 70)
                
                VStack(spacing: 30) {
                    PrimaryTextField("Your Name", text: $store.name).textContentType(.name)
                    PrimaryTextField("Your Email", text: $store.email).textContentType(.emailAddress)
                    PrimarySecureField("Password", text: $store.password)
                        .textContentType(.newPassword)
                    PrimarySecureField("Confirm Password", text: $store.confirmPassword).textContentType(.newPassword       )
                }
                .textFieldStyle(SecondaryTextFieldStyle())
                .textInputAutocapitalization(.never)
                
                Spacer()
                
                PrimaryButton(label: "Sign Up") {
                    store.send(.didTapSignUpWithEmail)
                }
                .padding(.vertical)
                
                Button {
                    store.send(.didTapNavigateToSignIn)
                } label: {
                    Text("Go to Sign In")
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
