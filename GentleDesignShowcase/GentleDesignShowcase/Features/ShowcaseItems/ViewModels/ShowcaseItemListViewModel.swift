//  Jonathan Ritchey

import Observation

@MainActor
@Observable
class ShowcaseItemListViewModel {
    enum Filter: String, CaseIterable {
        case upcoming = "Upcoming"
        case past = "Past"
    }

    private(set) var isLoading = false
    private(set) var hasLoadedOnce = false

    let title = "Showcase Items"
    private let repository: ShowcaseRepository
    var filter: Filter = .upcoming

    var upcomingCellViewModels: [ShowcaseItemCellViewModel] {
        repository.upcomingItems.map { itemModel in
            ShowcaseItemCellViewModel(
                itemModel: itemModel,
                isCompleted: repository.isCompleted(id: itemModel.id)
            )
        }
    }

    var pastCellViewModels: [ShowcaseItemCellViewModel] {
        repository.pastItems.map { itemModel in
            ShowcaseItemCellViewModel(
                itemModel: itemModel,
                isCompleted: repository.isCompleted(id: itemModel.id)
            )
        }
    }
    
    init(
        repository: ShowcaseRepository
    ) {
        self.repository = repository
    }
    
    func fetchShowcaseItems() async throws {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        try await repository.loadShowcaseItems()
        hasLoadedOnce = true
    }
    
    func makeDetailViewModel(for itemModel: ShowcaseItem) -> ShowcaseItemDetailViewModel {
        ShowcaseItemDetailViewModel(
            itemModel: itemModel,
            repository: repository
        )
    }
}
