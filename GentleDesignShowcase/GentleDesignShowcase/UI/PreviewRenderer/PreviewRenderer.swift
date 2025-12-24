//  Jonathan Ritchey
import SmartAsyncImage
import SwiftUI
import Observation
import UIKit

@MainActor
@Observable
final class PreviewRenderer {

    // tweak these once and forget them
    let deviceSize = CGSize(width: 420, height: 700) // 400, 700
    let cropInsets = UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0)
    private var cache: [String: Image] = [:]

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
        cropInsetsPoints: UIEdgeInsets = .zero,   // in points
        waitForAsync: Duration = .zero
    ) async -> UIImage? {
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

        // Wait for async content (e.g., AsyncImage) to load from cache
        if waitForAsync > .zero {
            try? await Task.sleep(for: waitForAsync)
            hosting.view.setNeedsLayout()
            hosting.view.layoutIfNeeded()
        }

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
    func previewContainer(template: ShowcaseTemplate, displaySize: CGSize, colorScheme: ColorScheme) -> some View {
        ZStack {
            if let thumbnail = cache[template.key(using: colorScheme)] {
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
    private func preview(for template: ShowcaseTemplate, colorScheme: ColorScheme) -> some View {
        switch template {

        case .signInFlow:
            SignInView(
                viewModel: SignInViewModel()
            ).colorScheme(colorScheme)

        case .chartAndStats:
            NavigationStack {
                ChartAndStatsTemplateView()
                    .navigationTitle("Charts + Stats")
                    .navigationBarTitleDisplayMode(.inline)
            }.colorScheme(colorScheme)

        case .storefrontGrid:
            NavigationStack {
                StorefrontGridTemplateView()
                    .navigationTitle("Storefront")
                    .navigationBarTitleDisplayMode(.inline)
            }.colorScheme(colorScheme)

        case .onboardingPager:
            NavigationStack {
                OnboardingPagerTemplateView()
                    .navigationTitle("Onboarding")
                    .navigationBarTitleDisplayMode(.inline)
            }.colorScheme(colorScheme)

        case .medicalIntakeForm:
            NavigationStack {
                MedicalIntakeFormTemplateView()
                    .navigationTitle("Intake")
                    .navigationBarTitleDisplayMode(.inline)
            }.colorScheme(colorScheme)

        case .profileHeader:
            NavigationStack {
                ProfileHeaderTemplateView()
                    .navigationTitle("Profile")
                    .navigationBarTitleDisplayMode(.inline)
            }.colorScheme(colorScheme)
        }
    }
    
    func prefetch() async {
        // Pre-warm the URL cache so AsyncImage loads instantly from cache
        await preloadAsyncImageURLs()

        for t in ShowcaseTemplate.allCases {
            await generateThumbnailIfNeeded(
                template: t,
                for: preview(for: t, colorScheme: .light),
                deviceSize: deviceSize,
                colorScheme: .light
            )
            await generateThumbnailIfNeeded(
                template: t,
                for: preview(for: t, colorScheme: .dark),
                deviceSize: deviceSize,
                colorScheme: .dark
            )
        }
    }

    /// URLs used by AsyncImage in template views that need pre-loading
    private var asyncImageURLs: [URL] {
        [
            URL(string: ProfileHeaderTemplateViewModel.sample.avatarURL)
        ].compactMap { $0 }
    }

    /// Pre-downloads images into URLCache so AsyncImage can load them synchronously
    private func preloadAsyncImageURLs() async {
        let memoryCache = SmartAsyncImageMemoryCache.shared
        await withTaskGroup(of: Void.self) { group in
            for url in asyncImageURLs {
                group.addTask {
                    do {
                        try await _ = memoryCache.image(for: url)
                    } catch {
                        print("Failed to preload image: \(url) - \(error)")
                    }
                }
            }
        }
    }
    
    /// Templates that contain AsyncImage or other async-loading content
    private var templatesWithAsyncContent: Set<ShowcaseTemplate> {
        [.profileHeader]
    }

    func generateThumbnailIfNeeded(template: ShowcaseTemplate, for preview: some View, deviceSize: CGSize, colorScheme: ColorScheme) async {
        guard cache[template.key(using: colorScheme)] == nil else {
            return
        }

        // Allow extra time for templates with async content to load from cache
        let waitDuration: Duration = templatesWithAsyncContent.contains(template)
            ? .milliseconds(100)
            : .zero

        if let uiImage = await snapshotInHiddenContainer(
            view: ShowcaseFrame(
                size: deviceSize
            ) {
                preview
            },
            size: deviceSize,
            cropInsetsPoints: UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0),
            waitForAsync: waitDuration
        ) {
            cache[template.key(using: colorScheme)] = Image(uiImage: uiImage)
        }
    }
    
    private func activeWindowScene() -> UIWindowScene? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first { $0.activationState == .foregroundActive }
    }
}
