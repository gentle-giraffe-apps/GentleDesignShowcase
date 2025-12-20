//  Jonathan Ritchey
import GentleDesignSystem
import Observation
import SwiftUI

struct ShowcaseItemListView: View {
    @Environment(AppRouter.self) private var router
    @Environment(\.scenePhase) private var scenePhase
    @State private var viewModel: ShowcaseItemListViewModel
    
    init(
        viewModel: ShowcaseItemListViewModel
    ) {
        _viewModel = .init(initialValue: viewModel)
    }
    
    var body: some View {
        @Bindable var router = router
        VStack {
            // Title()
            if viewModel.isLoading && viewModel.hasLoadedOnce == false {
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
        .task {
            await loadShowcaseItems()
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
            LazyVGrid(columns: columns) {
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
}
