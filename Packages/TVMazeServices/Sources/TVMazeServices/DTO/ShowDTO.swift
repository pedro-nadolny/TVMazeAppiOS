import Foundation
import TVMazeServicesInterface

struct ShowDTO: Show, Decodable {    
    let id: Int
    let name: String
    let imageDTO: ImageDTO?
    let premiered: String?
    let ended: String?
    let genres: [String]
    let summary: String?
    
    var image: Image? { imageDTO }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case genres
        case summary
        case premiered
        case ended
        case imageDTO = "image"
    }
    
    init(series: Show) {
        self.id = series.id
        self.name = series.name
        self.summary = series.summary
        self.genres = series.genres
        self.premiered = series.premiered
        self.ended = series.ended
        
        if let image = series.image {
            imageDTO = ImageDTO(image: image)
        } else {
            imageDTO = nil
        }
    }
}

