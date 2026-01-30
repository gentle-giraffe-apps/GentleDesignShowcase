//  Jonathan Ritchey
import SwiftUI

struct MapRouteTemplateView: View {
    var body: some View {
        VStack {
            Spacer()

            Image(systemName: "map")
                .font(.system(size: 60))
                .foregroundStyle(.secondary)

            Text("Map Route")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top)

            Text("Placeholder for map view")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    NavigationStack {
        MapRouteTemplateView()
            .navigationTitle("Map Route")
            .navigationBarTitleDisplayMode(.inline)
    }
}
