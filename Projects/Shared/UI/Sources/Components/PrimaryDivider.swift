import SwiftUI

public struct PrimaryDivider: View {
    public init() { }
    public var body: some View {
        Divider()
            .overlay {
                Text("OR")
                    .font(.caption)
                    .foregroundStyle(UserInterfaceAsset.ddAccent.swiftUIColor)
                    .padding(.horizontal)
                    .background(UserInterfaceAsset.ddPrimaryBackground.swiftUIColor)
            }
            .padding(.vertical)
    }
}
