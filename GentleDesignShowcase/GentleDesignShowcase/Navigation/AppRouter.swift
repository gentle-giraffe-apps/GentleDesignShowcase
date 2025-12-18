// Jonathan Ritchey
import SwiftUI

@Observable
class AppRouter {
    enum Tab {
        case itemsTab, favoritesTab, settingsTab, profileTab
    }
    
    var itemsTabPath = NavigationPath()
    var favoritesTabPath = NavigationPath()
    var settingsTabPath = NavigationPath()
    var profileTabPath = NavigationPath()

    let showcaseRepository: ShowcaseRepository
    
    init(
        showcaseRepository: ShowcaseRepository
    ) {
        self.showcaseRepository = showcaseRepository
    }

    func push(_ route: AppRoute, for tab: Tab) {
        switch tab {
        case .itemsTab:
            itemsTabPath.append(route)
        case .favoritesTab:
            favoritesTabPath.append(route)
        case .settingsTab:
            settingsTabPath.append(route)
        case .profileTab:
            profileTabPath.append(route)
        }
    }
    
    @ViewBuilder
    func build(_ route: AppRoute) -> some View {
        switch route {
        case .itemsListView:
            ShowcaseItemListView(
                viewModel: ShowcaseItemListViewModel(repository: showcaseRepository)
            )
        case .itemDetailView(let itemModel):
            ShowcaseItemDetailView(
                viewModel: ShowcaseItemDetailViewModel(
                    itemModel: itemModel,
                    repository: showcaseRepository
                )
            )
        }
    }
}
