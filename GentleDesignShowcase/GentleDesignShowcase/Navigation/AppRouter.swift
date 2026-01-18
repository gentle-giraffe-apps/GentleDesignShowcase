// Jonathan Ritchey
import SwiftUI

@MainActor
@Observable
class AppRouter {
    enum Tab {
        case showcaseTab, designTab
    }
    
    var showcaseTabPath = NavigationPath()
    var designTabPath = NavigationPath()

    let showcaseRepository: ShowcaseRepository
    
    init(
        showcaseRepository: ShowcaseRepository
    ) {
        self.showcaseRepository = showcaseRepository
    }

    func push(_ route: AppRoute, for tab: Tab) {
        switch tab {
        case .showcaseTab:
            showcaseTabPath.append(route)
        case .designTab:
            designTabPath.append(route)
        }
    }
    
    @ViewBuilder
    func build(_ route: AppRoute) -> some View {
        switch route {
        case .showcaseChartsAndStats(_):
            ChartsTemplateView()
        case .showcaseSignInFlow(_):
            SignInView()
        case .showcaseMedicalIntakeForm(_):
            MedicalIntakeFormTemplateView()
        case .showcaseOnboardingFlow(_):
            OnboardingPagerTemplateView()
        case .showcaseProfileHeader(_):
            ProfileHeaderTemplateView()
        case .showcaseStoreFrontGrid(_):
            StorefrontGridTemplateView()
        }
    }
    
    static var preview: AppRouter {
        AppRouter(showcaseRepository: ShowcaseRepository.mockRepository())
    }
}
