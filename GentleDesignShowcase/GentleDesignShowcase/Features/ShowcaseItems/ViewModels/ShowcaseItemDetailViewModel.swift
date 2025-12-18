//  Jonathan Ritchey

import Foundation

@MainActor
@Observable
final class ShowcaseItemDetailViewModel: Identifiable {
    
    struct Panel {
        let title: String
        let subTitle: String
    }
    
    var id: String { itemModel.id }
    let itemModel: ShowcaseItem
    let repository: ShowcaseRepository
    
    let title: String
    let originPanel: Panel
    let destinationPanel: Panel
    
    var isCompleted: Bool
    
    init(
        itemModel: ShowcaseItem,
        repository: ShowcaseRepository
    ) {
        self.itemModel = itemModel
        self.repository = repository
        self.title = "title"
        self.originPanel = .init(title: "origin", subTitle: "Origin")
        self.destinationPanel = .init(title: "destination", subTitle: "Destination")
        self.isCompleted = repository.isCompleted(id: itemModel.id)
    }
    
    func markCompleted(_ newValue: Bool) {
        repository.setCompleted(newValue, for: itemModel.id)
    }
}
