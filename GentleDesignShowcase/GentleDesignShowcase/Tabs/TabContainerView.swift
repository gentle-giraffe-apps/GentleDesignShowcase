// Jonathan Ritchey
import GentleDesignSystem
import SwiftUI

enum RootViewTab: Hashable {
    case items
    case favorites
    case settings
    case profile
}

struct TabContainerView: View {
    @Binding var selectedTab: RootViewTab
    @GentleDesignRuntime private var design
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ItemsListTabRoot()
                .tabItem {
                    Label("Items", systemImage: selectedTab == .items ? "shippingbox.fill" : "shippingbox")
                        .environment(\.symbolVariants, .none)
                }
                .tag(RootViewTab.items)
                .background(GentleNavigationBarStyler())
            Text("Favorites")
                .tabItem {
                    Label("Favorites", systemImage: selectedTab == .favorites ? "heart.fill" : "heart")
                        .environment(\.symbolVariants, .none)
                }
                .tag(RootViewTab.favorites)
                .background(GentleNavigationBarStyler())
            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "signature")
                }
                .tag(RootViewTab.settings)
                .background(GentleNavigationBarStyler())
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: selectedTab == .profile ? "person.fill" : "person")
                        .environment(\.symbolVariants, .none)
                }
                .tag(RootViewTab.profile)
                .background(GentleNavigationBarStyler())
        }
    }
    
    @ViewBuilder
    func ProfileView() -> some View {
        Button("Sign Out") {
//            Task {
//                await session.signOut()
//                selectedTab = .items
//            }
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
        .environment(AppRouter.preview)
        .environment(PreviewRenderer())
}
