//  Jonathan Ritchey
import GentleDesignSystem
import SwiftUI
import Charts

struct ChartAndStatsTemplateView: View {
    let points: [ChartPoint] = ChartPoint.sample
    let stats: [StatRow] = StatRow.sample

    var body: some View {
        VStack(spacing: 16) {
            Chart(points) { p in
                LineMark(
                    x: .value("Day", p.day),
                    y: .value("Value", p.value)
                )
            }
            .frame(height: 220)
            .padding(.horizontal)

            List(stats) { row in
                HStack {
                    Text(row.title)
                        .gentleText(.body_m)
                    Spacer()
                    Text(row.value)
                        .gentleText(.bodySecondary_m)
                }
            }
        }
        .navigationTitle("Chart + Stats")
    }
}

struct ChartPoint: Identifiable {
    let id = UUID()
    let day: String
    let value: Double

    static let sample: [ChartPoint] = [
        .init(day: "Mon", value: 10),
        .init(day: "Tue", value: 14),
        .init(day: "Wed", value: 12),
        .init(day: "Thu", value: 18),
        .init(day: "Fri", value: 16),
        .init(day: "Sat", value: 22),
        .init(day: "Sun", value: 19),
    ]
}

struct StatRow: Identifiable {
    let id = UUID()
    let title: String
    let value: String

    static let sample: [StatRow] = [
        .init(title: "7-day avg", value: "15.9"),
        .init(title: "Best day", value: "Sat"),
        .init(title: "Change", value: "+12%"),
        .init(title: "Goal", value: "20"),
    ]
}
