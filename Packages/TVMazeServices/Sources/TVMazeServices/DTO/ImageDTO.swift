import Foundation
import TVMazeServicesInterface

struct ImageDTO: Image, Decodable {
    let medium: String
    let original: String
    
    init(image: any Image) {
        self.medium = image.medium
        self.original = image.original
    }
}
