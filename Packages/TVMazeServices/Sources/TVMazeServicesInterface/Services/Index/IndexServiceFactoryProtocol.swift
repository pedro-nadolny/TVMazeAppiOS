import Foundation

public protocol IndexServiceFactoryProtocol {
    func makeIndexService() -> IndexServiceProtocol
}
