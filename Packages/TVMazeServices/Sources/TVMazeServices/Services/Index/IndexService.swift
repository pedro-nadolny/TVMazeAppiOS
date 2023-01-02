import Foundation
import TVMazeServicesInterface

final class IndexService: IndexServiceProtocol {
    private let requester: RequesterProtocol
    
    init(requester: RequesterProtocol) {
        self.requester = requester
    }
    
    func getShows(
        at pagination: Pagination<Show>,
        completion: @escaping (Result<Pagination<Show>, RequesterError>) -> Void
    ) -> Void {
        let pagination = Pagination(
            page: pagination.page,
            content: pagination.content.map(ShowDTO.init)
        )
        
        requester.make(
            paginatedRequest: IndexRequest(page: pagination.page),
            with: pagination
        ) { result in
            completion(result.map {
                Pagination(
                    page: $0.page,
                    content: $0.content as [Show]
                )
            }
            )
        }
    }
}
