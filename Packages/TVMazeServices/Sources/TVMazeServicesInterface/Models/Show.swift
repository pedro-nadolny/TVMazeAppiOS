import Foundation

public protocol Show {
    var id: Int { get }
    var name: String { get }
    var image: Image? { get }
    var genres: [String] { get }
    var summary: String? { get }
    var premiered: String? { get }
    var ended: String? { get }
}
