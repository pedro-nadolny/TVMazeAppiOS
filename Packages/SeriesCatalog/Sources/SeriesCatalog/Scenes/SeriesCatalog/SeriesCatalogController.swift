import UIKit
import Combine
import CoreInterface

final class SeriesCatalogControllerDecorator {
    private let viewModelOutput: SeriesCatalogViewModelOutput
    private let viewModelInput: SeriesCatalogViewModelInput
    private let router: SeriesCatalogRouterProtocol
    private let viewInput: SeriesCartalogViewInput
    private let viewOutput: SeriesCartalogViewOutput
    private let view: UIView
    private var cancellables = Set<AnyCancellable>()
    
    private let searchDelegate = SearchControllerDelegate()
    private let searchController = UISearchController()
        
    init(
        viewModel: SeriesCatalogViewModelProtocol,
        router: SeriesCatalogRouterProtocol,
        viewProtocol: SeriesCartalogViewProtocol,
        view: UIView
    ) {
        self.viewModelOutput = viewModel
        self.viewModelInput = viewModel
        self.viewInput = viewProtocol
        self.viewOutput = viewProtocol
        self.view = view
        self.router = router
        
        makeBindings()
    }
}

extension SeriesCatalogControllerDecorator: ControllerDecorator {
    func loadView(controller: UIViewController) {
        controller.view = view
    }
    
    func viewDidLoad(controller: UIViewController) {
        controller.title = "TVMaze"
        controller.navigationItem.largeTitleDisplayMode = .always
        controller.navigationItem.searchController = searchController
        searchController.delegate = searchDelegate
        searchController.searchBar.delegate = searchDelegate
        
        viewInput.startLoading()
        viewModelInput.loadNewPage()
    }
}

private extension SeriesCatalogControllerDecorator {
    func makeBindings() {
        viewModelOutput
            .list
            .receive(on: RunLoop.main)
            .sink(receiveValue: viewInput.update)
            .store(in: &cancellables)
        
        viewModelOutput
            .search
            .receive(on: RunLoop.main)
            .sink(receiveValue: viewInput.showSearch)
            .store(in: &cancellables)
        
        viewOutput
            .wantsMoreContent
            .sink(receiveValue: viewModelInput.loadNewPage)
            .store(in: &cancellables)
        
        viewOutput
            .selectedShow
            .sink(receiveValue: router.routeToSeriesDetail)
            .store(in: &cancellables)
        
        searchDelegate.$searchText
            .debounce(for: 1, scheduler: DispatchQueue.global())
            .sink(receiveValue: { [viewModelInput] query in viewModelInput.searchFor(query: query) })
            .store(in: &cancellables)
        
        searchDelegate.$isActive
            .sink(receiveValue: viewModelInput.searchDelegateActiveStatusChanged)
            .store(in: &cancellables)
    }
}
