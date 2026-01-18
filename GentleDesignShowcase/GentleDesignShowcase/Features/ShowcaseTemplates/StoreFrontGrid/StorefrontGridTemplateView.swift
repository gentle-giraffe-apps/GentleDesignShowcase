//  Jonathan Ritchey
import GentleDesignSystem
import SmartAsyncImage
import SwiftUI

struct StorefrontGridTemplateView: View {
    @State private var query: String = ""
    @State private var favorites: Set<UUID> = []
    @State private var selectedCategory: StoreCategory = .all

    private let items: [StoreItem] = StoreItem.sample

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
    ]

    private var filteredItems: [StoreItem] {
        var result = items

        // Filter by category
        if selectedCategory != .all {
            result = result.filter { $0.category == selectedCategory }
        }

        // Filter by search query
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines)
        if !q.isEmpty {
            result = result.filter {
                $0.name.localizedCaseInsensitiveContains(q) ||
                $0.description.localizedCaseInsensitiveContains(q)
            }
        }

        return result
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                searchBar

                categoryChips

                LazyVGrid(columns: columns, spacing: 16) {
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

    // MARK: - Category Chips

    private var categoryChips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(StoreCategory.allCases) { category in
                    categoryChip(for: category)
                }
            }
        }
    }

    private func categoryChip(for category: StoreCategory) -> some View {
        let isSelected = selectedCategory == category

        return Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                selectedCategory = category
            }
        } label: {
            Text(category.rawValue)
                .font(.system(size: 14, weight: isSelected ? .semibold : .medium))
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(isSelected ? Color.primary : Color.clear)
                )
                .overlay(
                    Capsule()
                        .stroke(Color.gray.opacity(isSelected ? 0 : 0.3), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }

    // MARK: - Card

    private func productCard(for item: StoreItem) -> some View {
        Button {
            // Card tap action (could navigate to detail)
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                ZStack(alignment: .topTrailing) {
                    // Image container with soft shadow and dynamic height
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(.background)
                        .overlay {
                            Image(item.assetName)
                                .resizable()
                                .scaledToFit()
                                .padding(12)
                        }
                        .frame(height: item.cardHeight)
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
                        .shadow(color: .black.opacity(0.04), radius: 2, x: 0, y: 1)

                    // Animated heart button
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            toggleFavorite(item)
                        }
                    } label: {
                        Image(systemName: favorites.contains(item.id) ? "heart.fill" : "heart")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(favorites.contains(item.id) ? .red : .primary)
                            .frame(width: 34, height: 34)
                            .background(.ultraThinMaterial, in: Circle())
                            .overlay(Circle().stroke(.black.opacity(0.08)))
                            .shadow(color: .black.opacity(0.12), radius: 6, x: 0, y: 2)
                            .scaleEffect(favorites.contains(item.id) ? 1.1 : 1.0)
                    }
                    .buttonStyle(.plain)
                    .padding(10)
                }

                Text(item.name)
                    .gentleText(.body_m)
                    .lineLimit(1)

                // Star rating row
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 12))
                        .foregroundStyle(.orange)
                    Text(String(format: "%.1f", item.rating))
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(.primary)
                    Text("(\(item.reviewCount))")
                        .font(.system(size: 13))
                        .foregroundStyle(.secondary)
                }

                Text(item.price)
                    .gentleText(.bodySecondary_m)
            }
        }
        .buttonStyle(CardPressStyle())
    }

    private func toggleFavorite(_ item: StoreItem) {
        if favorites.contains(item.id) {
            favorites.remove(item.id)
        } else {
            favorites.insert(item.id)
        }
    }
}

// MARK: - Card Press Style

private struct CardPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}


enum StoreCategory: String, CaseIterable, Identifiable {
    case all = "All"
    case sculptures = "Sculptures"
    case wood = "Wood"
    case crystal = "Crystal"
    case stone = "Stone"
    case animals = "Animals"

    var id: String { rawValue }
}

struct StoreItem: Identifiable {
    let id = UUID()
    let name: String
    let price: String
    let assetName: String
    let description: String
    let rating: Double
    let reviewCount: Int
    let category: StoreCategory
    let cardHeight: CGFloat

