//  Jonathan Ritchey
import Foundation

struct ShowcaseItem: Identifiable, Codable, Hashable {
    let id: String

    // Primary identity
    let title: String
    let subtitle: String?

    // Visual / navigation affordances
    let symbolName: String?
    let category: String

    // Detail content
    let description: String
    let tags: [String]

    // Metadata (replaces origin/destination/times/price tables)
    let metadata: [Metadata]

    // State / timing (optional, keeps your date UI useful)
    let createdAt: Date
    let updatedAt: Date?

    // Optional value signal (e.g. complexity, effort, priority)
    let score: Int?
}

struct Metadata: Codable, Hashable, Identifiable {
    let id: String
    let label: String
    let value: String
}

extension ShowcaseItem {

    static let mockOne = ShowcaseItem(
        id: "showcase-1",
        title: "Catalog Grid",
        subtitle: "Adaptive layout example",
        symbolName: "square.grid.2x2",
        category: "Layouts",
        description: "A responsive grid layout demonstrating adaptive spacing, dynamic type support, and selection states across device sizes.",
        tags: ["SwiftUI", "Grid", "Adaptive"],
        metadata: [
            Metadata(id: "m1", label: "Complexity", value: "Medium"),
            Metadata(id: "m2", label: "Supports iPad", value: "Yes"),
            Metadata(id: "m3", label: "Accessibility", value: "Dynamic Type")
        ],
        createdAt: Date().addingTimeInterval(-60 * 60 * 24 * 3),
        updatedAt: Date().addingTimeInterval(-60 * 60 * 24),
        score: 3
    )

    static let mockTwo = ShowcaseItem(
        id: "showcase-2",
        title: "Detail View",
        subtitle: "Hero + metadata layout",
        symbolName: "rectangle.stack",
        category: "Components",
        description: "A detail screen with a hero header, structured metadata sections, and clear visual hierarchy for scanning content.",
        tags: ["SwiftUI", "Layout", "Hierarchy"],
        metadata: [
            Metadata(id: "m4", label: "Complexity", value: "Low"),
            Metadata(id: "m5", label: "Reusable", value: "Yes"),
            Metadata(id: "m6", label: "State Handling", value: "Static")
        ],
        createdAt: Date().addingTimeInterval(-60 * 60 * 24 * 5),
        updatedAt: nil,
        score: 2
    )

    static let mockThree = ShowcaseItem(
        id: "showcase-3",
        title: "Loading & Error States",
        subtitle: "Skeletons and retry flow",
        symbolName: "sparkles",
        category: "State",
        description: "Demonstrates loading skeletons, empty states, and error recovery using async/await with mock latency.",
        tags: ["Async/Await", "State", "UX"],
        metadata: [
            Metadata(id: "m7", label: "Complexity", value: "High"),
            Metadata(id: "m8", label: "Includes Retry", value: "Yes"),
            Metadata(id: "m9", label: "Preview Ready", value: "Yes")
        ],
        createdAt: Date().addingTimeInterval(-60 * 60 * 24 * 10),
        updatedAt: Date().addingTimeInterval(-60 * 60 * 12),
        score: 4
    )

    static let mocks: [ShowcaseItem] = [
        mockOne,
        mockTwo,
        mockThree
    ]
}
