import Foundation
import Testing
@testable import GentleDesignShowcase

@Suite("ShowcaseItemListViewModel Tests")
struct ShowcaseItemListViewModelTests {

    @MainActor
    @Test("Initial state is not loading")
    func initialStateNotLoading() {
        let repository = ShowcaseRepository.mockRepository()
        let viewModel = ShowcaseItemListViewModel(repository: repository)
        #expect(!viewModel.isLoading)
    }

    @MainActor
    @Test("Initial state has not loaded once")
    func initialStateHasNotLoadedOnce() {
        let repository = ShowcaseRepository.mockRepository()
        let viewModel = ShowcaseItemListViewModel(repository: repository)
        #expect(!viewModel.hasLoadedOnce)
    }

    @MainActor
    @Test("Title is Showcase")
    func titleIsShowcase() {
        let repository = ShowcaseRepository.mockRepository()
        let viewModel = ShowcaseItemListViewModel(repository: repository)
        #expect(viewModel.title == "Showcase")
    }

    @MainActor
    @Test("fetchShowcaseItems sets hasLoadedOnce")
    func fetchSetsHasLoadedOnce() async throws {
        let repository = ShowcaseRepository.mockRepository()
        let viewModel = ShowcaseItemListViewModel(repository: repository)

        try await viewModel.fetchShowcaseItems()
        #expect(viewModel.hasLoadedOnce)
    }

    @MainActor
    @Test("fetchShowcaseItems populates filteredViewModels")
    func fetchPopulatesFilteredViewModels() async throws {
        let repository = ShowcaseRepository.mockRepository()
        let viewModel = ShowcaseItemListViewModel(repository: repository)

        try await viewModel.fetchShowcaseItems()
        #expect(!viewModel.filteredViewModels.isEmpty)
    }

    @MainActor
    @Test("filteredViewModels count matches repository items")
    func filteredViewModelsCountMatchesRepository() async throws {
        let repository = ShowcaseRepository.mockRepository()
        let viewModel = ShowcaseItemListViewModel(repository: repository)

        try await viewModel.fetchShowcaseItems()
        #expect(viewModel.filteredViewModels.count == repository.showcaseItems.count)
    }

    @MainActor
    @Test("makeDetailViewModel creates valid view model")
    func makeDetailViewModelCreatesValid() async throws {
        let repository = ShowcaseRepository.mockRepository()
        let viewModel = ShowcaseItemListViewModel(repository: repository)

        try await viewModel.fetchShowcaseItems()

        let item = ShowcaseItem.signInFlow
        let detailVM = viewModel.makeDetailViewModel(for: item)

        #expect(detailVM.id == item.id)
        #expect(detailVM.itemModel.id == item.id)
    }

    @MainActor
    @Test("fetchShowcaseItems guards against concurrent calls")
    func fetchGuardsAgainstConcurrentCalls() async throws {
        let repository = ShowcaseRepository.mockRepository()
        let viewModel = ShowcaseItemListViewModel(repository: repository)

        // Start first fetch
        async let fetch1: () = viewModel.fetchShowcaseItems()
        // Start second fetch immediately (should be guarded)
        async let fetch2: () = viewModel.fetchShowcaseItems()

        try await fetch1
        try await fetch2

        // Should complete without issues
        #expect(viewModel.hasLoadedOnce)
    }

    @MainActor
    @Test("filteredViewModels reflects completion state")
    func filteredViewModelsReflectsCompletionState() async throws {
        let repository = ShowcaseRepository.mockRepository()
        let viewModel = ShowcaseItemListViewModel(repository: repository)

        try await viewModel.fetchShowcaseItems()

        // Mark an item as completed
        let firstItem = repository.showcaseItems.first!
        repository.setCompleted(true, for: firstItem.id)

        // Check that filteredViewModels reflects this
        let cellVM = viewModel.filteredViewModels.first { $0.itemModel.id == firstItem.id }
        #expect(cellVM?.isCompleted == true)
    }
}
