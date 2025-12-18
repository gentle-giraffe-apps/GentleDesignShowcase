//  Jonathan Ritchey
import Foundation

public struct CalendarBadgeViewModel: Identifiable, Hashable {
    
    public enum TextRole: Hashable {
        case calendarMonth(String)
        case calendarDay(String)
        var text: String {
            switch self {
            case .calendarMonth(let value): return value
            case .calendarDay(let value): return value
            }
        }
    }
    
    public let id = UUID()
    public let date: Date
    public let isActive: Bool
    public let month, day: TextRole
        
    public init(
        date: Date = Date(),
        isActive: Bool = true,
        monthFormat: String = "MMM",
        dayFormat: String = "dd"
    ) {
        self.date = date
        self.isActive = isActive
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = monthFormat
        self.month = .calendarMonth(dateFormatter.string(from: date).uppercased())
        dateFormatter.dateFormat = dayFormat
        self.day = .calendarDay(dateFormatter.string(from: date))
    }
}
