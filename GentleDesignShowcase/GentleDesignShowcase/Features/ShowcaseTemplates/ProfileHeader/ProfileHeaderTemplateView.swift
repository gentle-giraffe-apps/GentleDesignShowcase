//  Jonathan Ritchey
import GentleDesignSystem
import Observation
import SmartAsyncImage
import SwiftUI

@Observable
class ProfileHeaderTemplateViewModel {
    struct ProfileStat: Identifiable {
        let id = UUID()
        let label: String
        let value: String
    }

    let name: String
    let subtitle: String
    let avatarURL: String
    let stats: [ProfileStat]
    
    init(name: String, subtitle: String, avatarURL: String, stats: [ProfileStat]) {
        self.name = name
        self.subtitle = subtitle
        self.avatarURL = avatarURL
        self.stats = stats
    }
    
    static let sample = ProfileHeaderTemplateViewModel(
        name: "Taylor Example",
        subtitle: "iOS • SwiftUI • Charts",
        avatarURL: "https://picsum.photos/200",
        stats: [
            .init(label: "Followers", value: "1,284"),
            .init(label: "Following", value: "312"),
            .init(label: "Posts", value: "48"),
            .init(label: "Streak", value: "16 days"),
        ]
    )
}

struct ProfileHeaderTemplateView: View {
    let isLoaded = true
    let viewModel = ProfileHeaderTemplateViewModel.sample
    
    var body: some View {
        VStack(spacing: 16) {
            avatarImage()

            Text(viewModel.name)
                .gentleText(.title2_l)
            Text(viewModel.subtitle)
                .gentleText(.bodySecondary_m)
            
            List(viewModel.stats) { stat in
                HStack {
                    Text(stat.label)
                        .gentleText(.body_m)
                    Spacer()
                    Text(stat.value)
                        .gentleText(.bodySecondary_m)
                }
            }
        }
        .navigationTitle("Profile")
    }
    
    func avatarImage() -> some View {
        return SmartAsyncImage(url: URL(string: viewModel.avatarURL)) { phase in
            switch phase {
            case .success(let image):
                image.resizable().scaledToFill()
            default:
                Circle().fill(.gray.opacity(0.25))
            }
        }
        .frame(width: 96, height: 96)
        .clipShape(Circle())
    }
}
