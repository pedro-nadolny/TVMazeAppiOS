import Foundation

struct IndexRequest: RequestProtocol {
    var path: String { "/shows?page=\(page)" }
    let httpMethod: HTTPMethod = .get
    
    let page: Int
}
