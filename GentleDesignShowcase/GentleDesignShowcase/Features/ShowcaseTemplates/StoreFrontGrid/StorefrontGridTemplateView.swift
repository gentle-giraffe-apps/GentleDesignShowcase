//  Jonathan Ritchey
import GentleDesignSystem
import SwiftUI

struct StorefrontGridTemplateView: View {
    let items: [StoreItem] = StoreItem.sample

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(items) { item in
                    VStack(alignment: .leading, spacing: 8) {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.gray.opacity(0.25))
                            .frame(height: 120)

                        Text(item.name)
                            .gentleText(.body_m)
                            .lineLimit(1)

                        Text(item.price)
                            .gentleText(.bodySecondary_m)
                    }
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 16).fill(.background))
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(.gray.opacity(0.2)))
                }
            }
            .padding()
        }
        .navigationTitle("Storefront")
    }
}

struct StoreItem: Identifiable {
    let id = UUID()
    let name: String
    let price: String

    static let sample: [StoreItem] = [
        .init(name: "Starter Pack", price: "$9.99"),
        .init(name: "Premium Theme", price: "$4.99"),
        .init(name: "Icon Set", price: "$1.99"),
        .init(name: "Pro Upgrade", price: "$19.99"),
        .init(name: "Widgets", price: "$2.99"),
        .init(name: "Lifetime", price: "$49.99"),
    ]
}
