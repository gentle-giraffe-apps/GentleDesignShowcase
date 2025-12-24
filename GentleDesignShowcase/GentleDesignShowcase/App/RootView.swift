//  Jonathan Ritchey
import GentleDesignSystem
import SwiftUI

struct RootView: View {
    @Environment(AppRouter.self) var router
    @State private var selectedTab: RootViewTab = .items
    
    init() {
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
