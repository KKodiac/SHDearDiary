import ComposableArchitecture
import SwiftUI
import Shared

struct SetUpView: View {
    private let titleTextOffsetY: CGFloat = -20
    @Bindable var store: StoreOf<SetUpCore>
    
    var body: some View {
        VStack {
            Spacer()
            Text("Dear Diary")
                .primaryTextStyle()
                .offset(y: titleTextOffsetY)
            
            UserInterfaceAsset.diary.swiftUIImage
            Spacer()
            
            VStack(alignment: .leading, spacing: 15) {
                Text("Name your diary...")
                    .font(UserInterfaceFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                
                TextField(text: $store.name) {
                    Text("ex) Kitty")
                }
                .textFieldStyle(PrimaryTextFieldStyle())
                
                Text("Select the personality of your diary...")
                    .font(UserInterfaceFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                    .padding(.top, 20)
                
                DisclosureGroup(
                    isExpanded: $store.isExpanded,
                    content: {
                        ForEach(store.personalities, id: \.self) { personality in
                            Divider()
                            Button(action: {
                                
                            }, label: {
                                HStack {
                                    Text(personality.rawValue).font(.headline)
                                    Spacer()
                                }
                            })
                        }
                    },
                    label: {
                        if store.selectedPersonality == .none {
                            Text("Choose One...")
                        } else {
                            Text(store.selectedPersonality.rawValue)
                        }
                        
                    }
                )
                .padding(9)
                .background(UserInterfaceAsset.ddFill.swiftUIColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(UserInterfaceAsset.ddPrimary.swiftUIColor)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(UserInterfaceAsset.ddSolid.swiftUIColor)
                }
            }
            Spacer()
            PrimaryButton(label: "Get Started") {
                store.send(.didTapGetStarted)
            }
        }
        .padding(.all)
        .padding(.horizontal)
        .background(UserInterfaceAsset.ddPrimaryBackground.swiftUIColor)
    }
}
