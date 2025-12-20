//  Jonathan Ritchey
import GentleDesignSystem
import Observation
import SwiftUI

struct ShowcaseItemListView: View {
    @Environment(AppRouter.self) private var router
    @Environment(PreviewRenderer.self) private var previewRenderer
    @Environment(\.scenePhase) private var scenePhase
    @State private var viewModel: ShowcaseItemListViewModel
    @State private var isRenderingPreviews: Bool = true
    
    init(
        viewModel: ShowcaseItemListViewModel
    ) {
        _viewModel = .init(initialValue: viewModel)
    }
    
    var body: some View {
        @Bindable var router = router
        Group {
            let isLoading = viewModel.isLoading && viewModel.hasLoadedOnce == false
            if isLoading || isRenderingPreviews {
                ProgressView("Loading showcase items...")
            } else {
                ShowcaseItemList()
            }
        }
        .task(id: scenePhase) {
            guard scenePhase == .active else { return }
            await loadShowcaseItems()
            await renderPreviews()
        }
        .navigationTitle(viewModel.title)
        .gentleSurface(.appBackground)
    }
    
    private func loadShowcaseItems() async {
        do {
            try await viewModel.fetchShowcaseItems()
        } catch {
            print("Failed to fetch items: \(error)")
        }
    }
    
    @MainActor
    private func renderPreviews() async {
        guard isRenderingPreviews else { return }
        defer { isRenderingPreviews = false }
        await previewRenderer.prefetch()
    }
}

extension ShowcaseItemListView {
    @ViewBuilder
    func ShowcaseItemList() -> some View {
        let rows = [
            GridItem(.fixed(previewCardSize.height))
        ]
        let shim: CGFloat = 4
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: 16) {
                Color.clear.frame(width: shim)
                ForEach(viewModel.filteredViewModels) { viewModel in
                    Button {
                        router.push(viewModel.itemModel.route(), for: .itemsTab)
                    } label: {
                        ShowcaseItemCellView(viewModel: viewModel)
                            .contentShape(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                            ) // makes entire card tappable
                    }
                    .buttonStyle(.plain)
                }
                Color.clear.frame(width: shim)
            }
        }
        .frame(
            height: previewCardSize.height
        )
        .clipped()
    }
}

#Preview {
    ShowcaseItemListView(
        viewModel: ShowcaseItemListViewModel(
            repository: ShowcaseRepository.mockRepository()
        )
    )
    .environment(AppRouter.preview)
    .environment(PreviewRenderer())
}
