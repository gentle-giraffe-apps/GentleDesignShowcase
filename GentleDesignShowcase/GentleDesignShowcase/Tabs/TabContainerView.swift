// Jonathan Ritchey
import GentleDesignSystem
import SwiftUI

enum RootViewTab: Hashable, Equatable {
    case items
    case design
}

struct TabContainerView: View {
    @Binding var selectedTab: RootViewTab
    @GentleDesignRuntime private var design
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ShowcaseListTabRoot(selectedTab: $selectedTab)
                .tabItem {
                    Label("Showcase", systemImage: selectedTab == .items ? "photo.on.rectangle.fill" : "photo.on.rectangle")
                        .environment(\.symbolVariants, .none)
                }
                .tag(RootViewTab.items)
                .background(GentleNavigationBarStyler())
            DesignTabRoot()
                .tabItem {
                    Label("Design", systemImage: selectedTab == .design ? "paintbrush.pointed.fill" : "paintbrush.pointed")
                        .environment(\.symbolVariants, .none)
                }
                .tag(RootViewTab.design)
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

struct ShowcaseListTabRoot: View {
    @Environment(AppRouter.self) private var router
    @Binding var selectedTab: RootViewTab

    var body: some View {
        @Bindable var router = router
        NavigationStack(path: $router.showcaseTabPath) {
            ShowcaseItemListView(
                viewModel: ShowcaseItemListViewModel(repository: router.showcaseRepository),
                selectedTab: $selectedTab
            )
            .navigationDestination(for: AppRoute.self) { route in
                router.build(route)
            }
        }
    }
}

struct DesignTabRoot: View {
    @Environment(AppRouter.self) private var router
    
    var body: some View {
        @Bindable var router = router
        NavigationStack(path: $router.designTabPath) {
            GentleDesignStudioView()
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
