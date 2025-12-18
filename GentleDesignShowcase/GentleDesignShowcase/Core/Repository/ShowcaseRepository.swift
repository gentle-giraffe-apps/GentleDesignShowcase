//  Jonathan Ritchey

import Foundation
import Observation

@MainActor
@Observable
final class ShowcaseRepository {
    private let showcaseItemsService: ShowcaseItemsServiceProtocol
    private let completionStore: CompletedShowcaseItemsStore

    var showcaseItems: [ShowcaseItem] = []
    var upcomingItems: [ShowcaseItem] = []
    var pastItems: [ShowcaseItem] = []
    var completedIDs: Set<String> = []

    init(
        showcaseItemsService: ShowcaseItemsServiceProtocol,
        completionStore: CompletedShowcaseItemsStore? = nil
    ) {
        self.showcaseItemsService = showcaseItemsService
        self.completionStore = completionStore ?? UserDefaultsCompletedShowcaseItemsStore()
        self.completedIDs = self.completionStore.completedIDs()
    }

    func loadShowcaseItems() async throws {
        showcaseItems = try await showcaseItemsService.fetchShowcaseItems()
    }

    func setCompleted(_ completed: Bool, for id: String) {
        completionStore.setCompleted(completed, for: id)
        // completedIDs acts as cache, it's being observed
        if completed {
            completedIDs.insert(id)
        } else {
            completedIDs.remove(id)
        }
    }

    func isCompleted(id: String) -> Bool {
        return completedIDs.contains(id)
    }
    
    func resumeFromSuspendedState() {
        // handle suspend resume code here
    }
        
    // Only use this once at the AppRouter level please, or in #Previews.
    static func mockRepository() -> ShowcaseRepository {
        ShowcaseRepository(
            showcaseItemsService: ShowcaseItemsService(), // ShowcaseItemsService.mock(),
            completionStore: UserDefaultsCompletedShowcaseItemsStore()
        )
    }
}

protocol CompletedShowcaseItemsStore {
    func completedIDs() -> Set<String>
    func isCompleted(id: String) -> Bool
    func setCompleted(_ completed: Bool, for id: String)
}

final class UserDefaultsCompletedShowcaseItemsStore: CompletedShowcaseItemsStore {
    private let key = "completedShowcaseItemIDs"
    private var cache: Set<String>? = nil

    func completedIDs() -> Set<String> {
        if cache == nil {
            if let array = UserDefaults.standard.stringArray(forKey: key) {
                cache = Set(array)
            } else {
                cache = Set<String>()
            }
        }
        return cache ?? Set<String>()
    }

    func isCompleted(id: String) -> Bool {
        completedIDs().contains(id)
    }
    
    func setCompleted(_ completed: Bool, for id: String) {
        var ids = completedIDs()
        if completed {
            ids.insert(id)
            cache?.insert(id)
        } else {
            ids.remove(id)
            cache?.remove(id)
        }
        UserDefaults.standard.set(Array(ids), forKey: key)
    }
}
