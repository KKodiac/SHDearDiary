import AuthenticationServices
import ComposableArchitecture
import SwiftUI
import Shared

public struct MemoirView: View {
    @Bindable var store: StoreOf<MemoirCore>
    @AppStorage("diary_name") private var diaryName: String?
    
    public init(store: StoreOf<MemoirCore>, diaryName: String? = nil) {
        self.store = store
        self.diaryName = diaryName
    }
    
    public var header: some View {
        VStack {
            Divider()
                .overlay {
                    Text("Should I ask \(diaryName ?? "Your Diary") to write your diary?")
                        .padding(.horizontal, 12)
                        .padding(.vertical, 15)
                        .font(.caption)
                        .foregroundStyle(UserInterfaceAsset.ddPrimary.swiftUIColor)
                        .background(UserInterfaceAsset.toolbarBackground.swiftUIColor)
                }
                .padding([.horizontal, .bottom])
            HStack {
                Button {
                    
                } label: {
                    HStack {
                        Spacer()
                        Text("Compose")
                        Spacer()
                    }
                    .overlay {
                        ProgressView(value: store.progress).progressViewStyle(.circular)
                    }
                }
                .buttonStyle(ComposeButtonStyle())
                
                Button {
                    
                } label: {
                    HStack {
                        Spacer()
                        Text("Pause")
                        Spacer()
                    }
                    
                }
                .buttonStyle(PauseButtonStyle())
                
            }
            .padding(.bottom)
            .padding(.horizontal, 40)
        }
        .safeAreaPadding(.top)
        .background(UserInterfaceAsset.toolbarBackground.swiftUIColor.shadow(radius: 3, y: 2))
    }
    
    public var body: some View {
        ZStack {
            VStack {
                header
                
                Spacer()
                
                VStack {
                    if store.state.chatInitialized {
                        MemoirChatView(store: store)
                    } else {
                        VStack {
                            UserInterfaceAsset.diary.swiftUIImage
                            Image("Diary")
                            Text("Say 'Hello!' to your Diary!")
                        }
                        .opacity(0.6)
                        .padding(.bottom, 50)
                        Button("Hello, \(diaryName ?? "Diary")") {
//                            store.send(.createMessage("Hello, \(diaryName ?? "Diary")"))
                        }
                        .buttonStyle(SecondaryButtonStyle())
                    }
                }
                .padding(.horizontal)
            }
        }
        .onAppear { }
        .background(UserInterfaceAsset.ddPrimaryBackground.swiftUIColor)
        .navigationBarBackButtonHidden()
        .toolbarRole(.navigationStack)
        .toolbarBackground(.visible, for: .navigationBar)
        .fullScreenCover(item: $store.scope(state: \.destination?.detail, action: \.destination.detail)) { store in
            MemoirDetailView(store: store)
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button {
                    store.send(.didTapNavigateToBack)
                } label: {
                    UserInterfaceAsset.back.swiftUIImage
                }
                Circle()
                    .fill(UserInterfaceAsset.ddAccent.swiftUIColor)
                    .frame(width: 44, height: 44)
                    .overlay {
                        UserInterfaceAsset.imoji.swiftUIImage
                    }
                VStack(alignment: .leading) {
                    Text("\(diaryName ?? "Diary")")
                        .fontWeight(.medium)
                    Text("My AI Diary")
                        .font(.caption)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "gearshape.fill")
                        .tint(UserInterfaceAsset.ddPrimary.swiftUIColor)
                }
            }
        }
    }
}
