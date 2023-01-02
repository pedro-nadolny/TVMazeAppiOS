import Foundation

public protocol SearchServiceFactoryProvider {
    var searchServiceFactory: SearchServiceFactoryProtocol { get }
}
