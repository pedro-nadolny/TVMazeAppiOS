import Foundation
import TVMazeServicesInterface

final class SearchServiceDummy: SearchServiceProtocol {
    func getSeries(searchFor search: String, completion: @escaping (Result<[SearchItem], RequesterError>) -> Void) {
        
    }
}
