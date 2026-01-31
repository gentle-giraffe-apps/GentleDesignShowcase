//  Jonathan Ritchey
import MapKit
import SwiftUI

struct MapRouteTemplateView: View {
    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 40.7829,
                longitude: -73.9654
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.03,
                longitudeDelta: 0.03
            )
        )
    )

    var onMapReady: (() -> Void)?

    var body: some View {
        Map(position: $position) {
            Annotation("Central Park", coordinate: CLLocationCoordinate2D(
                latitude: 40.7829,
                longitude: -73.9654
            )) {
                // Custom annotation view with onAppear
                Image(systemName: "mappin.circle.fill")
                    .font(.title)
                    .foregroundStyle(.red)
                    .onAppear {
                        onMapReady?()
                    }
            }
        }
        .mapStyle(.standard)
    }
}

#Preview {
    NavigationStack {
        MapRouteTemplateView()
            .navigationTitle("Map Route")
            .navigationBarTitleDisplayMode(.inline)
    }
}
