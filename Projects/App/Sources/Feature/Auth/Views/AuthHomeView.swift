import ComposableArchitecture
import Shared
import SwiftUI

struct AuthHomeView: View {
    @Bindable var store: StoreOf<AuthCore>
    
    var body: some View {
        ZStack {
            UserInterfaceAsset.ddPrimaryBackground.swiftUIColor.ignoresSafeArea()
            Text("Dear Diary").primaryTextStyle().offset(y: -50)
            
            VStack {
                Spacer()
                HStack(spacing: 25) {
                    CircularButton(image: UserInterfaceAsset.google) {
                        store.send(.didTapGoogleSignInButton)
                    }
                    
                    CircularButton(image: UserInterfaceAsset.apple) {
                        store.send(.didTapAppleSignInButton)
                    }
                }
                
                PrimaryDivider()
                
                PrimaryButton(label: "Sign Up with Email") {
                    store.send(.didTapSignUpButton)
                }
                .padding(.vertical)
                
                HStack(spacing: 3) {
                    Text("Existing account?")
                        .font(UserInterfaceFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                        .foregroundStyle(.secondary)
                    
                    Button {
                        store.send(.didTapSignInButton)
                    } label: {
                        Text("Log In")
                            .font(UserInterfaceFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                            .foregroundStyle(UserInterfaceAsset.ddAccent.swiftUIColor)
                    }
                }
                
            }
            .padding(.all)
            .padding(.horizontal)
        }
        .background(UserInterfaceAsset.ddPrimaryBackground.swiftUIColor)
    }
}
