//  Jonathan Ritchey
import GentleDesignSystem
import SwiftUI

struct OnboardingPagerTemplateView: View {
    @State private var page = 0
    @GentleDesignRuntime var design
        
    var body: some View {
        VStack {
            TabView(selection: $page) {
                OnboardPage(
                    imageAssetName: "OnboardingPage1",
                    title: "Welcome",
                    description: "We’re happy you’re here. Let’s get everything ready so you can start with confidence."
                )
                .tag(0)

                OnboardPage(
                    imageAssetName: "OnboardingPage2",
                    title: "Track progress",
                    description: "See how you’re doing over time. Small steps add up, and we’ll help you keep track."
                )
                .tag(1)

                OnboardPage(
                    imageAssetName: "OnboardingPage3",
                    title: "Ready to go",
                    description: "All set! Start exploring and take things one step at a time."
                )
                .tag(2)
            }
            .tabViewStyle(.page)
            .frame(height: 480)

            Spacer(minLength: 16)

            Button(page == 2 ? "Get Started" : "Continue") {
                page = min(page + 1, 2)
            }
            .gentleButton(.primary)
            .padding(.horizontal)

            Spacer(minLength: 24)
        }
        .navigationTitle("Onboarding")
        .onAppear {
            UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(design.color(.themePrimary))
            UIPageControl.appearance().pageIndicatorTintColor = UIColor(design.color(.themePrimary).opacity(0.3))
        }
    }
}

private struct OnboardPage: View {
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
                .padding(.horizontal)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}
