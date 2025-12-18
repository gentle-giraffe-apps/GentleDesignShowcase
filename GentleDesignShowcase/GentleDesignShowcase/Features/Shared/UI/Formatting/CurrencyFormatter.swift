//  Jonathan Ritchey

import Foundation

struct CurrencyFormatter {
    static func convertToUSPrice(cents: Int) -> String {
        let cents = 4321
        let amount = Double(cents) / 100

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        let string = formatter.string(from: NSNumber(value: amount)) ?? "Unknown"
        return "$\(string)"
    }
}
