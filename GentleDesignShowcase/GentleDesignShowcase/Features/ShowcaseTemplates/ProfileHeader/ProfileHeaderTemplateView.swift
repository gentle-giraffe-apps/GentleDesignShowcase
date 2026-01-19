//  Jonathan Ritchey
import GentleDesignSystem
import Observation
import SwiftUI

@Observable
class ProfileHeaderTemplateViewModel {
    let name: String
    let age: Int
    let interests: [String]

    init(name: String, age: Int, interests: [String]) {
        self.name = name
        self.age = age
        self.interests = interests
    }

    static var sample: ProfileHeaderTemplateViewModel {
        return ProfileHeaderTemplateViewModel(
            name: "Gerry",
            age: 12,
            interests: [
                "Leaf browsing",
                "Long walks",
                "Neck stretching",
                "Sunbathing",
                "People watching",
                "Acacia tasting"
            ]
        )
    }
}

struct ProfileHeaderTemplateView: View {
    let viewModel = ProfileHeaderTemplateViewModel.sample
    @State private var selectedMode: ProfileMode = .preview

    enum ProfileMode: String, CaseIterable {
        case edit = "Edit"
        case preview = "Preview"
    }

    var body: some View {
        VStack(spacing: 0) {
            // Segment picker
            Picker("Mode", selection: $selectedMode) {
                ForEach(ProfileMode.allCases, id: \.self) { mode in
                    Text(mode.rawValue).tag(mode)
                }
            }
            .pickerStyle(.segmented)
            .padding()

            // Profile card
            profileCard
        }
    }

    var profileCard: some View {
        Image("ProfileGiraffe")
            .resizable()
            .scaledToFit()
            .overlay(alignment: .bottom) {
                // Bottom gradient for text readability
                LinearGradient(
                    colors: [.clear, .black.opacity(0.6)],
                    startPoint: .center,
                    endPoint: .bottom
                )
            }
            .overlay(alignment: .bottomLeading) {
                // Content overlay
                VStack(alignment: .leading, spacing: 12) {
                    // Name and age
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text(viewModel.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("\(viewModel.age)")
                            .font(.title)
                            .fontWeight(.light)
                    }
                    .foregroundStyle(.white)

                    FlowLayout(spacing: 8) {
                        ForEach(viewModel.interests, id: \.self) { interest in
                            Text(interest)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(
                                    Capsule()
                                        .fill(.ultraThinMaterial)
                                        .opacity(0.8)
                                        .overlay(
                                            Capsule()
                                                .stroke(.white.opacity(0.25), lineWidth: 1)
                                        )
                                )
                        }
                    }
                }
                .padding(20)
            }
            .overlay(alignment: .bottomTrailing) {
                // Info button
                Button(action: {}) {
                    Image(systemName: "info.circle.fill")
                        .font(.title)
                        .foregroundStyle(.white)
                }
                .padding(20)
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal)
    }
}

// Flow layout for wrapping interest bubbles
struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = arrangeSubviews(proposal: proposal, subviews: subviews)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrangeSubviews(proposal: proposal, subviews: subviews)
        for (index, position) in result.positions.enumerated() {
            subviews[index].place(at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y), proposal: .unspecified)
        }
    }

    private func arrangeSubviews(proposal: ProposedViewSize, subviews: Subviews) -> (size: CGSize, positions: [CGPoint]) {
        let maxWidth = proposal.width ?? .infinity
        var positions: [CGPoint] = []
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var lineHeight: CGFloat = 0
        var totalHeight: CGFloat = 0
        var totalWidth: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)

            if currentX + size.width > maxWidth && currentX > 0 {
                currentX = 0
                currentY += lineHeight + spacing
                lineHeight = 0
            }

            positions.append(CGPoint(x: currentX, y: currentY))
            lineHeight = max(lineHeight, size.height)
            currentX += size.width + spacing
            totalWidth = max(totalWidth, currentX - spacing)
            totalHeight = currentY + lineHeight
        }

        return (CGSize(width: totalWidth, height: totalHeight), positions)
    }
}
