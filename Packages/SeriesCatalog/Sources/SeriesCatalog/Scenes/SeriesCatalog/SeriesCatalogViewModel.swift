import Foundation
import Combine
import TVMazeServicesInterface

protocol SeriesCatalogViewModelOutput {
    var list: AnyPublisher<[Show], Never> { get }
    var search: AnyPublisher<[Show], Never> { get }
}

protocol SeriesCatalogViewModelInput {
    func loadNewPage()
    func searchDelegateActiveStatusChanged(_ status: Bool)
    func searchFor(query: String)
}

typealias SeriesCatalogViewModelProtocol = SeriesCatalogViewModelInput & SeriesCatalogViewModelOutput

final class SeriesCatalogViewModel {
    typealias Dependencies = IndexServiceFactoryProvider
        & SearchServiceFactoryProvider
    
    private let dependencies: Dependencies
    
    @Published private var listPublished: [Show] = []
    @Published private var searchPublished: [Show] = []
    
    private var pagination = Pagination<Show>(page: 1)
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension SeriesCatalogViewModel: SeriesCatalogViewModelInput {
    func loadNewPage() {
        dependencies
            .indexServiceFactory
            .makeIndexService()
            .getShows(
                at: pagination,
                completion: { result in
                    switch result {
                    case .success(let newPagination):
                        self.pagination = newPagination
                        self.listPublished = newPagination.content
                    case .failure:
                        break
                    }
                }
            )
    }
    
    func searchDelegateActiveStatusChanged(_ status: Bool) {
        if status { return }
        listPublished = pagination.content
    }
    
    func searchFor(query: String) {
        if query.isEmpty { return }
        
        dependencies
            .searchServiceFactory
            .makeSearchService()
            .getSeries(searchFor: query) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let searchedList):
                    self.searchPublished = searchedList.map(\.show)
                case .failure:
                    self.searchPublished = []
                }
            }
    }
}

extension SeriesCatalogViewModel: SeriesCatalogViewModelOutput {
    var list: AnyPublisher<[Show], Never> { $listPublished.eraseToAnyPublisher() }
    var search: AnyPublisher<[Show], Never> { $searchPublished.eraseToAnyPublisher() }
}
