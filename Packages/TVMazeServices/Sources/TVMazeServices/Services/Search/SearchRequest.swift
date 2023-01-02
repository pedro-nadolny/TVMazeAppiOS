import Foundation

struct SearchRequest: RequestProtocol {
    var path: String { "/search/shows?q=\(query)" }
    let httpMethod: HTTPMethod = .get
    
    let query: String
}
