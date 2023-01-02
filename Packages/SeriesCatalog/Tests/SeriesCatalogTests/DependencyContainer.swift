import Foundation
import TVMazeServicesInterface
@testable import SeriesCatalog

typealias AllDependencies = SeriesCatalogViewModel.Dependencies

final class DependencyContainer: AllDependencies {
    var indexServiceFactory: IndexServiceFactoryProtocol = IndexServiceFactoryDummy()
    var searchServiceFactory: SearchServiceFactoryProtocol = SearchServiceFactoryDummy()
    
    init() {}
}
