import SwiftUI

public struct SecondaryTextStyle: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .font(UserInterfaceFontFamily.Pretendard.semiBold.swiftUIFont(size: 18))
    }
}

public extension View {
    public func secondaryTextStyle() -> some View {
        modifier(SecondaryTextStyle())
    }
}
