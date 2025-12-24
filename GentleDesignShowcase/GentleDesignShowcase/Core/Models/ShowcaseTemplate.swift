//  Jonathan Ritchey
import Foundation

enum ShowcaseTemplate: String, Codable, CaseIterable, Hashable {
    case signInFlow
    case chartAndStats
    case storefrontGrid
    case onboardingPager
    case medicalIntakeForm
    case profileHeader
    static let allCases: [ShowcaseTemplate] = [.signInFlow, .chartAndStats, .storefrontGrid, .onboardingPager, .medicalIntakeForm, .profileHeader]
}
