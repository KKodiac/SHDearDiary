import ComposableArchitecture
import SwiftUI
import Shared

struct SignInView: View {
    @Bindable var store: StoreOf<SignInCore>
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("Welcome Back").primaryTextStyle().padding(.bottom)
                HStack(spacing: 25) {
                    CircularButton(image: UserInterfaceAsset.google) {
                        store.send(.didTapGoogleSignInButton)
                    }
                    CircularButton(image: UserInterfaceAsset.apple) {
                        store.send(.didTapAppleSignInButton)
                    }
                }
                
                PrimaryDivider()
                
                Form {
                    VStack(alignment: .leading) {
                        Text("Email")
                        TextField("", text: $store.email)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                    }
                    .padding(.vertical)
                    VStack(alignment: .leading) {
                        Text("Password")
                        SecureField("", text: $store.password)
                            .autocorrectionDisabled()
                    }
                    .padding(.top)
                }
                .font(UserInterfaceFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                .textFieldStyle(SecondaryTextFieldStyle())
                
                Spacer()
                VStack {
                    PrimaryButton(label: "Log In") {
                        store.send(.didTapLogInButton)
                    }
                    
                    Button("Forgot password?") {
                        
                    }
                    .buttonStyle(.borderless)
                    .foregroundStyle(UserInterfaceAsset.ddAccent.swiftUIColor)
                }
            }
            
        }
        .padding(.horizontal)
        .padding(.horizontal)
        .background(UserInterfaceAsset.ddPrimaryBackground.swiftUIColor)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    store.send(.didTapBackNavigationButton)
                } label: {
                    Image("back")
                }
            }
        }
    }
}
