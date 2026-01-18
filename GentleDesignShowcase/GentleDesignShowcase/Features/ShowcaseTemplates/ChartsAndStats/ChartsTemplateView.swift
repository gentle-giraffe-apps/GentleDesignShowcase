//  Jonathan Ritchey
import GentleDesignSystem
import SwiftUI
import Charts

struct ChartsTemplateView: View {
    @GentleDesignRuntime private var design

    // MARK: - Data

    private let categories: [CalorieCategory] = [
        .init(name: "Salads",     percent: 29),
        .init(name: "Sandwiches", percent: 26),
        .init(name: "Ribs",       percent: 25),
        .init(name: "Soups",      percent: 19)
    ]

    private let colorForCategory: KeyValuePairs<String, Color> = [
        "Salads":     Color.green.opacity(0.7),
        "Sandwiches": Color.orange.opacity(0.7),
        "Ribs":       Color.red.opacity(0.7),
        "Soups":      Color.blue.opacity(0.7)
    ]

    private let days: [NutritionDay] = [
        .init(dayIndex: 1, kcalCarbs: 700, kcalProtein: 500, kcalFat: 450),
        .init(dayIndex: 2, kcalCarbs: 900, kcalProtein: 520, kcalFat: 420),
        .init(dayIndex: 3, kcalCarbs: 520, kcalProtein: 430, kcalFat: 360),
        .init(dayIndex: 4, kcalCarbs: 780, kcalProtein: 480, kcalFat: 520),
        .init(dayIndex: 5, kcalCarbs: 880, kcalProtein: 640, kcalFat: 560),
        .init(dayIndex: 6, kcalCarbs: 1050, kcalProtein: 720, kcalFat: 740),
        .init(dayIndex: 7, kcalCarbs: 600, kcalProtein: 520, kcalFat: 480),
    ]

