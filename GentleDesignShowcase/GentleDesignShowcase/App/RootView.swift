//  Jonathan Ritchey

import SwiftUI

struct RootView: View {
    @Environment(SessionManager.self) var session
    @Environment(AppRouter.self) var router
    @State private var selectedTab: RootViewTab = .items
    
    var body: some View {
        ZStack {
            switch session.state {
            case .loading:
                ProgressView("Checking session...")
            case .signedOut:
                SignInView()
                    .transition(.opacity) // very simple
                    .environment(session)
            case .signedIn:
                TabContainerView(selectedTab: $selectedTab)
                    .transition(.opacity) // very simple
                    .environment(session)
                    .environment(router)
            }
        }
        .animation(.easeInOut(duration: 0.15), value: session.state)
    }
}

#Preview("RootView") {
    RootView()
        .environment(SessionManager(service: SessionManagerMockAuthService()))
        .environment(
            AppRouter(showcaseRepository: ShowcaseRepository.mockRepository())
        )
}
