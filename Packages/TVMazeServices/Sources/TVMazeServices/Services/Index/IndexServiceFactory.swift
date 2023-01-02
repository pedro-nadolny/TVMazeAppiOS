import Foundation
import TVMazeServicesInterface

final class IndexServiceFactory: IndexServiceFactoryProtocol {
    func makeIndexService() -> IndexServiceProtocol {
        return IndexService(requester: Requester())
    }
}
