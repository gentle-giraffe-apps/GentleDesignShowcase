import GentleDesignSystem
import SwiftUI

@main
struct GentleDesignShowcaseApp: App {
    @State private var router: AppRouter
    @State private var previewRenderer: PreviewRenderer
    @Environment(\.scenePhase) private var scenePhase
    @State private var hasLaunched = false
    @GentleDesignRuntime private var gentleDesign
    @State private var themeManager = GentleThemeManager(store: GentleFileThemeSpecStore())
    
    // Toggle this to switch between mock and live data
    private let useMockData = true

    init() {
        _router = .init(
            initialValue: AppRouter(
                showcaseRepository: ShowcaseRepository.mockRepository()
            )
        )
        _previewRenderer = .init(initialValue: PreviewRenderer())
    }

    var body: some Scene {
        WindowGroup {
            GentleThemeRoot(theme: themeManager.theme) {
                RootView()
                    .environment(router)
                    .environment(previewRenderer)
                    .environment(\.gentleThemeManager, themeManager)
                    .task {
                        do {
                            try themeManager.load()
                        } catch {
                            print("themeManager.load() \(error)")
                        }
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
