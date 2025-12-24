//  Jonathan Ritchey
import Foundation
import SwiftUI

enum ShowcaseTemplate: String, Codable, CaseIterable, Hashable {
    case signInFlow
    case chartAndStats
    case storefrontGrid
    case onboardingPager
    case medicalIntakeForm
    case profileHeader
    static let allCases: [ShowcaseTemplate] = [.signInFlow, .chartAndStats, .storefrontGrid, .onboardingPager, .medicalIntakeForm, .profileHeader]
    func key(using colorScheme: ColorScheme) -> String {
        let colorSchemeKey = colorScheme == .dark ? "dark" : "light"
        return "\(self.self)_\(colorSchemeKey)"
    }
}
