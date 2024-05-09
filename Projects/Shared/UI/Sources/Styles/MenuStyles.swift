import SwiftUI

struct PrimaryMenuStyle: MenuStyle {
    func makeBody(configuration: Configuration) -> some View {
        Menu(configuration)
            .background(UserInterfaceAsset.ddPrimaryBackground.swiftUIColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundStyle(.secondary)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(UserInterfaceAsset.ddSolid.swiftUIColor)
            }
    }
}
