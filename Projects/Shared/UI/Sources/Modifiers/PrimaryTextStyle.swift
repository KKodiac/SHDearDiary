import SwiftUI

struct PrimaryTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(UserInterfaceFontFamily.Pretendard.bold.swiftUIFont(size: 26))
    }
}

public extension View {
    func primaryTextStyle() -> some View {
        modifier(PrimaryTextStyle())
    }
}
