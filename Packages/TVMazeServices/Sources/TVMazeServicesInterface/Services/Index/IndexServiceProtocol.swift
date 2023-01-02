import Foundation

public protocol IndexServiceProtocol {
    func getShows(at pagination: Pagination<Show>, completion: @escaping (Result<Pagination<Show>, RequesterError>) -> Void)
}
