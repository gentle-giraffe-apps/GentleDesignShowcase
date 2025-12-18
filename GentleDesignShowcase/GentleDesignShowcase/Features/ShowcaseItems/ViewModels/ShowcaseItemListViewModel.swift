//  Jonathan Ritchey

import Observation

@MainActor
@Observable
class ShowcaseItemListViewModel {
    private(set) var isLoading = false
    private(set) var hasLoadedOnce = false

    let title = "Showcase Items"
    private let repository: ShowcaseRepository

    var filteredViewModels: [ShowcaseItemCellViewModel] {
        repository.showcaseItems.map { itemModel in
            ShowcaseItemCellViewModel(
                itemModel: itemModel,
                isCompleted: repository.isCompleted(id: itemModel.id)
            )
        }
    }
        
    init(repository: ShowcaseRepository) {
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
