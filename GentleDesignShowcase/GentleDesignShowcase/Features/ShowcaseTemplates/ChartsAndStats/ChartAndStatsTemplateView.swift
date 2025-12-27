//  Jonathan Ritchey
import GentleDesignSystem
import SwiftUI
import Charts

struct ChartAndStatsTemplateView: View {
    @GentleDesignRuntime private var design
    
    // Donut data (like your screenshot)
    private let categories: [CalorieCategory] = [
        .init(name: "Salads",     percent: 29),
        .init(name: "Sandwiches", percent: 26),
        .init(name: "Ribs",       percent: 25),
        .init(name: "Soups",      percent: 19)
    ]

    let colorForCategory: KeyValuePairs<String, Color> = [
        "Salads":     Color.green.opacity(0.65),
        "Sandwiches": Color.green.opacity(0.45),
        "Ribs":       Color.green.opacity(0.28),
        "Soups":      Color.green.opacity(0.12)
    ]

    // Stacked bar data
    private let days: [NutritionDay] = [
        .init(dayIndex: 1, kcalCarbs: 700, kcalProtein: 500, kcalFat: 450),
        .init(dayIndex: 2, kcalCarbs: 900, kcalProtein: 520, kcalFat: 420),
        .init(dayIndex: 3, kcalCarbs: 520, kcalProtein: 430, kcalFat: 360),
        .init(dayIndex: 4, kcalCarbs: 780, kcalProtein: 480, kcalFat: 520),
        .init(dayIndex: 5, kcalCarbs: 880, kcalProtein: 640, kcalFat: 560),
        .init(dayIndex: 6, kcalCarbs: 1050, kcalProtein: 720, kcalFat: 740),
        .init(dayIndex: 7, kcalCarbs: 600, kcalProtein: 520, kcalFat: 480),
    ]

    private var macroRows: [MacroKcalRow] {
        days.flatMap { d in
            [
                .init(dayIndex: d.dayIndex, macro: .carbs,   kcal: d.kcalCarbs),
                .init(dayIndex: d.dayIndex, macro: .protein, kcal: d.kcalProtein),
                .init(dayIndex: d.dayIndex, macro: .fat,     kcal: d.kcalFat),
            ]
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 18) {

                // ===== Card 1: Donut + right-side legend =====
                card(title: "Calorie Intake") {
                    HStack(spacing: design.layout.stack.regular) {

                        // Donut
                        Chart(categories) { item in
                            SectorMark(
                                angle: .value("Percent", item.percent),
                                innerRadius: .ratio(0.80),     // donut hole // was 0.7
                                angularInset: 1.0              // little gaps between slices
                            )
                            .cornerRadius(6)
                            .foregroundStyle(by: .value("Category", item.name))
                        }
                        .chartForegroundStyleScale(colorForCategory)
                        .chartLegend(.hidden) // we’re building our own legend on the right
                        .frame(width: 120, height: 120)

                        Spacer(minLength: 0)

                        // Right-side legend with percent labels
                        VStack(spacing: 16) {
                            ForEach(categories) { item in
                                HStack(spacing: 2) {
                                    Circle()
                                        .fill(colorForCategory.color(for: item.name) ?? .clear)
                                        .frame(width: 14, height: 14)
                                        .gentleInset(.horizontal, .control)

                                    Text(item.name)
                                        .gentleText(.callout_ms)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.7)

                                    Spacer()

                                    Text("\(Int(item.percent))%")
                                        .gentleText(.bodySecondary_m)
                                }
                            }
                        }
                        .frame(maxWidth: 260)
                    }
                }

                // ===== Card 2: Stacked bars + bottom legend =====
                card(title: "Nutrition Intake") {
                    VStack(spacing: design.layout.stack.loose) {

                        HStack {
                            // Match the screenshot-style left labels
                            VStack(alignment: .leading, spacing: 54) {
                                Text("3216 cal")
                                Text("1608 cal")
                            }
                            .gentleText(.bodySecondary_m)

                            Spacer()

                            Chart(macroRows) { row in
                                BarMark(
                                    x: .value("Day", row.dayIndex),
                                    y: .value("cal", row.kcal)
                                )
                                .foregroundStyle(by: .value("Macro", row.macro.rawValue))
                                .position(by: .value("Macro", row.macro.rawValue), axis: .vertical) // stacks
                                .cornerRadius(3)
                            }
                            .chartLegend(.hidden)
                            .chartXAxis(.hidden)
                            .chartYAxis(.hidden)
                            .frame(width: 220, height: 170)

                            Spacer()
                        }

                        // Bottom legend (custom to match tight layout)
                        HStack(spacing: 42) {
                            macroLegendItem(.carbs)
                            macroLegendItem(.protein)
                            macroLegendItem(.fat)
                        }
                    }
                }
            }
            .padding(16)
        }
        .navigationTitle("Charts")
    }

    // MARK: - UI helpers

    private func card<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(spacing: design.layout.stack.regular) {
            Text(title)
                .gentleText(.title_xl)
                .padding(.top, 8)

            Divider()
                .opacity(0.35)

            content()
                .padding(.vertical, 6)
        }
        .gentleInset(.card)
    }

    private func macroLegendItem(_ macro: Macro) -> some View {
        HStack(spacing: 10) {
            Circle()
                .fill(colorForMacro(macro))
                .frame(width: 14, height: 14)
            Text(macro.rawValue)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Colors
    // (Swift Charts can auto-assign colors, but for “like the screenshot” you usually want explicit mapping.)

    private func colorForMacro(_ macro: Macro) -> Color {
        switch macro {
        case .carbs:   return Color.orange.opacity(0.45)
        case .protein: return Color.orange.opacity(0.18)
        case .fat:     return Color.orange.opacity(0.80)
        }
    }
}

#Preview {
    ChartAndStatsTemplateView()
}

extension KeyValuePairs where Key == String, Value == Color {
    func color(for key: String) -> Color? {
        first(where: { $0.key == key })?.value
    }
}
struct CalorieCategory: Identifiable {
    let id = UUID()
    let name: String
    let percent: Double
}

enum Macro: String, CaseIterable, Identifiable {
    case carbs = "Carbs"
    case protein = "Protein"
    case fat = "Fat"
    var id: String { rawValue }
}

struct NutritionDay: Identifiable {
    let id = UUID()
    let dayIndex: Int
    let kcalCarbs: Double
    let kcalProtein: Double
    let kcalFat: Double
}

// Flat rows are easiest for stacked marks
struct MacroKcalRow: Identifiable {
    let id = UUID()
    let dayIndex: Int
    let macro: Macro
    let kcal: Double
}

