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

@MainActor
@Observable
class ThumbnailSnapshot {
    
    class WrappedKey: NSObject {
        let template: ShowcaseTemplate
        init(template: ShowcaseTemplate) {
            self.template = template
        }
    }
    
    static var cache = NSCache<WrappedKey, UIImage>()
    private var thumbnail: Image?

    private func imageWithRedBorder(_ image: UIImage, lineWidth: CGFloat = 2) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = image.scale
        format.opaque = false

        let renderer = UIGraphicsImageRenderer(size: image.size, format: format)
        return renderer.image { ctx in
            image.draw(at: .zero)

            let rect = CGRect(origin: .zero, size: image.size)
                .insetBy(dx: lineWidth / 2, dy: lineWidth / 2)

            ctx.cgContext.setStrokeColor(UIColor.red.cgColor)
            ctx.cgContext.setLineWidth(lineWidth)
            ctx.cgContext.stroke(rect)
        }
    }
    
    func snapshotInHiddenContainer<V: View>(
        view: V,
        size: CGSize,
        cropInsetsPoints: UIEdgeInsets = .zero   // in points
    ) -> UIImage? {
        guard let windowScene = activeWindowScene(),
              let window = windowScene.windows.first(where: { $0.isKeyWindow })
        else { return nil }

        let hosting = UIHostingController(rootView: view)
        hosting.view.bounds = CGRect(origin: .zero, size: size)
        hosting.view.backgroundColor = .clear

        hosting.additionalSafeAreaInsets = .zero
        hosting.view.insetsLayoutMarginsFromSafeArea = false
        hosting.view.layoutMargins = .zero
        
        let container = UIView(frame: hosting.view.bounds)
        container.isHidden = true
        container.alpha = 0.0
        window.addSubview(container)

        container.addSubview(hosting.view)
        hosting.view.setNeedsLayout()
        hosting.view.layoutIfNeeded()

        let format = UIGraphicsImageRendererFormat()
        format.scale = window.windowScene?.screen.scale ?? hosting.traitCollection.displayScale
        format.opaque = false

        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        let full = renderer.image { _ in
            hosting.view.drawHierarchy(in: hosting.view.bounds, afterScreenUpdates: true)
        }

        hosting.view.removeFromSuperview()
        container.removeFromSuperview()

        // No crop requested
        guard cropInsetsPoints != .zero else { return full }

        let scale = full.scale
        let cropRectPixels = CGRect(
            x: cropInsetsPoints.left * scale,
            y: cropInsetsPoints.top * scale,
            width: (size.width - cropInsetsPoints.left - cropInsetsPoints.right) * scale,
            height: (size.height - cropInsetsPoints.top - cropInsetsPoints.bottom) * scale
        ).integral

        guard
            let cg = full.cgImage,
            cropRectPixels.width > 1,
            cropRectPixels.height > 1,
            let croppedCG = cg.cropping(to: cropRectPixels)
        else { return full }

        let cropped = UIImage(
            cgImage: croppedCG,
            scale: scale,
            orientation: full.imageOrientation
        )

        // ✅ outline *cropped* result
        // return imageWithRedBorder(cropped)
        return cropped
    }

    @ViewBuilder
    func previewContainer(template: ShowcaseTemplate, preview: some View, deviceSize: CGSize, displaySize: CGSize) -> some View {
        ZStack {
            if let thumbnail {
                thumbnail
                    .resizable()
                    .scaledToFill()
            } else {
                Color(.secondarySystemBackground)
            }
        }
        .frame(width: displaySize.width)
        .aspectRatio(deviceSize.width / deviceSize.height, contentMode: .fit)
        .clipped()
        .task { [weak self] in
            await self?.generateThumbnailIfNeeded(
                template: template,
                for: preview,
                deviceSize: deviceSize
            )
        }
    }
    
    private func generateThumbnailIfNeeded(template: ShowcaseTemplate, for preview: some View, deviceSize: CGSize) async {
        guard thumbnail == nil else {
            return
        }
        if let uiImage = snapshotInHiddenContainer(
            view: ShowcaseFrame(
                size: deviceSize
            ) {
                preview
                    .ignoresSafeArea()
                    .statusBarHidden(true)
                    .toolbar(.hidden, for: .navigationBar)
                    .toolbar(.hidden, for: .tabBar)
            },
            size: deviceSize,
            cropInsetsPoints: UIEdgeInsets.init(top: 32, left: 0, bottom: 0, right: 0)
        ) {
            let wrappedKey = WrappedKey(template: template)
            ThumbnailSnapshot.cache.setObject(uiImage, forKey: wrappedKey)
            thumbnail = Image(uiImage: uiImage)
        }
    }
    
    private func activeWindowScene() -> UIWindowScene? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first { $0.activationState == .foregroundActive }
    }
}

struct ShowcaseItemCellView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    let viewModel: ShowcaseItemCellViewModel
    @State var thumbNail = ThumbnailSnapshot()
    let thumbNailDisplaySize = CGSize(width: 360, height: 400)
    
    var body: some View {
        let deviceSize = CGSize(width: 393, height: 450)
        VStack(alignment: .leading, spacing: 0) {
            thumbNail.previewContainer(
                template: viewModel.itemModel.template,
                preview: preview,
                deviceSize: deviceSize,
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
