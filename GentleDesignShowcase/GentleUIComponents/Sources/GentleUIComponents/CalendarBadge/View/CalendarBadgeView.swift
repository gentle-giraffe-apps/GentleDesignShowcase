//  Jonathan Ritchey
import SwiftUI

public struct CalendarBadgeView: View {
    
    public struct TextStyle: Sendable {
        let font: Font
        let tracking: Double
        let color: Color
        let inactiveColor: Color
        
        public init(
            font: Font,
            tracking: Double = 0,
            color: Color,
            inactiveColor: Color? = nil
        ) {
            self.font = font
            self.tracking = tracking
            self.color = color
            self.inactiveColor = inactiveColor ?? color
        }
        
        @ViewBuilder func text(for string: String, isActive: Bool) -> some View {
            Text(string)
                .font(font)
                .tracking(tracking)
                .foregroundStyle(isActive ? color : inactiveColor)
        }
    }

    public struct StyleMap : Sendable {
        let month, day: TextStyle
        let keyColor: Color
        let inactiveKeyColor: Color
        let backgroundColor: Color
        let monthBackgroundColor: Color
        let monthInactiveBackgroundColor: Color
        
        public init(
            month: TextStyle? = nil,
            day: TextStyle = .init(font: .callout.weight(.bold), color: .primary, inactiveColor: .primary),
            keyColor: Color = Color.accentColor,
            inactiveKeyColor: Color = .secondary,
            backgroundColor: Color = Color(.systemBackground), // FAFAFA
            monthBackgroundColor: Color = Color(red: 234/255, green: 216/255, blue: 218/255), // EAD8DA
            monthInactiveBackgroundColor: Color = Color(.systemGray4)
        ) {
            self.month = month ??
                .init(
                    font: .caption.weight(.semibold),
                    tracking: 0.4,
                    color: keyColor,
                    inactiveColor: inactiveKeyColor
                )
            self.day = day
            self.keyColor = keyColor
            self.inactiveKeyColor = inactiveKeyColor
            self.backgroundColor = backgroundColor
            self.monthBackgroundColor = monthBackgroundColor
            self.monthInactiveBackgroundColor = monthInactiveBackgroundColor
        }
    }

    public let viewModel: CalendarBadgeViewModel
    public let style: StyleMap
    
    public init(
        viewModel: CalendarBadgeViewModel,
        style: StyleMap
    ) {
        self.viewModel = viewModel
        self.style = style
    }
    
    @ScaledMetric(relativeTo: .body) private var _badgeSize: CGFloat = 48
    private var badgeSize: CGFloat { min(_badgeSize, 54) }
    private var monthVerticalPadding: CGFloat { badgeSize * (4.0 / 48.0) }
    private var spacerMin: CGFloat { badgeSize * (4.0 / 48.0) }
    private var cornerRadius: CGFloat { min(badgeSize * (4.0 / 48.0), 10) }
    
    public var body: some View {
        VStack(spacing: 0) {
            style.month.text(for: viewModel.month.text, isActive: viewModel.isActive)
                .padding(.top, 4)
                .padding(.bottom, 2)
                .frame(maxWidth: .infinity, alignment: .top)
                .background(
                    viewModel.isActive ?
                    style.monthBackgroundColor : style.monthInactiveBackgroundColor
                )
            style.day.text(for: viewModel.day.text, isActive: viewModel.isActive)
                .padding(.top, 4)
                .padding(.bottom, 8)
        }
        .frame(width: badgeSize, height: badgeSize)
        .background(style.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
    }
}

extension CalendarBadgeView.StyleMap {
    static let `default` = CalendarBadgeView.StyleMap()
}

#Preview("Default Active") {
    CalendarBadgeView(viewModel: .init(), style: .default)
        .preferredColorScheme(.light)
}

#Preview("Default Inactive") {
    CalendarBadgeView(viewModel: .init(isActive: false), style: .default)
        .preferredColorScheme(.light)
}

#Preview("Dark Mode Inactive") {
    CalendarBadgeView(viewModel: .init(isActive: false), style: .default)
        .preferredColorScheme(.dark)
}

#Preview("A11y xxxLarge") {
    CalendarBadgeView(
        viewModel: .init(),
        style: .init()
    )
    .environment(\.dynamicTypeSize, .accessibility3)
}

#Preview("A11y Capped") {
    CalendarBadgeView(
        viewModel: .init(),
        style: .init()
    )
    .environment(\.dynamicTypeSize, .accessibility5)
}

#Preview("Dark mode") {
    CalendarBadgeView(viewModel: .init(), style: .default)
        .preferredColorScheme(.dark)
}

