import SwiftUI

public struct CircularButton: View {
    public let image: UserInterfaceImages
    public let action: () -> Void
    
    public init(image: UserInterfaceImages, action: @escaping () -> Void) {
        self.image = image
        self.action = action
    }
    
    private let imageSize: CGSize = .init(width: 48, height: 48)
    
    public var body: some View {
        Button(action: action) {
            image.swiftUIImage
                .resizable()
                .scaledToFit()
                .padding(12)
                .frame(width: imageSize.width, height: imageSize.height)
        }
        .background(.black)
        .clipShape(Circle())
    }
}
