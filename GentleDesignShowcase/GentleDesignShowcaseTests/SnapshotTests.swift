import SnapshotTesting
import SnapshotTestingHEIC
import SwiftUI
import XCTest
@testable import GentleDesignShowcase

/// Snapshot tests for SwiftUI views
/// Reference snapshots are stored in __Snapshots__ directory as HEIC files
/// HEIC provides ~63-98% smaller files than PNG while maintaining quality
@MainActor
final class SnapshotTests: XCTestCase {

    // iPhone 17 dimensions (393 x 852 points at 3x scale)
    static let iPhone17Config = ViewImageConfig(
        safeArea: UIEdgeInsets(top: 59, left: 0, bottom: 34, right: 0),
        size: CGSize(width: 393, height: 852),
        traits: UITraitCollection { traits in
            traits.displayScale = 3.0
            traits.userInterfaceStyle = .light
        }
    )

    static let iPhone17ConfigDark = ViewImageConfig(
        safeArea: UIEdgeInsets(top: 59, left: 0, bottom: 34, right: 0),
        size: CGSize(width: 393, height: 852),
        traits: UITraitCollection { traits in
            traits.displayScale = 3.0
            traits.userInterfaceStyle = .dark
        }
    )

    override func setUp() {
        super.setUp()
        // Set to true to record new snapshots, false to compare
        // isRecording = true
    }

    // MARK: - Template Views

    @MainActor
    func testTransitCardTemplateView() {
        let view = TransitCardTemplateView()
            .frame(width: 393, height: 852)

        assertSnapshot(of: view, as: .imageHEIC(layout: .device(config: Self.iPhone17Config), compressionQuality: .maximum))
    }

    @MainActor
    func testChartsTemplateView() {
        let view = ChartsTemplateView()
            .frame(width: 393, height: 852)

        assertSnapshot(of: view, as: .imageHEIC(layout: .device(config: Self.iPhone17Config), compressionQuality: .maximum))
    }

    @MainActor
    func testSignInView() {
        let view = SignInView()
            .frame(width: 393, height: 852)

        assertSnapshot(of: view, as: .imageHEIC(layout: .device(config: Self.iPhone17Config), compressionQuality: .maximum))
    }

// issues with github version on this.
//    @MainActor
//    func testMedicalIntakeFormTemplateView() {
//        let view = MedicalIntakeFormTemplateView()
//            .frame(width: 393, height: 852)
//
//        assertSnapshot(of: view, as: .imageHEIC(layout: .device(config: Self.iPhone17Config), compressionQuality: .maximum))
//    }

    @MainActor
    func testOnboardingPagerTemplateView() {
        let view = OnboardingPagerTemplateView()
            .frame(width: 393, height: 852)

        assertSnapshot(of: view, as: .imageHEIC(layout: .device(config: Self.iPhone17Config), compressionQuality: .maximum))
    }

    @MainActor
    func testProfileHeaderTemplateView() {
        let view = ProfileHeaderTemplateView()
            .frame(width: 393, height: 852)

        assertSnapshot(of: view, as: .imageHEIC(layout: .device(config: Self.iPhone17Config), compressionQuality: .maximum))
    }

    @MainActor
    func testStorefrontGridTemplateView() {
        let view = StorefrontGridTemplateView()
            .frame(width: 393, height: 852)

        assertSnapshot(of: view, as: .imageHEIC(layout: .device(config: Self.iPhone17Config), compressionQuality: .maximum))
    }

    // Note: MapRouteTemplateView is skipped because MapKit views
    // require async tile loading and don't snapshot reliably

    // MARK: - Detail View

    @MainActor
    func testShowcaseItemDetailView() {
        let repository = ShowcaseRepository.mockRepository()
        let viewModel = ShowcaseItemDetailViewModel(
            itemModel: ShowcaseItem.signInFlow,
            repository: repository
        )
        let view = ShowcaseItemDetailView(viewModel: viewModel)
            .frame(width: 393, height: 852)

        assertSnapshot(of: view, as: .imageHEIC(layout: .device(config: Self.iPhone17Config), compressionQuality: .maximum))
    }

    // MARK: - Dark Mode Variants

    @MainActor
    func testSignInViewDarkMode() {
        let view = SignInView()
            .frame(width: 393, height: 852)
            .environment(\.colorScheme, .dark)

        assertSnapshot(of: view, as: .imageHEIC(layout: .device(config: Self.iPhone17ConfigDark), compressionQuality: .maximum))
    }

    @MainActor
    func testTransitCardTemplateViewDarkMode() {
        let view = TransitCardTemplateView()
            .frame(width: 393, height: 852)
            .environment(\.colorScheme, .dark)

        assertSnapshot(of: view, as: .imageHEIC(layout: .device(config: Self.iPhone17ConfigDark), compressionQuality: .maximum))
    }
}
