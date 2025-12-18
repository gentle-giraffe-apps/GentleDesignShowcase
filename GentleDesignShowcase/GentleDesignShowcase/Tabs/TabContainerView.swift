// Jonathan Ritchey

import SwiftUI

enum RootViewTab: Hashable {
    case items
    case favorites
    case settings
    case profile
}

struct TabContainerView: View {
    @Environment(SessionManager.self) var session
    @Binding var selectedTab: RootViewTab
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ItemsListTabRoot()
                .tabItem {
                    Label("Items", systemImage: "shippingbox")
                }
                .tag(RootViewTab.items)
            Text("Favorites")
                .tabItem {
                    Label("Favorites", systemImage: selectedTab == .favorites ? "heart.fill" : "heart")
                        .environment(\.symbolVariants, .none)
                }
                .tag(RootViewTab.favorites)
            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "signature")
                }
                .tag(RootViewTab.settings)
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: selectedTab == .profile ? "person.fill" : "person")
                        .environment(\.symbolVariants, .none)
                }
                .tag(RootViewTab.profile)
        }
    }
    
    @ViewBuilder
    func ProfileView() -> some View {
        Button("Sign Out") {
            Task {
                await session.signOut()
                selectedTab = .items
            }
        }
        .buttonStyle(.bordered)
    }
}

struct ItemsListTabRoot: View {
    @Environment(AppRouter.self) private var router

    var body: some View {
        @Bindable var router = router
        NavigationStack(path: $router.itemsTabPath) {
            ShowcaseItemListView(
                viewModel: ShowcaseItemListViewModel(repository: router.showcaseRepository)
            )
            .navigationDestination(for: AppRoute.self) { route in
                router.build(route)
            }
        }
    }
}

#Preview {
    TabContainerView(selectedTab: .constant(.items))
        .environment(
            AppRouter(
                showcaseRepository: ShowcaseRepository.mockRepository()
            )
        )
}
