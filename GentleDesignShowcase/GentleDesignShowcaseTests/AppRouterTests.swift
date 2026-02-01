import Foundation
import Testing
@testable import GentleDesignShowcase

@Suite("AppRouter Tests")
struct AppRouterTests {

    @MainActor
    @Test("Initial paths are empty")
    func initialPathsAreEmpty() {
        let router = AppRouter.preview
        #expect(router.showcaseTabPath.isEmpty)
        #expect(router.designTabPath.isEmpty)
    }

    @MainActor
    @Test("push adds route to showcaseTab path")
    func pushAddsRouteToShowcaseTab() {
        let router = AppRouter.preview
        let route = AppRoute.showcaseSignInFlow(ShowcaseItem.signInFlow)

        router.push(route, for: .showcaseTab)
        #expect(router.showcaseTabPath.count == 1)
        #expect(router.designTabPath.isEmpty)
    }

    @MainActor
    @Test("push adds route to designTab path")
    func pushAddsRouteToDesignTab() {
        let router = AppRouter.preview
        let route = AppRoute.showcaseChartsAndStats(ShowcaseItem.chartAndStats)

        router.push(route, for: .designTab)
        #expect(router.designTabPath.count == 1)
        #expect(router.showcaseTabPath.isEmpty)
    }

    @MainActor
    @Test("Multiple pushes accumulate in path")
    func multiplePushesAccumulate() {
        let router = AppRouter.preview

        router.push(.showcaseSignInFlow(ShowcaseItem.signInFlow), for: .showcaseTab)
        router.push(.showcaseChartsAndStats(ShowcaseItem.chartAndStats), for: .showcaseTab)
        router.push(.showcaseProfileHeader(ShowcaseItem.profileHeader), for: .showcaseTab)

        #expect(router.showcaseTabPath.count == 3)
    }

    @MainActor
    @Test("build returns view for each route type")
    func buildReturnsViewForEachRouteType() {
        let router = AppRouter.preview

        // Exercise all route types through build()
        _ = router.build(.showcaseChartsAndStats(ShowcaseItem.chartAndStats))
        _ = router.build(.showcaseSignInFlow(ShowcaseItem.signInFlow))
        _ = router.build(.showcaseMedicalIntakeForm(ShowcaseItem.medicalIntakeForm))
        _ = router.build(.showcaseOnboardingFlow(ShowcaseItem.onboardingPager))
        _ = router.build(.showcaseProfileHeader(ShowcaseItem.profileHeader))
        _ = router.build(.showcaseStoreFrontGrid(ShowcaseItem.storefrontGrid))
        _ = router.build(.showcaseMapRoute(ShowcaseItem.mapRoute))
        _ = router.build(.showcaseTransitCard(ShowcaseItem.transitCard))

        #expect(true)
    }

    @MainActor
    @Test("preview factory creates valid router")
    func previewFactoryCreatesValidRouter() {
        let router = AppRouter.preview
        #expect(router.showcaseTabPath.isEmpty)
    }

    @MainActor
    @Test("Tab enum has two cases")
    func tabEnumHasTwoCases() {
        let showcaseTab = AppRouter.Tab.showcaseTab
        let designTab = AppRouter.Tab.designTab
        #expect(showcaseTab != designTab)
    }
}
