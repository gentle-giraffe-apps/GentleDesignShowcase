//  Jonathan Ritchey
import GentleDesignSystem
import SwiftUI

struct RootView: View {
    @Environment(AppRouter.self) var router
    @State private var selectedTab: RootViewTab = .items
    @GentleDesignRuntime private var gentleDesignRuntime
    
    init() {
        gentleDesignRuntime.theme.applyNavBarTitleColor(colorRole: .textPrimary)
    }
    
    var body: some View {
        TabContainerView(selectedTab: $selectedTab)
            .transition(.opacity) // very simple
            .environment(router)
    }
}

#Preview("RootView") {
    RootView()
        .environment(AppRouter.preview)
        .environment(PreviewRenderer())
}
