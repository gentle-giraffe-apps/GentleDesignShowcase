import Testing
@testable import GentleDesignShowcase

@Suite("ShowcaseItem Tests")
struct ShowcaseItemTests {

    @Test("Mock items are not empty")
    func mockItemsExist() {
        let items = ShowcaseItem.mocks
        #expect(!items.isEmpty)
    }

    @Test("ShowcaseItem is identifiable")
    func itemIsIdentifiable() {
        let item = ShowcaseItem.mocks.first!
        #expect(!item.id.isEmpty)
    }

    @Test("All mock items have unique IDs")
    func mockItemsHaveUniqueIDs() {
        let items = ShowcaseItem.mocks
        let ids = Set(items.map(\.id))
        #expect(ids.count == items.count)
    }

    @Test("All mock items have non-empty titles")
    func mockItemsHaveTitles() {
        for item in ShowcaseItem.mocks {
            #expect(!item.title.isEmpty, "Item \(item.id) should have a title")
        }
    }

    @Test("All mock items have at least one tag")
    func mockItemsHaveTags() {
        for item in ShowcaseItem.mocks {
            #expect(!item.tags.isEmpty, "Item \(item.id) should have tags")
        }
    }

    @Test("Route returns correct type for signInFlow")
    func routeForSignInFlow() {
        let item = ShowcaseItem.signInFlow
        let route = item.route()
        if case .showcaseSignInFlow(let routedItem) = route {
            #expect(routedItem.id == item.id)
        } else {
            Issue.record("Expected showcaseSignInFlow route")
        }
    }

    @Test("Route returns correct type for chartAndStats")
    func routeForChartAndStats() {
        let item = ShowcaseItem.chartAndStats
        let route = item.route()
        if case .showcaseChartsAndStats(let routedItem) = route {
            #expect(routedItem.id == item.id)
        } else {
            Issue.record("Expected showcaseChartsAndStats route")
        }
    }

    @Test("All templates have a corresponding mock item")
    func allTemplatesHaveMocks() {
        let mockTemplates = Set(ShowcaseItem.mocks.map(\.template))
        for template in ShowcaseTemplate.allCases {
            #expect(mockTemplates.contains(template), "Missing mock for \(template)")
        }
    }
}
