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
}
