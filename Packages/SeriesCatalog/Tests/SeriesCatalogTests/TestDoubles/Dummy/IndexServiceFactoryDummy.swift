import Foundation
import TVMazeServicesInterface

final class IndexServiceFactoryDummy: IndexServiceFactoryProtocol {
    func makeIndexService() -> IndexServiceProtocol {
        IndexServiceDummy()
    }
}
