//  Jonathan Ritchey

import SwiftUI

public struct ToggleButton: View {
    @Binding var isComplete: Bool
    let onToggle: (Bool) -> Void
    
    public init(
        isComplete: Binding<Bool>,
        onToggle: @escaping (Bool) -> Void
    ) {
        self._isComplete = isComplete
        self.onToggle = onToggle
    }
    
    public var body: some View {
        Button {
            isComplete.toggle()
            onToggle(isComplete)
        } label: {
            HStack(spacing: 8) {
                let imageName = isComplete ? "checkmark.seal.fill" : "checkmark.seal"
                Image(systemName: imageName)
                    .font(Font.system(size: 16))
                
                Text(isComplete ? "Completed" : "Complete")
                    .font(.subheadline.weight(.bold))
            }
            .font(.subheadline.weight(.semibold))
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
        }
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(isComplete ? Color.accentColor : Color.clear)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(isComplete ? Color.accentColor : Color(.separator), lineWidth: 1)
        )
        .foregroundColor(isComplete ? .white : .primary)
    }
}

#Preview {
    @State var isComplete: Bool = .init(false)
    ToggleButton(
        isComplete: $isComplete,
        onToggle: { _ in }
    )
    .padding(.horizontal, 24)
}
