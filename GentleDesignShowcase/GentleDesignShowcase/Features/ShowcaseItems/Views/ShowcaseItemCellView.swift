//  Jonathan Ritchey
import GentleDesignSystem
import SwiftUI
import Observation
import UIKit

struct ShowcaseFrame<Content: View>: View {
    let size: CGSize
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .frame(width: size.width, height: size.height)
            .clipped()
            .background(Color(.systemBackground))
    }
}

struct ShowcaseItemCellView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(PreviewRenderer.self) private var previewRenderer
    let viewModel: ShowcaseItemCellViewModel
    let thumbNailDisplaySize = CGSize(width: 360, height: 400)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            previewRenderer.previewContainer(
                template: viewModel.itemModel.template,
                displaySize: thumbNailDisplaySize
            )
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.itemModel.title)
                        .gentleText(.headline_m)
                    if let subtitle = viewModel.itemModel.subtitle {
                        Text(subtitle)
                            .gentleText(.subheadline_ms)
                    }
                }
                .padding(.horizontal, 10)
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .frame(
            maxWidth: horizontalSizeClass == .compact ? 350 : 450,
            minHeight: 400
        )
        .gentleSurface(.cardChrome)
    }
    
    @ViewBuilder
    var preview: some View {
        switch viewModel.itemModel.template {
        case .signInFlow:
            SignInView(
                viewModel: SignInViewModel(
                    username: "Username",
                    password: "Password"
                )
            )
        case .chartAndStats:
            ChartAndStatsTemplateView()
        case .storefrontGrid:
            StorefrontGridTemplateView()
        case .onboardingPager:
            OnboardingPagerTemplateView()
        case .medicalIntakeForm:
            MedicalIntakeFormTemplateView()
        case .profileHeader:
            ProfileHeaderTemplateView()
        }
    }
}
