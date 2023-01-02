import Foundation
import TVMazeServicesInterface

struct DummyShow: Show {    
    let id: Int
    let name: String
    let image: Image?
    let genres: [String]
    let summary: String?
    let premiered: String?
    let ended: String?
    
    init(
        id: Int = .init(),
        name: String = .init(),
        image: Image? = DummyImage(),
        genres: [String] = .init(),
        summary: String? = .init(),
        premiered: String? = .init(),
        ended: String? = .init()
    ) {
        self.id = id
        self.name = name
        self.image = image
        self.genres = genres
        self.summary = summary
        self.premiered = premiered
        self.ended = ended
    }
}
