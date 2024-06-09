import Domain
import SwiftUI
import Shared

public struct DiaryDetailView: View {
    @Bindable var store: StoreOf<DiaryDetailCore>
    
    public init(store: StoreOf<DiaryDetailCore>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            Text("store.entry.title")
                .font(UserInterfaceFontFamily.Pretendard.semiBold.swiftUIFont(size: 23))
            Text("store.entry.content")
                .multilineTextAlignment(.leading)
                .foregroundStyle(UserInterfaceAsset.ddPrimary.swiftUIColor)
        }
        .padding()
        .navigationBarBackButtonHidden()
//        .toolbar {
//            ToolbarItem(placement: .topBarLeading) {
//                Button {
//                    store.send(.didTapNavigateToBack)
//                } label: {
//                    UserInterfaceAsset.back.swiftUIImage
//                }
//            }
//            
//            ToolbarItem(placement: .principal) {
////                Text(store.entry.createdAt.formatted(.dateTime.month().day().year()))
////                    .font(UserInterfaceFontFamily.Pretendard.bold.swiftUIFont(size: 20))
//            }
//            
//            ToolbarItem(placement: .topBarTrailing) {
//                Button {
//                    
//                } label: {
//                    Text("Save").padding(
//                        .horizontal, 10
//                    )
//                }
//                .buttonStyle(SecondaryButtonStyle())
//            }
//        }
    }
}
