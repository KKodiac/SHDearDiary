import SwiftUI

struct SecondaryTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(UserInterfaceFontFamily.Pretendard.semiBold.swiftUIFont(size: 18))
    }
}

public extension View {
    func secondaryTextStyle() -> some View {
        modifier(SecondaryTextStyle())
    }
}
