import Foundation
import TVMazeServicesInterface

final class IndexServiceFactoryStub: IndexServiceFactoryProtocol {
    var stubbedResult: IndexServiceProtocol = IndexServiceDummy()
    func makeIndexService() -> IndexServiceProtocol {
        return stubbedResult
    }
}
