//  Jonathan Ritchey
import GentleDesignSystem
import SwiftUI

struct OnboardingPagerTemplateView: View {
    enum Page: Int, CaseIterable, Hashable, Identifiable {
        case welcome, track, ready
        var id: Int { rawValue }
    }

    struct Item: Identifiable {
        let id: Page
        let image: String
        let title: String
        let description: String
    }

    private let items: [Item] = [
        .init( id: .welcome, image: "OnboardWelcome",
            title: "Welcome! 👋",
            description: "We’re so glad you’re here. Let’s get you settled and ready to explore—one friendly step at a time."
        ),
        .init(id: .track, image: "OnboardTrack",
              title: "Track progress",
              description: "See how you're doing over time. Small steps add up, and we'll help you keep track."),
        .init(id: .ready, image: "OnboardReady",
              title: "Ready to go",
              description: "All set! Start exploring and take things one step at a time.")
    ]

    @State private var page: Page? = .welcome
    @GentleDesignRuntime var design

    // MARK: - Layout constants
    private let cardCornerRadius: CGFloat = 40
    private let cardHeightFraction: CGFloat = 0.50 // 0.40

    // MARK: - Page colors
    private var backgroundColors: [Color] {
        switch page {
        case .welcome:
            return [Color.orange.opacity(0.9), Color.orange.opacity(0.5)]
        case .track:
            return [Color.blue.opacity(0.8), Color.blue.opacity(0.4)]
        case .ready:
            return [Color.green.opacity(0.8), Color.green.opacity(0.4)]
        case .none:
            return [Color.orange.opacity(0.9), Color.orange.opacity(0.5)]
        }
    }

    private var floorGradientColors: [Color] {
        switch page {
        case .welcome:
            return [Color.yellow.opacity(0.45), Color(red: 1.0, green: 0.97, blue: 0.92)]
        case .track:
            return [Color.green.opacity(0.25), Color(red: 0.94, green: 0.97, blue: 1.0)]
        case .ready:
            return [Color.orange.opacity(0.25), Color(red: 0.94, green: 1.0, blue: 0.96)]
        case .none:
            return [Color.blue.opacity(0.35), Color(red: 1.0, green: 0.97, blue: 0.92)]
        }
    }

    private let floorHeightFraction: CGFloat = 0.12

    var body: some View {
        GeometryReader { geo in
            let skyHeight = geo.size.height * (1 - cardHeightFraction - floorHeightFraction)
            let floorHeight = geo.size.height * floorHeightFraction
            let cardHeight = geo.size.height * cardHeightFraction

            ZStack(alignment: .bottom) {
                // Background: Sky + Floor stacked vertically (no overlap)
                VStack(spacing: 0) {
                    // Sky gradient
                    LinearGradient(
                        colors: backgroundColors,
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: skyHeight)

                    // Floor gradient
                    LinearGradient(
                        colors: floorGradientColors,
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: floorHeight)

                    // Card space
                    VStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 1)
                        Color(UIColor.systemBackground).opacity(0.95)
                    }
                    .frame(height: cardHeight)
                }
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.4), value: page)

                // Pager dots overlay
                VStack {
                    HStack(spacing: 12) {
                        ForEach(Page.allCases) { p in
                            Capsule()
                                .fill(Color.white)
                                .opacity(p == page ? 1 : 0.4)
                                .frame(width: p == page ? 40 : 14, height: 14)
                                .shadow(color: .black.opacity(0.15), radius: 2, y: 1)
                                .animation(.easeInOut(duration: 0.2), value: page)
                        }
                    }
                    .padding(.top, geo.safeAreaInsets.top + 100)
                    Spacer()
                }

                // Pager content (images)
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 0) {
                            ForEach(items) { item in
                                Image(item.image)
                                    .resizable()
                                    .scaledToFit()
                                    .containerRelativeFrame(.horizontal)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.paging)
                    .scrollPosition(id: $page)
                    .frame(height: geo.size.height * 0.45)
                    .padding(.top, geo.safeAreaInsets.top + 100)

                    Spacer()
                }

                // Bottom card
                VStack(spacing: 2) {
                    Color.clear.frame(height: 32)
                    
                    if let currentItem = items.first(where: { $0.id == page }) {
                            Text(currentItem.title)
                                .gentleText(.title3_ml)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 48)
                        
                            Color.clear.frame(height: 14)
                        
                            Text(currentItem.description)
                                .gentleText(.bodySecondary_m)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 48)
                    }

                    Spacer(minLength: 2)

                    // Circular action button
                    Button {
                        guard let currentPage = page else { return }
                        withAnimation {
                            if currentPage == .ready {
                                // Handle completion - dismiss onboarding
                            } else {
                                page = nextPage(after: currentPage)
                            }
                        }
                    } label: {
                        Image(systemName: page == .ready ? "checkmark" : "arrow.right")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.primary)
                            .frame(width: 56, height: 56)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
                            .contentTransition(.symbolEffect(.replace))
                    }
                }
                .padding(.bottom, 100)
                .frame(maxWidth: .infinity)
                .frame(height: geo.size.height * cardHeightFraction)
            }
        }
        .ignoresSafeArea()
    }

    private func nextPage(after p: Page) -> Page {
        switch p {
        case .welcome: return .track
        case .track: return .ready
        case .ready: return .ready
        }
    }
}

#Preview {
    OnboardingPagerTemplateView()
}
