//  Jonathan Ritchey
import Foundation

protocol ShowcaseItemsServiceProtocol: Sendable {
    func fetchShowcaseItems() async throws -> [ShowcaseItem]
}


struct ShowcaseItemsService: ShowcaseItemsServiceProtocol {
    func fetchShowcaseItems() async throws -> [ShowcaseItem] {
        ShowcaseItem.mocks
    }
}
