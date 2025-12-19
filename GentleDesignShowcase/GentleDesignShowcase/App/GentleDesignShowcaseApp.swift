import GentleDesignSystem
import SwiftUI

@main
struct GentleDesignShowcaseApp: App {
    @State private var router: AppRouter
    @Environment(\.scenePhase) private var scenePhase
    @State private var hasLaunched = false
    @State private var didAttemptSignIn = false   // add this

    // Toggle this to switch between mock and live data
    private let useMockData = true

    init() {
        _router = .init(
            initialValue: AppRouter(
                showcaseRepository: ShowcaseRepository.mockRepository()
            )
        )
    }

    var body: some Scene {
        WindowGroup {
            GentleThemeRoot(theme: .default) {
                RootView()
                    .environment(router)
                    .task {
                        // Run once
                        guard !didAttemptSignIn else { return }
                        didAttemptSignIn = true
                        // MARK: - Sign in placeholder
                    }
            }
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if hasLaunched && oldPhase == .inactive && newPhase == .active {
                print("resumed from suspended state")
                Task { @MainActor in
                    router.showcaseRepository.resumeFromSuspendedState()
                }
            }
            hasLaunched = true
        }
    }
}
