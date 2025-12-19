//  Jonathan Ritchey
import GentleDesignSystem
import SwiftUI

struct OnboardingPagerTemplateView: View {
    @State private var page = 0

    var body: some View {
        VStack {
            TabView(selection: $page) {
                OnboardPage(title: "Welcome").tag(0)
                OnboardPage(title: "Track progress").tag(1)
                OnboardPage(title: "Ready to go").tag(2)
            }
            .tabViewStyle(.page)

            Button(page == 2 ? "Get Started" : "Continue") {
                page = min(page + 1, 2)
            }
            .gentleButton(.primary)
            .padding()
        }
        .navigationTitle("Onboarding")
    }
}

private struct OnboardPage: View {
    let title: String
    var body: some View {
        VStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 24)
                .fill(.gray.opacity(0.25))
                .frame(height: 260)
                .padding(.horizontal)

            Text(title)
                .gentleText(.title2_l)
            Text("Placeholder description.")
                .gentleText(.bodySecondary_m)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding(.top, 24)
    }
}
