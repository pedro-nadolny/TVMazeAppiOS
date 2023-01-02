import Foundation
import TVMazeServicesInterface

final class SearchServiceFactoryDummy: SearchServiceFactoryProtocol {
    func makeSearchService() -> SearchServiceProtocol {
        SearchServiceDummy()
    }
}
