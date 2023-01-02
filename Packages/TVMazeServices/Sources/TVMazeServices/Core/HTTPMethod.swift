import Foundation

enum HTTPMethod: String, CustomStringConvertible {
    case get
    case post
    case put
    case delete
    case patch

    var description: String {
        rawValue.uppercased()
    }
}
