import SwiftUI

public struct Card: View {
    let title: String
    let content: String
    let timestamp: Date
    
    public init(title: String, content: String, timestamp: Date) {
        self.title = title
        self.content = content
        self.timestamp = timestamp
    }
    
    public var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(UserInterfaceAsset.ddSecondary.swiftUIColor)
            .overlay {
                VStack {
                    HStack {
                        Text(title).font(.body).bold()
                        Spacer()
                        Text(timestamp.formatted(date: .omitted, time: .shortened))
                            .foregroundStyle(.gray)
                    }
                    Text(content)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.gray)
                }
                .padding(25)
                .font(.caption)
                .fontWeight(.light)
                
            }
            .frame(height: 110)
            .padding([.horizontal, .top])
    }
}
