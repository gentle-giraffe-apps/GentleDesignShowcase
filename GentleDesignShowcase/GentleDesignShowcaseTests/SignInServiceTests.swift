import Foundation
import Testing
@testable import GentleDesignShowcase

@Suite("SignInService Tests")
struct SignInServiceTests {

    @Test("MockSignInService can be instantiated")
    func mockSignInServiceInstantiates() {
        let service = MockSignInService()
        #expect(service != nil)
    }

    @Test("MockSignInService signIn completes without error")
    func mockSignInServiceSignIn() async throws {
        var service = MockSignInService()
        try await service.signIn(username: "testuser", password: "testpass")
        #expect(true)
    }

    @Test("ShowcaseItemsService can be instantiated")
    func showcaseItemsServiceInstantiates() {
        let service = ShowcaseItemsService()
        #expect(service != nil)
    }

    @Test("ShowcaseItemsService fetchShowcaseItems returns mocks")
    func showcaseItemsServiceFetchReturnsItems() async throws {
        let service = ShowcaseItemsService()
        let items = try await service.fetchShowcaseItems()
        #expect(!items.isEmpty)
        #expect(items.count == ShowcaseItem.mocks.count)
    }
}
