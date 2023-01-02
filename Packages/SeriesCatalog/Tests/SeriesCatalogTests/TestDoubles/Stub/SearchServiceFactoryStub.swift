import Foundation
import TVMazeServicesInterface

final class SearchServiceFactoryStub: SearchServiceFactoryProtocol {
    var stubbedResult: SearchServiceProtocol = SearchServiceDummy()
    func makeSearchService() -> SearchServiceProtocol {
        stubbedResult
    }
}
