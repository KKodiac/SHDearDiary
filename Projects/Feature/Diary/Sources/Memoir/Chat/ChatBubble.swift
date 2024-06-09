import Domain
import SwiftUI
import Shared

struct ChatBubble: View {
    let content: Dialogue
    let diaryName: String
    
    var body: some View {
        HStack {
            if content.role == .user { Spacer() }
            else {
                VStack {
                    Circle()
                        .fill(UserInterfaceAsset.ddAccent.swiftUIColor)
                        .frame(width: 44, height: 44)
                        .overlay {
                            UserInterfaceAsset.imoji.swiftUIImage
                        }
                    Spacer()
                }
            }
            VStack(alignment: .leading) {
                if content.role == .assistant { Text("\(diaryName)") }
                VStack(alignment: .trailing) {
                    VStack {
                        Text(content.content)
                            .font(.subheadline)
                            .fontWeight(.light)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 12)
                            .foregroundStyle(content.role == .user ? .white : .black)
                    }
                    .background(content.role == .user ? UserInterfaceAsset.ddAccent.swiftUIColor : Color.white)
                    .clipShape(UnevenRoundedRectangle(
                        topLeadingRadius: content.role == .user ? 14 : 0,
                        bottomLeadingRadius: 14,
                        bottomTrailingRadius: 14,
                        topTrailingRadius: content.role == .user ? 0 : 14))
                    Text(content.createdAt.formatted(date: .omitted, time: .shortened))
                        .font(.footnote)
                        .fontWeight(.light)
                        .foregroundStyle(UserInterfaceAsset.ddAccent.swiftUIColor)
                }.padding([.top, .leading], content.role == .user ? 0 : 5)
            }
            if content.role == .assistant { Spacer() }
        }
        .padding(.vertical, 10)
    }
}
