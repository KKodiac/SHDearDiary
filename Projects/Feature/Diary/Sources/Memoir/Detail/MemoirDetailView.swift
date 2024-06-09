import ComposableArchitecture
import SwiftUI
import Shared

public struct MemoirDetailView: View {
    @Bindable var store: StoreOf<MemoirDetailCore>
    
    public var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    Divider().padding(.top)
                    
                    Text(store.entry.title)
                        .font(UserInterfaceFontFamily.Pretendard.bold.swiftUIFont(size: 23))
                    TextEditor(text: $store.entry.content)
                        .multilineTextAlignment(.leading)
                        .disabled(store.editable)
                }
                VStack(alignment: .trailing) {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: store.editable ? "pencil" : "archivebox")
                                .font(UserInterfaceFontFamily.Pretendard.bold.swiftUIFont(size: 20))
                                .foregroundColor(.white)
                                .padding()
                        }
                        .background(UserInterfaceAsset.ddAccent.swiftUIColor)
                        .clipShape(Circle())
                    }
                }
                .padding(.trailing, 10)
            }
            .onAppear {
                
            }
            .padding(.horizontal)
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    Button {
//                        store.send(.didTapBackButton)
//                    } label: {
//                        UserInterfaceAsset.back.swiftUIImage
//                    }
//                }
//                
//                ToolbarItem(placement: .principal) {
//                    Text(Date.now.formatted(Date.FormatStyle.dateStyle))
//                        .font(UserInterfaceFontFamily.Pretendard.bold.swiftUIFont(size: 20))
//                }
//                
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button {
//                        store.send(.didTapSaveButton)
//                    } label: {
//                        Text("Save")
//                            .padding(.horizontal, 10)
//                    }
//                    .buttonStyle(SecondaryButtonStyle())
//                }
//            }
        }
    }
}

