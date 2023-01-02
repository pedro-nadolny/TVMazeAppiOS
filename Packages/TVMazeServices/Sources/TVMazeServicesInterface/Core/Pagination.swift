import Foundation

public protocol PaginationProtocol {
    var page: Int { get }
}

public struct Pagination<Model>: PaginationProtocol {
    public let page: Int
    public let content: [Model]
    
    public init(page: Int = 0, content: [Model] = []) {
        self.page = page
        self.content = content
    }
}
