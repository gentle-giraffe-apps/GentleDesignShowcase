//  Jonathan Ritchey
import GentleDesignSystem
import SmartAsyncImage
import SwiftUI

struct StorefrontGridTemplateView: View {
    @State private var query: String = ""
    @State private var favorites: Set<UUID> = []

    private let items: [StoreItem] = StoreItem.sample

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]

    private var filteredItems: [StoreItem] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !q.isEmpty else { return items }

        return items.filter {
            $0.name.localizedCaseInsensitiveContains(q) ||
            $0.description.localizedCaseInsensitiveContains(q)
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                searchBar

                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(filteredItems) { item in
                        productCard(for: item)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Storefront")
    }

    // MARK: - Search

    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            TextField("Search products", text: $query)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .submitLabel(.search)

            if !query.isEmpty {
                Button {
                    query = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(.background)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(.gray.opacity(0.18))
        )
    }

    // MARK: - Card

    private func productCard(for item: StoreItem) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                // Image container (Etsy-like rounded card)
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(.background)
                    .overlay {
                        Image(item.assetName)
                            .resizable()
                            .scaledToFit()
                            .padding(12) // keeps “floating object” feel for transparent PNGs
                    }
                    .frame(height: 170)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(.gray.opacity(0.12))
                    )

                // Heart button in circular pill
                Button {
                    toggleFavorite(item)
                } label: {
                    Image(systemName: favorites.contains(item.id) ? "heart.fill" : "heart")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(favorites.contains(item.id) ? .red : .primary)
                        .frame(width: 34, height: 34)
                        .background(.ultraThinMaterial, in: Circle())
                        .overlay(Circle().stroke(.black.opacity(0.08)))
                        .shadow(color: .black.opacity(0.12), radius: 6, x: 0, y: 2)
                }
                .buttonStyle(.plain)
                .padding(10)
            }

            Text(item.name)
                .gentleText(.body_m)
                .lineLimit(1)

            Text(item.price)
                .gentleText(.bodySecondary_m)

        }
        // Etsy cards are “flat” — no big outer container.
        // Keep it clean: image is the card; text sits underneath.
    }

    private func toggleFavorite(_ item: StoreItem) {
        if favorites.contains(item.id) {
            favorites.remove(item.id)
        } else {
            favorites.insert(item.id)
        }
    }
}


struct StoreItem: Identifiable {
    let id = UUID()
    let name: String
    let price: String
    let assetName: String
    let description: String

    static let sample: [StoreItem] = [

        .init(
            name: "Continuum No. 3",
            price: "$1,450",
            assetName: "StoreFrontAbstractPiece",
            description: "A museum-style abstract sculpture with layered translucent materials and organic motion. Designed as a contemplative centerpiece that invites reflection and interpretation."
        ),

        .init(
            name: "Tall Meadow Alpaca",
            price: "$185",
            assetName: "StoreFrontAlpaca",
            description: "Hand-carved from light pine, this slender alpaca balances charm and refinement. A warm artisan piece that feels playful yet composed."
        ),

        .init(
            name: "The Negotiator",
            price: "$980",
            assetName: "StoreFrontBusinessMan",
            description: "A conceptual figure formed from exotic stones and gem-like materials. Smooth, abstract, and gallery-ready, it explores power, balance, and modern identity."
        ),

        .init(
            name: "Quiet Whiskers",
            price: "$165",
            assetName: "StoreFrontCat",
            description: "A serene, slender cat carved from rustic pine. Minimal and calming, reflecting the understated elegance of modern Scandinavian craft."
        ),

        .init(
            name: "Petit Salon Chair",
            price: "$225",
            assetName: "StoreFrontChair",
            description: "An intricately detailed miniature chair inspired by classic salon furniture. Decorative, refined, and sculptural in its own right."
        ),

        .init(
            name: "Good Listener",
            price: "$175",
            assetName: "StoreFrontDog",
            description: "A smooth pine sculpture capturing the gentle attentiveness of a loyal companion. Designed to evoke warmth, presence, and quiet empathy."
        ),

        .init(
            name: "Golden Leap",
            price: "$210",
            assetName: "StoreFrontDolphinBeeswax",
            description: "Carved from translucent beeswax, this dolphin captures motion and light together. A luminous object that shifts character as lighting changes."
        ),

        .init(
            name: "Gentle Giant",
            price: "$395",
            assetName: "StoreFrontElephant",
            description: "A polished blue marble elephant with soft curves and reassuring weight. The cool stone and rounded form give this piece lasting gravitas."
        ),

        .init(
            name: "Inner Flame",
            price: "$520",
            assetName: "StoreFrontFirestone",
            description: "An abstract crystal form with internal translucency and flowing geometry. Designed as a meditative object that responds beautifully to gallery lighting."
        ),

        .init(
            name: "Forest Guardian Frog",
            price: "$260",
            assetName: "StoreFrontFrogMalachite",
            description: "A small frog carved from rich green malachite, showcasing natural banding and depth. Symbolic, playful, and unmistakably precious."
        ),

        .init(
            name: "Elder Presence",
            price: "$740",
            assetName: "StoreFrontIndian",
            description: "A finely carved hardwood bust honoring wisdom, resilience, and tradition. The layered textures and solemn expression lend quiet authority."
        ),

        .init(
            name: "Amber Sentinel",
            price: "$680",
            assetName: "StoreFrontLionAmber",
            description: "A lioness carved from translucent amber, glowing warmly from within. A symbol of strength, grace, and watchful calm."
        ),

        .init(
            name: "Night Watch Owl",
            price: "$195",
            assetName: "StoreFrontOwl",
            description: "A hand-carved owl rendered in warm-toned wood. Detailed yet gentle, it embodies patience, awareness, and quiet intelligence."
        ),

        .init(
            name: "Winterbound Reindeer",
            price: "$240",
            assetName: "StoreFrontReindeer",
            description: "A carved reindeer with flowing antlers and natural wood grain. Seasonal yet timeless, it evokes stillness and northern landscapes."
        ),

        .init(
            name: "Orbital Calm",
            price: "$460",
            assetName: "StoreFrontSphereStone",
            description: "A smooth, spherical stone sculpture with subtle translucence. Abstract and grounding, designed to anchor a space visually and emotionally."
        ),

        .init(
            name: "Quiet Growth",
            price: "$310",
            assetName: "StoreFrontTree",
            description: "A stylized wooden tree carved with flowing lines and organic balance. Symbolizing resilience and renewal, it brings calm structure to any room."
        )
    ]
}
