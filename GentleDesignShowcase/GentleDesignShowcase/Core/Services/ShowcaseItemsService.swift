//  Jonathan Ritchey
import Foundation

protocol ShowcaseItemsServiceProtocol {
    func fetchShowcaseItems() async throws -> [ShowcaseItem]
}


struct ShowcaseItemsService: ShowcaseItemsServiceProtocol {
    func fetchShowcaseItems() async throws -> [ShowcaseItem] {
        []
    }
}
