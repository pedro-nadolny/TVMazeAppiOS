import Foundation
import TVMazeServicesInterface

final class SearchServiceFactory: SearchServiceFactoryProtocol {    
    func makeSearchService() -> SearchServiceProtocol {
        SearchService(requester: Requester())
    }
}
