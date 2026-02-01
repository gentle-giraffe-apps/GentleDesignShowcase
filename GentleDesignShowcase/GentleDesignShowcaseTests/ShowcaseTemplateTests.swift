import Foundation
import SwiftUI
import Testing
@testable import GentleDesignShowcase

@Suite("ShowcaseTemplate Tests")
struct ShowcaseTemplateTests {

    @Test("allCases contains expected count")
    func allCasesCount() {
        #expect(ShowcaseTemplate.allCases.count == 8)
    }

    @Test("Key with dark scheme returns dark suffix")
    func keyWithDarkScheme() {
        let template = ShowcaseTemplate.signInFlow
        let key = template.key(using: .dark)
        #expect(key == "signInFlow_dark")
    }

    @Test("Key with light scheme returns light suffix")
    func keyWithLightScheme() {
        let template = ShowcaseTemplate.signInFlow
        let key = template.key(using: .light)
        #expect(key == "signInFlow_light")
    }

    @Test("All templates generate unique keys for dark scheme")
    func uniqueKeysDarkScheme() {
        let keys = ShowcaseTemplate.allCases.map { $0.key(using: .dark) }
        let uniqueKeys = Set(keys)
        #expect(uniqueKeys.count == ShowcaseTemplate.allCases.count)
    }

    @Test("All templates generate unique keys for light scheme")
    func uniqueKeysLightScheme() {
        let keys = ShowcaseTemplate.allCases.map { $0.key(using: .light) }
        let uniqueKeys = Set(keys)
        #expect(uniqueKeys.count == ShowcaseTemplate.allCases.count)
    }

    @Test("Template rawValue matches expected string")
    func rawValues() {
        #expect(ShowcaseTemplate.signInFlow.rawValue == "signInFlow")
        #expect(ShowcaseTemplate.chartAndStats.rawValue == "chartAndStats")
        #expect(ShowcaseTemplate.storefrontGrid.rawValue == "storefrontGrid")
        #expect(ShowcaseTemplate.mapRoute.rawValue == "mapRoute")
        #expect(ShowcaseTemplate.transitCard.rawValue == "transitCard")
    }

    @Test("Template is Codable")
    func templateIsCodable() throws {
        let template = ShowcaseTemplate.signInFlow
        let encoder = JSONEncoder()
        let data = try encoder.encode(template)
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(ShowcaseTemplate.self, from: data)
        #expect(decoded == template)
    }
}
