import Foundation
import TVMazeServicesInterface

struct SearchItemDTO: SearchItem, Decodable {
    let score: Double
    
    let showDTO: ShowDTO
    var show: Show { showDTO }
    
    enum CodingKeys: String, CodingKey {
        case score
        case showDTO = "show"
    }
}
