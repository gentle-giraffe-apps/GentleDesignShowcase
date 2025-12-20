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
        VStack {
            // Title()
            let isLoading = viewModel.isLoading && viewModel.hasLoadedOnce == false
            if isLoading || isRenderingPreviews {
                Spacer()
                ProgressView("Loading showcase items...")
                Spacer()
            } else {
                ShowcaseItemList()
                    .refreshable {
                        await loadShowcaseItems()
                    }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
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
    func Title() -> some View {
        return HStack(alignment: .center) {
            Text(viewModel.title)
                .font(.largeTitle.bold())
            Spacer()
        }
        .padding(.top, 8)
        .padding(.bottom, 8)
        .padding(.horizontal, 22)
    }
    
    @ViewBuilder
    func ShowcaseItemList() -> some View {
        let columns = [
            GridItem(.adaptive(minimum: 300), spacing: 16)
        ]
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
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
            }
        }
        .scrollIndicators(.hidden)
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
