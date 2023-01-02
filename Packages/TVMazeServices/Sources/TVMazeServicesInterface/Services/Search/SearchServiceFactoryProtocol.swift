import Foundation

public protocol SearchServiceFactoryProtocol {
    func makeSearchService() -> SearchServiceProtocol
}
