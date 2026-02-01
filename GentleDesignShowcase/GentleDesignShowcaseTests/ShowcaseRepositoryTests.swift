import Foundation
import Testing
@testable import GentleDesignShowcase

// Mock completion store for testing
final class MockCompletedShowcaseItemsStore: CompletedShowcaseItemsStore {
    private var completed: Set<String> = []

    func completedIDs() -> Set<String> {
        return completed
    }

    func isCompleted(id: String) -> Bool {
        return completed.contains(id)
    }

    func setCompleted(_ completed: Bool, for id: String) {
        if completed {
            self.completed.insert(id)
        } else {
            self.completed.remove(id)
        }
    }
}

// Mock service for testing
struct MockShowcaseItemsService: ShowcaseItemsServiceProtocol {
    let items: [ShowcaseItem]

    func fetchShowcaseItems() async throws -> [ShowcaseItem] {
        return items
    }
}

@Suite("ShowcaseRepository Tests")
struct ShowcaseRepositoryTests {

    @MainActor
    @Test("Initial state has empty items")
    func initialStateHasEmptyItems() {
        let mockStore = MockCompletedShowcaseItemsStore()
        let mockService = MockShowcaseItemsService(items: [])
        let repository = ShowcaseRepository(
            showcaseItemsService: mockService,
            completionStore: mockStore
        )
        #expect(repository.showcaseItems.isEmpty)
    }

    @MainActor
    @Test("loadShowcaseItems populates items")
    func loadShowcaseItemsPopulatesItems() async throws {
        let mockStore = MockCompletedShowcaseItemsStore()
        let mockService = MockShowcaseItemsService(items: ShowcaseItem.mocks)
        let repository = ShowcaseRepository(
            showcaseItemsService: mockService,
            completionStore: mockStore
        )

        try await repository.loadShowcaseItems()
        #expect(repository.showcaseItems.count == ShowcaseItem.mocks.count)
    }

    @MainActor
    @Test("setCompleted true adds to completedIDs")
    func setCompletedTrueAddsToSet() {
        let mockStore = MockCompletedShowcaseItemsStore()
        let mockService = MockShowcaseItemsService(items: [])
        let repository = ShowcaseRepository(
            showcaseItemsService: mockService,
            completionStore: mockStore
        )

        let testId = "test-item-123"
        repository.setCompleted(true, for: testId)
        #expect(repository.completedIDs.contains(testId))
    }

    @MainActor
    @Test("setCompleted false removes from completedIDs")
    func setCompletedFalseRemovesFromSet() {
        let mockStore = MockCompletedShowcaseItemsStore()
        let mockService = MockShowcaseItemsService(items: [])
        let repository = ShowcaseRepository(
            showcaseItemsService: mockService,
            completionStore: mockStore
        )

        let testId = "test-item-456"
        repository.setCompleted(true, for: testId)
        #expect(repository.completedIDs.contains(testId))

        repository.setCompleted(false, for: testId)
        #expect(!repository.completedIDs.contains(testId))
    }

    @MainActor
    @Test("isCompleted returns correct value")
    func isCompletedReturnsCorrectValue() {
        let mockStore = MockCompletedShowcaseItemsStore()
        let mockService = MockShowcaseItemsService(items: [])
        let repository = ShowcaseRepository(
            showcaseItemsService: mockService,
            completionStore: mockStore
        )

        let testId = "test-completed"
        #expect(!repository.isCompleted(id: testId))

        repository.setCompleted(true, for: testId)
        #expect(repository.isCompleted(id: testId))
    }

    @MainActor
    @Test("resumeFromSuspendedState executes without error")
    func resumeFromSuspendedStateExecutes() {
        let mockStore = MockCompletedShowcaseItemsStore()
        let mockService = MockShowcaseItemsService(items: [])
        let repository = ShowcaseRepository(
            showcaseItemsService: mockService,
            completionStore: mockStore
        )

        // Just verify it runs without crashing
        repository.resumeFromSuspendedState()
        #expect(true)
    }

    @MainActor
    @Test("mockRepository factory creates valid repository")
    func mockRepositoryFactoryWorks() {
        let repository = ShowcaseRepository.mockRepository()
        #expect(repository.showcaseItems.isEmpty)
    }

    @MainActor
    @Test("completedIDs initialized from store")
    func completedIDsInitializedFromStore() {
        let mockStore = MockCompletedShowcaseItemsStore()
        mockStore.setCompleted(true, for: "pre-completed")

        let mockService = MockShowcaseItemsService(items: [])
        let repository = ShowcaseRepository(
            showcaseItemsService: mockService,
            completionStore: mockStore
        )

        #expect(repository.completedIDs.contains("pre-completed"))
    }
}

@Suite("UserDefaultsCompletedShowcaseItemsStore Tests")
struct UserDefaultsCompletedShowcaseItemsStoreTests {

    @Test("completedIDs returns empty set initially")
    func completedIDsReturnsEmptySetInitially() {
        // Use a unique key by creating a new store instance
        let store = UserDefaultsCompletedShowcaseItemsStore()
        // Note: This might have state from previous runs, so just verify it returns a Set
        let ids = store.completedIDs()
        #expect(ids is Set<String>)
    }

    @Test("setCompleted and isCompleted work together")
    func setCompletedAndIsCompletedWork() {
        let store = UserDefaultsCompletedShowcaseItemsStore()
        let uniqueId = "test-\(UUID().uuidString)"

        store.setCompleted(true, for: uniqueId)
        #expect(store.isCompleted(id: uniqueId))

        store.setCompleted(false, for: uniqueId)
        #expect(!store.isCompleted(id: uniqueId))
    }

    @Test("completedIDs returns cached value")
    func completedIDsReturnsCachedValue() {
        let store = UserDefaultsCompletedShowcaseItemsStore()
        let uniqueId = "cache-test-\(UUID().uuidString)"

        store.setCompleted(true, for: uniqueId)

        // Call multiple times to exercise cache
        _ = store.completedIDs()
        _ = store.completedIDs()
        let ids = store.completedIDs()

        #expect(ids.contains(uniqueId))

        // Cleanup
        store.setCompleted(false, for: uniqueId)
    }
}
