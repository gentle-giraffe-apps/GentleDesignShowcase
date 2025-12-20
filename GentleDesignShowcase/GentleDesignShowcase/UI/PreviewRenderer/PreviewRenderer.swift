//  Jonathan Ritchey
import SwiftUI
import Observation
import UIKit

@MainActor
@Observable
final class PreviewRenderer {

    // tweak these once and forget them
    let deviceSize = CGSize(width: 420, height: 700) // 400, 700
    let cropInsets = UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0)
    private var cache: [ShowcaseTemplate: Image] = [:]

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
        else {
            return nil
        }

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
    func previewContainer(template: ShowcaseTemplate, displaySize: CGSize) -> some View {
        ZStack {
            if let thumbnail = cache[template] {
                thumbnail
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(
                        width: displaySize.width,
                        height: displaySize.height,
                        alignment: .topLeading
                    )
                    .clipped()
            } else {
                Color(.secondarySystemBackground)
            }
        }
        .frame(width: displaySize.width)
        .aspectRatio(deviceSize.width / deviceSize.height, contentMode: .fit)
        .clipped()
    }
    
    @ViewBuilder
    private func preview(for template: ShowcaseTemplate) -> some View {
        switch template {
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
    
    func prefetch() async {
        for t in ShowcaseTemplate.allCases {
            await generateThumbnailIfNeeded(
                template: t,
                for: preview(for: t),
                deviceSize: deviceSize
            )
        }
    }
    
    func generateThumbnailIfNeeded(template: ShowcaseTemplate, for preview: some View, deviceSize: CGSize) async {
        guard cache[template] == nil else {
            return
        }
        // check cache
        if let _ = cache[template] {
            return
        }
        // finally generate from snapshot
        if let uiImage = snapshotInHiddenContainer(
            view: ShowcaseFrame(
                size: deviceSize
            ) {
                preview
            },
            size: deviceSize,
            cropInsetsPoints: UIEdgeInsets.init(top: 32, left: 0, bottom: 0, right: 0)
        ) {
            cache[template] = Image(uiImage: uiImage)
        }
    }
    
    private func activeWindowScene() -> UIWindowScene? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first { $0.activationState == .foregroundActive }
    }
}
