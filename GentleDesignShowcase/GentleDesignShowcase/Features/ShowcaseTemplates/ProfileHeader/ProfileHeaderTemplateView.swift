//  Jonathan Ritchey
import GentleDesignSystem
import SwiftUI

struct ProfileHeaderTemplateView: View {
    let profile = Profile.sample

    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: URL(string: profile.avatarURL)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFill()
                default:
                    Circle().fill(.gray.opacity(0.25))
                }
            }
            .frame(width: 96, height: 96)
            .clipShape(Circle())

            Text(profile.name)
                .gentleText(.title2_l)
            Text(profile.subtitle)
                .gentleText(.bodySecondary_m)
            
            List(profile.stats) { stat in
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
}

struct Profile {
    let name: String
    let subtitle: String
    let avatarURL: String
    let stats: [ProfileStat]

    static let sample = Profile(
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

struct ProfileStat: Identifiable {
    let id = UUID()
    let label: String
    let value: String
}
