import Foundation

public protocol SearchServiceProtocol {
    func getSeries(
        searchFor search: String,
        completion: @escaping (Result<[SearchItem], RequesterError>) -> Void
    )
}
 
