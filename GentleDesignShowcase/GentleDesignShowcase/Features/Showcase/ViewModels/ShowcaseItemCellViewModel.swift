//  Jonathan Ritchey

import Foundation

struct ShowcaseItemCellViewModel: Identifiable, Hashable {
    let id = UUID()
    let itemModel: ShowcaseItem
    let isCompleted: Bool
    
    init(
        itemModel: ShowcaseItem,
        isCompleted: Bool = false
    ) {
        self.itemModel = itemModel
        self.isCompleted = isCompleted
    }
}
