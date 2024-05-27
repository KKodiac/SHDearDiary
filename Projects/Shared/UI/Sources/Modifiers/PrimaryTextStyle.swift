import SwiftUI

public struct PrimaryTextStyle: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .font(UserInterfaceFontFamily.Pretendard.bold.swiftUIFont(size: 26))
    }
}

public extension View {
    public func primaryTextStyle() -> some View {
        modifier(PrimaryTextStyle())
    }
}
