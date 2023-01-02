import Foundation
import TVMazeServicesInterface

final class SearchService: SearchServiceProtocol {
    private let requester: RequesterProtocol
    
    init(requester: RequesterProtocol) {
        self.requester = requester
    }
    
    func getSeries(searchFor search: String, completion: @escaping (Result<[SearchItem], RequesterError>) -> Void) {
        requester.make(request: SearchRequest(query: search)) { (result: Result<[SearchItemDTO], RequesterError>) in
            completion(result.map { $0 as [SearchItem] })
        }
    }
}