    private let weeklyTrend: [TrendPoint] = [
        .init(week: "Week 1", calories: 12400),
        .init(week: "Week 2", calories: 13200),
        .init(week: "Week 3", calories: 11800),
        .init(week: "Week 4", calories: 14100),
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

    private var totalDailyAverage: Int {
        let total = days.reduce(0) { $0 + $1.kcalCarbs + $1.kcalProtein + $1.kcalFat }
        return Int(total / Double(days.count))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {

                // MARK: - Donut Chart Card
                card(title: "Calorie Breakdown") {
                    HStack(spacing: design.layout.stack.loose) {

                        // Donut with center label
                        ZStack {
                            Chart(categories) { item in
                                SectorMark(
                                    angle: .value("Percent", item.percent),
                                    innerRadius: .ratio(0.72),
                                    angularInset: 1.5
                                )
                                .cornerRadius(4)
                                .foregroundStyle(by: .value("Category", item.name))
                            }
                            .chartForegroundStyleScale(colorForCategory)
                            .chartLegend(.hidden)
                            .frame(width: 120, height: 120)

                            // Center label
                            VStack(spacing: 1) {
                                Text("\(totalDailyAverage)")
                                    .gentleText(.title3_ml)
                                    .monospacedDigit()
                                Text("cal/day")
                                    .gentleText(.footnote_s)
                            }
                        }

                        Spacer(minLength: 0)

                        // Legend
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(categories) { item in
                                HStack(spacing: 8) {
                                    RoundedRectangle(cornerRadius: 3)
                                        .fill(colorForCategory.color(for: item.name) ?? .clear)
                                        .frame(width: 14, height: 14)

                                    Text(item.name)
                                        .gentleText(.callout_ms)
                                        .lineLimit(1)

                                    Spacer()

                                    Text("\(Int(item.percent))%")
                                        .gentleText(.footnote_s)
                                        .monospacedDigit()
                                }
                            }
                        }
                        .frame(maxWidth: 160)
                    }
                }

                // MARK: - Weekly Trend Card
                card(title: "Monthly Trend") {
                    Chart(weeklyTrend) { point in
                        LineMark(
                            x: .value("Week", point.week),
                            y: .value("Calories", point.calories)
                        )
                        .interpolationMethod(.catmullRom)
                        .foregroundStyle(Color.blue.opacity(0.8))
                        .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .round))

                        AreaMark(
                            x: .value("Week", point.week),
                            yStart: .value("Baseline", 10000),
                            yEnd: .value("Calories", point.calories)
                        )
                        .interpolationMethod(.catmullRom)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.blue.opacity(0.3), Color.blue.opacity(0.05)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )

                        PointMark(
                            x: .value("Week", point.week),
                            y: .value("Calories", point.calories)
                        )
                        .foregroundStyle(Color.blue)
                        .symbolSize(50)
                    }
                    .chartYScale(domain: 10000...16000)
                    .chartXAxis {
                        AxisMarks { value in
                            AxisValueLabel()
                                .font(.system(.caption, weight: .semibold))
                                .foregroundStyle(design.color(.textPrimary))
                        }
                    }
                    .chartYAxis {
                        AxisMarks(position: .leading) { value in
                            AxisGridLine()
                                .foregroundStyle(design.color(.textPrimary).opacity(0.2))
                            AxisValueLabel()
                                .font(.system(.caption, weight: .semibold))
                                .foregroundStyle(design.color(.textPrimary))
                        }
                    }
                    .frame(height: 112)
                    .clipped()
                }

                // MARK: - Stacked Bar Card
                card(title: "Daily Nutrition") {
                    VStack(spacing: design.layout.stack.tight) {

                        Chart(macroRows) { row in
                            BarMark(
                                x: .value("Day", row.dayLabel),
                                y: .value("cal", row.kcal)
                            )
                            .foregroundStyle(by: .value("Macro", row.macro.rawValue))
                            .cornerRadius(4)
                        }
                        .chartForegroundStyleScale([
                            Macro.carbs.rawValue: Color.yellow.opacity(0.75),
                            Macro.protein.rawValue: Color.blue.opacity(0.7),
                            Macro.fat.rawValue: Color.green.opacity(0.65)
                        ])
                        .chartLegend(.hidden)
                        .chartXAxis {
                            AxisMarks { value in
                                AxisValueLabel()
                                    .font(.system(.caption, weight: .semibold))
                                    .foregroundStyle(design.color(.textPrimary))
                            }
                        }
                        .chartYAxis {
                            AxisMarks(position: .leading) { value in
                                AxisGridLine()
                                    .foregroundStyle(design.color(.textPrimary).opacity(0.2))
                                AxisValueLabel()
                                    .font(.system(.caption, weight: .semibold))
                                    .foregroundStyle(design.color(.textPrimary))
                            }
                        }
                        .frame(height: 128)

                        // Legend
                        HStack(spacing: design.layout.stack.regular) {
                            ForEach(Macro.allCases) { macro in
                                macroLegendItem(macro)
                            }
                        }
                    }
                }
            }
            .padding(design.layout.stack.regular)
        }
        .navigationTitle("Analytics")
    }

    // MARK: - Components

    private func card<Content: View>(
        title: String,
        subtitle: String? = nil,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: design.layout.stack.tight) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .gentleText(.title3_ml)

                if let subtitle {
                    Text(subtitle)
                        .gentleText(.footnote_s)
                }
            }

            Divider()
                .opacity(0.25)

            content()
        }
        .gentleInset(.card)
    }

    private func macroLegendItem(_ macro: Macro) -> some View {
        HStack(spacing: 6) {
            RoundedRectangle(cornerRadius: 3)
                .fill(colorForMacro(macro))
                .frame(width: 12, height: 12)
            Text(macro.rawValue)
                .gentleText(.footnote_s)
        }
    }

    // MARK: - Colors

    private func colorForMacro(_ macro: Macro) -> Color {
        switch macro {
        case .carbs:   return Color.yellow.opacity(0.75)
        case .protein: return Color.blue.opacity(0.7)
        case .fat:     return Color.green.opacity(0.65)
        }
    }
}

#Preview {
    NavigationStack {
        ChartsTemplateView()
    }
}

// MARK: - Models

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

struct MacroKcalRow: Identifiable {
    let id = UUID()
    let dayIndex: Int
    let macro: Macro
    let kcal: Double

    var dayLabel: String {
        ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][dayIndex - 1]
    }
}

struct TrendPoint: Identifiable {
    let id = UUID()
    let week: String
    let calories: Double
}
