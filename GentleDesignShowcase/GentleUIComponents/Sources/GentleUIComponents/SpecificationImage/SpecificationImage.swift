//  Jonathan Ritchey
import SwiftUI

public struct SpecificationImage: View {
    public let imageName: String
    public init(_ imageName: String) {
        self.imageName = imageName
    }
    public var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .colorInvert()
            .contrast(1.3)
            .saturation(0)
            .colorMultiply(Color(red: 0, green: 0.5, blue: 0))
            .opacity(1.0)
            .frame(width: 430, height: 932)
            .allowsHitTesting(false)
    }
}
