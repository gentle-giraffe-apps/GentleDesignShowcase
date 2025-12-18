//  Jonathan Ritchey
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
            Title()
            SegmentPicker()
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
        }
        .toolbar(.hidden, for: .navigationBar)
        .padding(.horizontal, 16)
        .task {
            await loadShowcaseItems()
        }
    }
    
    private func loadShowcaseItems() async {
        do {
            try await viewModel.fetchShowcaseItems()
        } catch {
            // TODO: surface this in UI later if you want
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
    
    func SegmentPicker() -> some View {
        return Picker("Filter", selection: $viewModel.filter) {
            ForEach(ShowcaseItemListViewModel.Filter.allCases, id: \.self) {
                Text($0.rawValue).tag($0)
            }
        }
        .padding(.horizontal, 8)
        .padding(.top, 40)
        .padding(.bottom, 16)
        .labelsHidden()
        .pickerStyle(.segmented)
    }
    
    func ShowcaseItemList() -> some View {
        List {
            ForEach(
                viewModel.filter == .upcoming
                    ? viewModel.upcomingCellViewModels
                    : viewModel.pastCellViewModels
            ) { cellViewModel in
                ShowcaseItemCellView(viewModel: cellViewModel)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())          // whole row is tappable
                    .listRowSeparator(.hidden)
                    .listRowInsets(
                        EdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4)
                    )
                    .onTapGesture {
                        router.push(.itemDetailView(cellViewModel.itemModel),
                                    for: .itemsTab)
                    }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .id(viewModel.filter)
    }
}

#Preview {
    ShowcaseItemListView(
        viewModel: ShowcaseItemListViewModel(
            repository: ShowcaseRepository.mockRepository()
        )
    )
    .environment(
        AppRouter(showcaseRepository: ShowcaseRepository.mockRepository())
    )
}
