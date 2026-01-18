//  Jonathan Ritchey
import GentleDesignSystem
import SwiftUI

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
        .init(id: .welcome, image: "OnboardingPageWelcome",
              title: "Welcome",
              description: "We’re happy you’re here. Let’s get everything ready so you can start with confidence."),
        .init(id: .track, image: "OnboardingPageTrack",
              title: "Track progress",
              description: "See how you’re doing over time. Small steps add up, and we’ll help you keep track."),
        .init(id: .ready, image: "OnboardingPageReady",
              title: "Ready to go",
              description: "All set! Start exploring and take things one step at a time.")
    ]

    @State private var page: Page? = .welcome
    @GentleDesignRuntime var design

    var body: some View {
        VStack {
            
            Spacer(minLength: 120)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(items) { item in
                        OnboardPage(
                            imageAssetName: item.image,
                            title: item.title,
                            description: item.description
                        )
                        .containerRelativeFrame(.horizontal)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
            .scrollPosition(id: $page)
            .frame(height: 500)

            Color.clear.frame(height: design.layout.stack.regular)

            HStack(spacing: 8) {
                ForEach(Page.allCases) { p in
                    Circle()
                        .fill(design.color(.themePrimary).opacity(p == page ? 1 : 0.3))
                        .frame(width: 8, height: 8)
                }
            }

            Color.clear.frame(height: design.layout.stack.regular)

            Button(page == .ready ? "Get Started" : "Continue") {
                guard let currentPage = page else { return }
                withAnimation {
                    page = nextPage(after: currentPage)
                }
            }
            .gentleButton(.primary)
            .padding(.horizontal)

            Color.clear.frame(height: 180)
        }
        .navigationTitle("Onboarding")
    }

    private func nextPage(after p: Page) -> Page {
        switch p {
        case .welcome: return .track
        case .track: return .ready
        case .ready: return .ready
        }
    }
}

private struct OnboardPage: View {
    @GentleDesignRuntime var design
    
    let imageAssetName: String
    let title: String
    let description: String
    var body: some View {
        VStack(spacing: 16) {
            Image(imageAssetName)
                .resizable()
                .scaledToFit()
                .frame(height: 260)
                .padding(.horizontal)
            Text(title)
                .gentleText(.title2_l)
            Text(description)
                .gentleText(.bodySecondary_m)
                .multilineTextAlignment(.center)
                .padding(.horizontal, design.layout.stack.expansive * 2)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .gentleInset(.screen)
    }
}