    static let sample: [StoreItem] = [

        .init(
            name: "Continuum No. 3",
            price: "$1,450",
            assetName: "StoreFrontAbstractPiece",
            description: "A museum-style abstract sculpture with layered translucent materials and organic motion. Designed as a contemplative centerpiece that invites reflection and interpretation.",
            rating: 4.9,
            reviewCount: 47,
            category: .sculptures,
            cardHeight: 190
        ),

        .init(
            name: "Tall Meadow Alpaca",
            price: "$185",
            assetName: "StoreFrontAlpaca",
            description: "Hand-carved from light pine, this slender alpaca balances charm and refinement. A warm artisan piece that feels playful yet composed.",
            rating: 4.8,
            reviewCount: 156,
            category: .animals,
            cardHeight: 160
        ),

        .init(
            name: "Orbital Calm",
            price: "$460",
            assetName: "StoreFrontSphereStone",
            description: "A smooth, spherical stone sculpture with subtle translucence. Abstract and grounding, designed to anchor a space visually and emotionally.",
            rating: 4.6,
            reviewCount: 44,
            category: .stone,
            cardHeight: 165
        ),

        .init(
            name: "Quiet Whiskers",
            price: "$165",
            assetName: "StoreFrontCat",
            description: "A serene, slender cat carved from rustic pine. Minimal and calming, reflecting the understated elegance of modern Scandinavian craft.",
            rating: 5.0,
            reviewCount: 312,
            category: .wood,
            cardHeight: 155
        ),

        .init(
            name: "Petit Salon Chair",
            price: "$225",
            assetName: "StoreFrontChair",
            description: "An intricately detailed miniature chair inspired by classic salon furniture. Decorative, refined, and sculptural in its own right.",
            rating: 4.6,
            reviewCount: 89,
            category: .wood,
            cardHeight: 170
        ),

        .init(
            name: "Good Listener",
            price: "$175",
            assetName: "StoreFrontDog",
            description: "A smooth pine sculpture capturing the gentle attentiveness of a loyal companion. Designed to evoke warmth, presence, and quiet empathy.",
            rating: 4.9,
            reviewCount: 241,
            category: .animals,
            cardHeight: 165
        ),

        .init(
            name: "Golden Leap",
            price: "$210",
            assetName: "StoreFrontDolphinBeeswax",
            description: "Carved from translucent beeswax, this dolphin captures motion and light together. A luminous object that shifts character as lighting changes.",
            rating: 4.8,
            reviewCount: 67,
            category: .animals,
            cardHeight: 180
        ),

        .init(
            name: "Gentle Giant",
            price: "$395",
            assetName: "StoreFrontElephant",
            description: "A polished blue marble elephant with soft curves and reassuring weight. The cool stone and rounded form give this piece lasting gravitas.",
            rating: 4.9,
            reviewCount: 184,
            category: .stone,
            cardHeight: 175
        ),

        .init(
            name: "Inner Flame",
            price: "$520",
            assetName: "StoreFrontFirestone",
            description: "An abstract crystal form with internal translucency and flowing geometry. Designed as a meditative object that responds beautifully to gallery lighting.",
            rating: 4.7,
            reviewCount: 52,
            category: .crystal,
            cardHeight: 195
        ),

        .init(
            name: "Forest Guardian Frog",
            price: "$260",
            assetName: "StoreFrontFrogMalachite",
            description: "A small frog carved from rich green malachite, showcasing natural banding and depth. Symbolic, playful, and unmistakably precious.",
            rating: 4.8,
            reviewCount: 93,
            category: .stone,
            cardHeight: 150
        ),

        .init(
            name: "Elder Presence",
            price: "$740",
            assetName: "StoreFrontIndian",
            description: "A finely carved hardwood bust honoring wisdom, resilience, and tradition. The layered textures and solemn expression lend quiet authority.",
            rating: 5.0,
            reviewCount: 38,
            category: .wood,
            cardHeight: 185
        ),

        .init(
            name: "Amber Sentinel",
            price: "$680",
            assetName: "StoreFrontLionAmber",
            description: "A lioness carved from translucent amber, glowing warmly from within. A symbol of strength, grace, and watchful calm.",
            rating: 4.9,
            reviewCount: 71,
            category: .crystal,
            cardHeight: 175
        ),

        .init(
            name: "Night Watch Owl",
            price: "$195",
            assetName: "StoreFrontOwl",
            description: "A hand-carved owl rendered in warm-toned wood. Detailed yet gentle, it embodies patience, awareness, and quiet intelligence.",
            rating: 4.7,
            reviewCount: 128,
            category: .wood,
            cardHeight: 160
        ),

        .init(
            name: "The Negotiator",
            price: "$980",
            assetName: "StoreFrontBusinessMan",
            description: "A conceptual figure formed from exotic stones and gem-like materials. Smooth, abstract, and gallery-ready, it explores power, balance, and modern identity.",
            rating: 4.7,
            reviewCount: 23,
            category: .stone,
            cardHeight: 200
        ),

        .init(
            name: "Winterbound Reindeer",
            price: "$240",
            assetName: "StoreFrontReindeer",
            description: "A carved reindeer with flowing antlers and natural wood grain. Seasonal yet timeless, it evokes stillness and northern landscapes.",
            rating: 4.8,
            reviewCount: 205,
            category: .animals,
            cardHeight: 190
        ),

        .init(
            name: "Quiet Growth",
            price: "$310",
            assetName: "StoreFrontTree",
            description: "A stylized wooden tree carved with flowing lines and organic balance. Symbolizing resilience and renewal, it brings calm structure to any room.",
            rating: 4.9,
            reviewCount: 167,
            category: .sculptures,
            cardHeight: 200
        )
    ]
}
