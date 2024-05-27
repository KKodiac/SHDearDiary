import SwiftUI

public struct PrimaryTextFieldStyle: TextFieldStyle {
    public init() { }
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .foregroundStyle(UserInterfaceAsset.ddPrimary.swiftUIColor)
            .padding(9)
            .background(UserInterfaceAsset.ddFill.swiftUIColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(UserInterfaceAsset.ddSolid.swiftUIColor)
            }
    }
}

public struct SecondaryTextFieldStyle: TextFieldStyle {
    public init() { }
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .foregroundStyle(UserInterfaceAsset.ddPrimary.swiftUIColor)

        Divider().foregroundStyle(UserInterfaceAsset.ddAccent.swiftUIColor)
    }
}

public struct ChatTextFieldStyle: TextFieldStyle {
    public init() { }
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.subheadline)
            .padding(12)
            .foregroundStyle(.black)
            .background(UserInterfaceAsset.ddSecondaryBackground.swiftUIColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        
    }
}
