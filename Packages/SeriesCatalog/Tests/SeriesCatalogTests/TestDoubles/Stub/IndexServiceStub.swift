import Foundation
import TVMazeServicesInterface

final class IndexServiceStub: IndexServiceProtocol {
    var stubbedResult: Result<Pagination<Show>, RequesterError> = .success(.init())
    func getShows(at pagination: Pagination<Show>, completion: @escaping (Result<Pagination<Show>, RequesterError>) -> Void) {
        completion(stubbedResult)
    }
}
