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
    @GentleDesignRuntime private var gentleDesignRuntime
    let viewModel: ShowcaseItemCellViewModel
    let thumbNailDisplaySize = CGSize(width: 360, height: 400)
    
    var body: some View {
        ZStack {
            previewRenderer.previewContainer(
                template: viewModel.itemModel.template,
                displaySize: thumbNailDisplaySize
            )
            .mask(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: .white, location: 0.66),
                        .init(color: .clear, location: 0.88),
                        .init(color: .clear, location: 0.99)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            VStack {
                Spacer()
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(viewModel.itemModel.title)
                            .gentleText(
                                .title3_ml,
                                colorRole: .onSurfaceOverlayPrimary
                            )
                        if let subtitle = viewModel.itemModel.subtitle {
                            Text(subtitle)
                                .gentleText(
                                    .bodySecondary_m,
                                    colorRole: .onSurfaceOverlaySecondary
                                )
                        }
                    }
                    .padding(.horizontal, 10)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .gentleSurface(.surfaceOverlay)
                .opacity(0.9)
            }
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
