//  Jonathan Ritchey
import GentleDesignSystem
import Observation
import SwiftUI

struct ShowcaseItemListView: View {
    @Environment(AppRouter.self) private var router
    @Environment(PreviewRenderer.self) private var previewRenderer
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.gentleThemeManager) private var themeManager
    @State private var viewModel: ShowcaseItemListViewModel
    @State private var isRenderingPreviews: Bool = true
    @State private var refreshID = UUID()
    @Binding var selectedTab: RootViewTab

    init(
        viewModel: ShowcaseItemListViewModel,
        selectedTab: Binding<RootViewTab>
    ) {
        _viewModel = .init(initialValue: viewModel)
        _selectedTab = selectedTab
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
        .id(refreshID)
        .task(id: scenePhase) {
            guard scenePhase == .active else { return }
            await loadShowcaseItems()
            await renderPreviews()
        }
        .onChange(of: selectedTab) { _, newValue in
            guard newValue == .items else { return }
            Task {
                await refresh()
            }
        }
        .navigationTitle(viewModel.title)
        .gentleSurface(.appBackground)
    }
    
    func refresh() async {
        refreshID = UUID()
        isRenderingPreviews = true
        previewRenderer.clearCache()
        await loadShowcaseItems()
        await renderPreviews()
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
        previewRenderer.theme = themeManager?.theme
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
                        router.push(viewModel.itemModel.route(), for: .showcaseTab)
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
        ),
        selectedTab: .constant(.items)
    )
    .environment(AppRouter.preview)
    .environment(PreviewRenderer())
}
