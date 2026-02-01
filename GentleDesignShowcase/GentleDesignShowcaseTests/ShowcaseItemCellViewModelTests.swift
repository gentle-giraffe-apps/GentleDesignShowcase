import Foundation
import Testing
@testable import GentleDesignShowcase

@Suite("ShowcaseItemCellViewModel Tests")
struct ShowcaseItemCellViewModelTests {

    @Test("Initialization sets itemModel")
    func initializationSetsItemModel() {
        let item = ShowcaseItem.signInFlow
        let viewModel = ShowcaseItemCellViewModel(itemModel: item)
        #expect(viewModel.itemModel.id == item.id)
    }

    @Test("Initialization defaults isCompleted to false")
    func initializationDefaultsIsCompletedToFalse() {
        let item = ShowcaseItem.signInFlow
        let viewModel = ShowcaseItemCellViewModel(itemModel: item)
        #expect(!viewModel.isCompleted)
    }

    @Test("Initialization accepts isCompleted parameter")
    func initializationAcceptsIsCompleted() {
        let item = ShowcaseItem.signInFlow
        let viewModel = ShowcaseItemCellViewModel(itemModel: item, isCompleted: true)
        #expect(viewModel.isCompleted)
    }

    @Test("ID is generated as UUID")
    func idIsGeneratedAsUUID() {
        let item = ShowcaseItem.signInFlow
        let viewModel = ShowcaseItemCellViewModel(itemModel: item)
        #expect(!viewModel.id.uuidString.isEmpty)
    }

    @Test("Each instance has unique ID")
    func eachInstanceHasUniqueID() {
        let item = ShowcaseItem.signInFlow
        let viewModel1 = ShowcaseItemCellViewModel(itemModel: item)
        let viewModel2 = ShowcaseItemCellViewModel(itemModel: item)
        #expect(viewModel1.id != viewModel2.id)
    }

    @Test("Conforms to Identifiable")
    func conformsToIdentifiable() {
        let item = ShowcaseItem.signInFlow
        let viewModel: any Identifiable = ShowcaseItemCellViewModel(itemModel: item)
        #expect(viewModel.id != nil)
    }

    @Test("Conforms to Hashable")
    func conformsToHashable() {
        let item = ShowcaseItem.signInFlow
        let viewModel = ShowcaseItemCellViewModel(itemModel: item)

        // Can be used in a Set
        var set = Set<ShowcaseItemCellViewModel>()
        set.insert(viewModel)
        #expect(set.count == 1)
    }

    @Test("Different items create distinct view models")
    func differentItemsCreateDistinctViewModels() {
        let vm1 = ShowcaseItemCellViewModel(itemModel: ShowcaseItem.signInFlow)
        let vm2 = ShowcaseItemCellViewModel(itemModel: ShowcaseItem.chartAndStats)
        #expect(vm1.itemModel.id != vm2.itemModel.id)
    }
}
