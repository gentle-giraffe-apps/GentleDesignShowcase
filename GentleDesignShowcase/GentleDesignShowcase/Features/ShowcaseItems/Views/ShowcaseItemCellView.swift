//  Jonathan Ritchey
import GentleDesignSystem
import SwiftUI

struct ShowcaseItemCellView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    let viewModel: ShowcaseItemCellViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.itemModel.title)
                        .gentleText(.headline_m)
                    if let subtitle = viewModel.itemModel.subtitle {
                        Text(subtitle)
                            .gentleText(.subheadline_ms)
                    }
                }
                .padding(.horizontal, 10)
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .frame(
            maxWidth: horizontalSizeClass == .compact ? .infinity : 450,
            minHeight: 400
        )
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(Color(.separator), lineWidth: 1.0)
        )
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}
