//  Jonathan Ritchey
import GentleDesignSystem
import SwiftUI
import Observation
import UIKit

struct ShowcaseFrame<Content: View>: View {
    let size: CGSize
    let topInset = CGFloat(20)
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .padding(.top, topInset) // add a little padding at the top?
            .frame(width: size.width, height: size.height)
            .clipped()
            .background(Color(.systemBackground))
    }
}

public let previewCardSize: CGSize = CGSize(width: 320, height: 580)

struct ShowcaseItemCellView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(PreviewRenderer.self) private var previewRenderer
    @GentleDesignRuntime private var gentleDesignRuntime
    let viewModel: ShowcaseItemCellViewModel
    let thumbNailDisplaySize = CGSize(
        width: previewCardSize.width,
        height: previewCardSize.height
    )
    var body: some View {
        ZStack {
            previewRenderer.previewContainer(
                template: viewModel.itemModel.template,
                displaySize: thumbNailDisplaySize
            )
            .mask(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: .white, location: 0.0),
                        .init(color: .white, location: 0.55),
                        .init(color: .clear, location: 0.92)
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
                .padding(.vertical, 20)
                .gentleSurface(.surfaceOverlay)
                .opacity(0.9)
                .overlay(
                    Rectangle()
                        .fill(Color.white.opacity(0.10))
                        .frame(height: 0.5),
                    alignment: .top
                )
            }
        }
        .frame(
            width: previewCardSize.width,
            height: previewCardSize.height
        )
        .gentleSurface(.cardChrome)
    }
}
