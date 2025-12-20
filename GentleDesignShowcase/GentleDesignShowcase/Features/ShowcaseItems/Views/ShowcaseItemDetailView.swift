// Jonathan Ritchey

import SwiftUI

struct ShowcaseItemDetailView: View {
    @State private var viewModel: ShowcaseItemDetailViewModel
    
    init(viewModel: ShowcaseItemDetailViewModel) {
        _viewModel = .init(initialValue: viewModel)
    }
        
    var body: some View {
        VStack(alignment: .leading) {
            Title()
            
            HStack(spacing: 16) {
                OriginPanel()
                DestinationPanel()
            }
            .padding(.bottom, 8)
            
            HStack {
                TripDetailListHeadings()
                Spacer()
                TripDetailsListValues()
            }
            .padding(.bottom, 6)
                        
            Spacer()
        }
        .padding(.horizontal, 22)
    }
}

extension ShowcaseItemDetailView {
    func Title() -> some View {
        return Text(viewModel.title)
            .font(Font.largeTitle.bold())
            .foregroundColor(.primary)
            .padding(.bottom, 24)
    }
    
    func OriginPanel() -> some View {
        return VStack(alignment: .leading) {
            Text(viewModel.originPanel.title)
                .font(Font.subheadline.weight(.bold))
                .foregroundColor(.primary)
                .padding(.vertical, 4)
            Text(viewModel.originPanel.subTitle)
                .font(Font.subheadline.weight(.regular))
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(Color(.separator), lineWidth: 1.0)
        )
    }
    
    func DestinationPanel() -> some View {
        return VStack(alignment: .leading) {
            Text(viewModel.destinationPanel.title)
                .font(Font.subheadline.weight(.bold))
                .foregroundColor(.primary)
                .padding(.vertical, 4)
            Text(viewModel.destinationPanel.subTitle)
                .font(Font.subheadline.weight(.regular))
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(Color(.separator), lineWidth: 1.0)
        )
    }
    
    @ViewBuilder
    func TripDetailListHeadings() -> some View {
        VStack(alignment: .leading) {
            Text("Date")
                .font(Font.subheadline.weight(.bold))
                .foregroundColor(.secondary)
                .padding(.vertical, 8)
            Text("Number 1")
                .font(Font.subheadline.weight(.bold))
                .foregroundColor(.secondary)
                .padding(.vertical, 8)
            Text("Number 2")
                .font(Font.subheadline.weight(.bold))
                .foregroundColor(.secondary)
                .padding(.vertical, 8)
            Text("Number 3")
                .font(Font.subheadline.weight(.bold))
                .foregroundColor(.secondary)
                .padding(.vertical, 8)
            Text("Price")
                .font(Font.subheadline.weight(.bold))
                .foregroundColor(.secondary)
                .padding(.vertical, 8)
        }
    }
    
    @ViewBuilder
    func TripDetailsListValues() -> some View {
        VStack(alignment: .trailing) {
            Text("date")
                .font(Font.subheadline.weight(.bold))
                .foregroundColor(.primary)
                .padding(.vertical, 8)
            Text("number 1")
                .font(Font.subheadline.weight(.bold))
                .foregroundColor(.primary)
                .padding(.vertical, 8)
            Text("number 2")
                .font(Font.subheadline.weight(.bold))
                .foregroundColor(.primary)
                .padding(.vertical, 8)
            Text("number 3")
                .font(Font.subheadline.weight(.bold))
                .foregroundColor(.primary)
                .padding(.vertical, 8)
            Text("price")
                .font(Font.subheadline.weight(.bold))
                .foregroundColor(.primary)
                .padding(.vertical, 8)
        }
    }
}

#Preview("DetailView") {
    ShowcaseItemDetailView(
        viewModel: ShowcaseItemDetailViewModel(
            itemModel: ShowcaseItem.chartAndStats,
            repository: ShowcaseRepository(showcaseItemsService: ShowcaseItemsService())
        )
    )
    .environment(AppRouter.preview)
    .environment(PreviewRenderer())
}
