// Jonathan Ritchey
import Foundation

enum AppRoute: Hashable {
    case showcaseChartsAndStats(ShowcaseItem)
    case showcaseSignInFlow(ShowcaseItem)
    case showcaseMedicalIntakeForm(ShowcaseItem)
    case showcaseOnboardingFlow(ShowcaseItem)
    case showcaseProfileHeader(ShowcaseItem)
    case showcaseStoreFrontGrid(ShowcaseItem)
}
