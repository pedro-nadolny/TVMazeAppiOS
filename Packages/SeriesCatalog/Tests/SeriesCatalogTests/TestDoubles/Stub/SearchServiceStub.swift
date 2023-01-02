import Foundation
import TVMazeServicesInterface

final class SearchServiceStub: SearchServiceProtocol {
    var stubbedResult: Result<[SearchItem], RequesterError> = .success([])
    func getSeries(searchFor search: String, completion: @escaping (Result<[SearchItem], RequesterError>) -> Void) {
        completion(stubbedResult)
    }
}
