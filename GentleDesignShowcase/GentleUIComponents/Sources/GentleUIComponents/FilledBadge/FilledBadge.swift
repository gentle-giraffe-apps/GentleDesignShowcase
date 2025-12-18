//  Jonathan Ritchey

import SwiftUI

public struct FilledBadge: View {
    public let title: String
    public let systemImage: String
    public let backgroundColor: Color
    public let font: Font
    public let cornerRadius: CGFloat
    
    public init(
        title: String,
        systemImage: String = "calendar",
        backgroundColor: Color = .blue,
        font: Font = .footnote.weight(.bold),
        cornerRadius: CGFloat = 34
    ) {
        self.title = title
        self.systemImage = systemImage
        self.backgroundColor = backgroundColor
        self.font = font
        self.cornerRadius = cornerRadius
    }
    
    public var body: some View {
        HStack(spacing: 8) {
            Image(systemName: systemImage)
                .font(font)
            Text(title)
                .font(font)
        }
        .foregroundColor(.white)
        .padding(.horizontal, 22)
        .padding(.vertical, 6)
        .background(backgroundColor)
        .clipShape(
            RoundedRectangle(
                cornerRadius: cornerRadius,
                style: .continuous
            )
        )
    }
}

#Preview {
    VStack(spacing: 20) {
        FilledBadge(title: "Flight Today")
        FilledBadge(title: "Flight Tomorrow", systemImage: "clock")
    }
    .padding()
    .background(Color(.systemBackground))
}
