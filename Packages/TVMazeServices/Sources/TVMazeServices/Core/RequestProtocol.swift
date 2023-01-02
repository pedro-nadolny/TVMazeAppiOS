import Foundation

protocol RequestProtocol {
    var httpMethod: HTTPMethod { get }
    var path: String { get }
}

extension RequestProtocol {
    var basePath: String { "https://api.tvmaze.com" }
    var urlString: String { basePath + path }
}
