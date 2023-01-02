import Foundation
import TVMazeServicesInterface

final class IndexServiceDummy: IndexServiceProtocol {
    func getShows(at pagination: Pagination<Show>, completion: @escaping (Result<Pagination<Show>, RequesterError>) -> Void) {
        
    }
}
