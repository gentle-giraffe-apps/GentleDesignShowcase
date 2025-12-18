//  Jonathan Ritchey

import Foundation

struct DateFormatting {
        
    static func timeString(from date: Date) -> String {
        timeFormatter.timeZone = .current
        return timeFormatter.string(from: date)
    }
    
    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.timeZone = .current
        return formatter
    }()
    
    struct FriendlyDateFormatter {
        private static let calendar = Calendar.current

        private static let monthDayFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.setLocalizedDateFormatFromTemplate("MMM d")
            return formatter
        }()

        private static let relativeFormatter: RelativeDateTimeFormatter = {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .abbreviated   // "2w ago", "3d ago", "5m ago"
            return formatter
        }()

        static func relativeDescription(from date: Date, to reference: Date = Date()) -> String {
            let relative: String
            if calendar.isDate(date, inSameDayAs: reference) {
                relative = "today"
            } else {
                relative = "\(relativeFormatter.localizedString(for: date, relativeTo: reference))"
            }
            return relative
        }
        
        static func formatted(_ date: Date, relativeTo dateNow: Date) -> String {
            let absolute = monthDayFormatter.string(from: date)
            let relative = relativeDescription(from: date, to: dateNow)
            return "\(absolute) (\(relative))"
        }
    }
}
