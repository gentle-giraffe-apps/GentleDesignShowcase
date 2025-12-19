//  Jonathan Ritchey
import Foundation

enum ShowcaseTemplate: String, Codable, CaseIterable, Hashable {
    case loginFlow
    case chartAndStats
    case storefrontGrid
    case onboardingPager
    case medicalIntakeForm
    case profileHeader
}

struct ShowcaseItem: Identifiable, Codable, Hashable {
    let id: String

    let template: ShowcaseTemplate
    
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
    
    let isFavorite: Bool
    let isViewed: Bool
}

extension ShowcaseItem {
    func route() -> AppRoute {
        switch template {
        case .chartAndStats:
            return .showcaseChartsAndStats(self)
        case .loginFlow:
            return .showcaseSignInFlow(self)
        case .medicalIntakeForm:
            return .showcaseMedicalIntakeForm(self)
        case .onboardingPager:
            return .showcaseOnboardingFlow(self)
        case .profileHeader:
            return .showcaseProfileHeader(self)
        case .storefrontGrid:
            return .showcaseStoreFrontGrid(self)
        }
    }
}

struct Metadata: Codable, Hashable, Identifiable {
    let id: String
    let label: String
    let value: String
}

extension Metadata {
    static func make(label: String, value: String) -> Metadata {
        Metadata(
            id: UUID().uuidString,
            label: label,
            value: value
        )
    }
}

extension ShowcaseItem {

    static let loginFlow = ShowcaseItem(
        id: "login-flow",
        template: .loginFlow,
        title: "Login Flow",
        subtitle: "Authentication and access control",
        symbolName: "lock",
        category: "Authentication",
        description: "Demonstrates a simple login flow with validation and primary actions.",
        tags: ["Login", "Authentication", "Forms", "Navigation"],
        metadata: [
            .make(label: "Fields", value: "Email, Password"),
            .make(label: "Validation", value: "Inline"),
            .make(label: "CTA", value: "Primary Button")
        ],
        createdAt: Date(),
        updatedAt: nil,
        isFavorite: false,
        isViewed: false
    )
    
    static let chartAndStats = ShowcaseItem(
        id: "chart-and-stats",
        template: .chartAndStats,
        title: "Chart & Stats",
        subtitle: "Visualize trends with summary metrics",
        symbolName: "chart.xyaxis.line",
        category: "Data",
        description: "Demonstrates a chart paired with key metrics and a supporting list.",
        tags: ["Charts", "Metrics", "Lists"],
        metadata: [
            .make(label: "Data Points", value: "30"),
            .make(label: "Time Range", value: "Last 30 days"),
            .make(label: "Metric Type", value: "Aggregate")
        ],
        createdAt: Date(),
        updatedAt: nil,
        isFavorite: false,
        isViewed: false
    )

    static let storefrontGrid = ShowcaseItem(
        id: "storefront-grid",
        template: .storefrontGrid,
        title: "Storefront Grid",
        subtitle: "Product cards in a responsive grid",
        symbolName: "square.grid.2x2",
        category: "Commerce",
        description: "Shows a grid-based layout with cards, images, and actions.",
        tags: ["Grid", "Cards", "Images"],
        metadata: [
            .make(label: "Columns", value: "Adaptive"),
            .make(label: "Items", value: "12"),
            .make(label: "Layout", value: "LazyVGrid")
        ],
        createdAt: Date(),
        updatedAt: nil,
        isFavorite: false,
        isViewed: false
    )

    static let onboardingPager = ShowcaseItem(
        id: "onboarding-pager",
        template: .onboardingPager,
        title: "Onboarding Flow",
        subtitle: "Paged onboarding with call-to-action",
        symbolName: "rectangle.on.rectangle.angled",
        category: "Navigation",
        description: "Illustrates a paged onboarding experience with simple messaging.",
        tags: ["Paging", "Onboarding", "Animation"],
        metadata: [
            .make(label: "Pages", value: "3"),
            .make(label: "Interaction", value: "Swipe"),
            .make(label: "CTA", value: "Primary Button")
        ],
        createdAt: Date(),
        updatedAt: nil,
        isFavorite: false,
        isViewed: false
    )

    static let medicalIntakeForm = ShowcaseItem(
        id: "medical-intake-form",
        template: .medicalIntakeForm,
        title: "Medical Intake Form",
        subtitle: "Patient information and health history",
        symbolName: "cross.case",
        category: "Forms",
        description: "Demonstrates a structured medical intake form with multiple sections, validation, and conditional fields.",
        tags: [
            "Forms",
            "Healthcare",
            "Validation",
            "Accessibility",
            "State Management"
        ],
        metadata: [
            .make(label: "Sections", value: "Personal Info, History, Emergency"),
            .make(label: "Field Types", value: "Text, Date, Selection"),
            .make(label: "Validation", value: "Required & Conditional"),
            .make(label: "Accessibility", value: "VoiceOver-ready")
        ],
        createdAt: Date(),
        updatedAt: nil,
        isFavorite: false,
        isViewed: false
    )

    static let profileHeader = ShowcaseItem(
        id: "profile-header",
        template: .profileHeader,
        title: "Profile Header",
        subtitle: "Identity-focused header layout",
        symbolName: "person.crop.circle",
        category: "Identity",
        description: "Shows a profile header with avatar, actions, and summary info.",
        tags: ["Profile", "Header", "Layout"],
        metadata: [
            .make(label: "Avatar", value: "Circle"),
            .make(label: "Actions", value: "Primary + Secondary"),
            .make(label: "Alignment", value: "Vertical")
        ],
        createdAt: Date(),
        updatedAt: nil,
        isFavorite: false,
        isViewed: false
    )

    static let mocks: [ShowcaseItem] = [
        loginFlow,
        chartAndStats,
        storefrontGrid,
        onboardingPager,
        medicalIntakeForm,
        profileHeader
    ]
}
