import Foundation
import Testing
@testable import GentleDesignShowcase

@Suite("ShowcaseItemDetailViewModel Tests")
struct ShowcaseItemDetailViewModelTests {

    @MainActor
    @Test("Initialization sets item model")
    func initializationSetsItemModel() {
        let item = ShowcaseItem.signInFlow
        let repository = ShowcaseRepository.mockRepository()
        let viewModel = ShowcaseItemDetailViewModel(itemModel: item, repository: repository)
        #expect(viewModel.itemModel.id == item.id)
    }

    @MainActor
    @Test("ID matches item model ID")
    func idMatchesItemModel() {
        let item = ShowcaseItem.chartAndStats
        let repository = ShowcaseRepository.mockRepository()
        let viewModel = ShowcaseItemDetailViewModel(itemModel: item, repository: repository)
        #expect(viewModel.id == item.id)
    }

    @MainActor
    @Test("Title is set")
    func titleIsSet() {
        let item = ShowcaseItem.signInFlow
        let repository = ShowcaseRepository.mockRepository()
        let viewModel = ShowcaseItemDetailViewModel(itemModel: item, repository: repository)
        #expect(viewModel.title == "title")
    }

    @MainActor
    @Test("Origin panel is initialized")
    func originPanelInitialized() {
        let item = ShowcaseItem.signInFlow
        let repository = ShowcaseRepository.mockRepository()
        let viewModel = ShowcaseItemDetailViewModel(itemModel: item, repository: repository)
        #expect(viewModel.originPanel.title == "origin")
        #expect(viewModel.originPanel.subTitle == "Origin")
    }

    @MainActor
    @Test("Destination panel is initialized")
    func destinationPanelInitialized() {
        let item = ShowcaseItem.signInFlow
        let repository = ShowcaseRepository.mockRepository()
        let viewModel = ShowcaseItemDetailViewModel(itemModel: item, repository: repository)
        #expect(viewModel.destinationPanel.title == "destination")
        #expect(viewModel.destinationPanel.subTitle == "Destination")
    }

    @MainActor
    @Test("markCompleted updates repository")
    func markCompletedUpdatesRepository() {
        let item = ShowcaseItem.signInFlow
        let repository = ShowcaseRepository.mockRepository()
        let viewModel = ShowcaseItemDetailViewModel(itemModel: item, repository: repository)

        viewModel.markCompleted(true)
        #expect(repository.isCompleted(id: item.id))

        viewModel.markCompleted(false)
        #expect(!repository.isCompleted(id: item.id))
    }

    @MainActor
    @Test("isCompleted reflects repository state")
    func isCompletedReflectsRepository() {
        let item = ShowcaseItem.chartAndStats
        let repository = ShowcaseRepository.mockRepository()

        // Initially not completed
        let viewModel = ShowcaseItemDetailViewModel(itemModel: item, repository: repository)
        #expect(!viewModel.isCompleted)
    }

    @MainActor
    @Test("Panel struct holds values correctly")
    func panelStructHoldsValues() {
        let panel = ShowcaseItemDetailViewModel.Panel(title: "Test", subTitle: "Subtitle")
        #expect(panel.title == "Test")
        #expect(panel.subTitle == "Subtitle")
    }
}
