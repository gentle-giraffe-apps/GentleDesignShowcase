//  Jonathan Ritchey
import GentleDesignSystem
import SwiftUI
import Charts

struct ChartAndStatsTemplateView: View {
    @GentleDesignRuntime private var design

    // MARK: - Data

    private let categories: [CalorieCategory] = [
        .init(name: "Salads",     percent: 29),
        .init(name: "Sandwiches", percent: 26),
        .init(name: "Ribs",       percent: 25),
        .init(name: "Soups",      percent: 19)
    ]

    private let colorForCategory: KeyValuePairs<String, Color> = [
        "Salads":     Color.green.opacity(0.65),
        "Sandwiches": Color.green.opacity(0.45),
        "Ribs":       Color.green.opacity(0.28),
        "Soups":      Color.green.opacity(0.12)
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
        .init(week: "W1", calories: 12400),
        .init(week: "W2", calories: 13200),
        .init(week: "W3", calories: 11800),
        .init(week: "W4", calories: 14100),
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

    private var totalWeeklyCalories: Int {
        Int(days.reduce(0) { $0 + $1.kcalCarbs + $1.kcalProtein + $1.kcalFat })
    }

    var body: some View {
        ScrollView {
            VStack(spacing: design.layout.stack.loose) {

                // MARK: - Hero Stats
                HStack(spacing: design.layout.stack.regular) {
                    statCard(
                        value: "\(totalWeeklyCalories.formatted())",
                        label: "Weekly Total",
                        trend: "+12%",
                        trendUp: true
                    )

                    statCard(
                        value: "\(totalDailyAverage.formatted())",
                        label: "Daily Average",
                        trend: "-3%",
                        trendUp: false
                    )
                }

                // MARK: - Donut Chart Card
                card(title: "Calorie Breakdown", subtitle: "By food category") {
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
                            .frame(width: 140, height: 140)

                            // Center label
                            VStack(spacing: 2) {
                                Text("100%")
                                    .gentleText(.title_xl)
                                Text("Total")
                                    .gentleText(.bodySecondary_m)
                            }
                        }

                        Spacer(minLength: 0)

                        // Legend
                        VStack(alignment: .leading, spacing: 14) {
                            ForEach(categories) { item in
                                HStack(spacing: 10) {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(colorForCategory.color(for: item.name) ?? .clear)
                                        .frame(width: 16, height: 16)

                                    Text(item.name)
                                        .gentleText(.callout_ms)
                                        .lineLimit(1)

                                    Spacer()

                                    Text("\(Int(item.percent))%")
                                        .gentleText(.bodySecondary_m)
                                        .monospacedDigit()
                                }
                            }
                        }
                        .frame(maxWidth: 180)
                    }
                }

                // MARK: - Weekly Trend Card
                card(title: "Monthly Trend", subtitle: "Last 4 weeks") {
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
                            y: .value("Calories", point.calories)
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
                                .foregroundStyle(.secondary)
                        }
                    }
                    .chartYAxis {
                        AxisMarks(position: .leading) { value in
                            AxisGridLine()
                                .foregroundStyle(Color.gray.opacity(0.2))
                            AxisValueLabel()
                                .foregroundStyle(.secondary)
                        }
                    }
                    .frame(height: 160)
                    .clipped()
                }

                // MARK: - Stacked Bar Card
                card(title: "Daily Nutrition", subtitle: "This week's macros") {
                    VStack(spacing: design.layout.stack.regular) {

                        Chart(macroRows) { row in
                            BarMark(
                                x: .value("Day", row.dayLabel),
                                y: .value("cal", row.kcal)
                            )
                            .foregroundStyle(by: .value("Macro", row.macro.rawValue))
                            .cornerRadius(4)
                        }
                        .chartForegroundStyleScale([
                            Macro.carbs.rawValue: Color.orange.opacity(0.8),
                            Macro.protein.rawValue: Color.orange.opacity(0.5),
                            Macro.fat.rawValue: Color.orange.opacity(0.25)
                        ])
                        .chartLegend(.hidden)
                        .chartXAxis {
                            AxisMarks { value in
                                AxisValueLabel()
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .chartYAxis {
                            AxisMarks(position: .leading) { value in
                                AxisGridLine()
                                    .foregroundStyle(Color.gray.opacity(0.2))
                                AxisValueLabel()
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .frame(height: 180)

                        // Legend
                        HStack(spacing: design.layout.stack.loose) {
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

    private func statCard(value: String, label: String, trend: String, trendUp: Bool) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .firstTextBaseline, spacing: 6) {
                Text(value)
                    .gentleText(.title_xl)
                    .monospacedDigit()

                Text("cal")
                    .gentleText(.bodySecondary_m)
            }

            HStack(spacing: 4) {
                Text(label)
                    .gentleText(.bodySecondary_m)

                Spacer()

                HStack(spacing: 2) {
                    Image(systemName: trendUp ? "arrow.up.right" : "arrow.down.right")
                        .font(.system(size: 10, weight: .bold))
                    Text(trend)
                        .gentleText(.callout_ms)
                }
                .foregroundStyle(trendUp ? .green : .orange)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .gentleInset(.card)
    }

    private func card<Content: View>(
        title: String,
        subtitle: String? = nil,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: design.layout.stack.regular) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .gentleText(.title_xl)

                if let subtitle {
                    Text(subtitle)
                        .gentleText(.bodySecondary_m)
                }
            }
            .padding(.top, 4)

            Divider()
                .opacity(0.25)

            content()
                .padding(.vertical, 4)
        }
        .gentleInset(.card)
    }

    private func macroLegendItem(_ macro: Macro) -> some View {
        HStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 4)
                .fill(colorForMacro(macro))
                .frame(width: 16, height: 16)
            Text(macro.rawValue)
                .gentleText(.callout_ms)
        }
    }

    // MARK: - Colors

    private func colorForMacro(_ macro: Macro) -> Color {
        switch macro {
        case .carbs:   return Color.orange.opacity(0.8)
        case .protein: return Color.orange.opacity(0.5)
        case .fat:     return Color.orange.opacity(0.25)
        }
    }
}

#Preview {
    NavigationStack {
        ChartAndStatsTemplateView()
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
