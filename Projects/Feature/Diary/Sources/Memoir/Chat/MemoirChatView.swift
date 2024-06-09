import ComposableArchitecture
import SwiftUI
import Shared

public struct MemoirChatView: View {
    @Bindable var store: StoreOf<MemoirCore>
    @AppStorage("DiaryName") private var diaryName: String?
    
    public var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(store.dialogues, id: \.id) { dialogue in
                        ChatBubble(content: dialogue, diaryName: diaryName ?? "Your Diary")
                            .id(dialogue.id)
                    }
                    .onChange(of: store.dialogues) { _, newValue in
                        withAnimation {
                            proxy.scrollTo(newValue.last?.id, anchor: .bottom)
                        }
                    }
                }
            }
            
            ZStack {
                TextField(text: $store.dialogue, prompt: Text("What happened today?")) {
                    Text("Hello World")
                }
                .textFieldStyle(ChatTextFieldStyle())
                .onSubmit {
                    
                }
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        UserInterfaceAsset.send.swiftUIImage
                            .padding(10)
                            .background(UserInterfaceAsset.ddBackgroundAccent.swiftUIColor)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(UserInterfaceAsset.ddAccent.swiftUIColor)
                            }
                    }
                }
            }
        }
    }
}
