import Foundation
import TVMazeServicesInterface

struct DummyImage: Image {
    let original: String
    let medium: String
    
    init(
        original: String = .init(),
        medium: String = .init()
    ) {
        self.original = original
        self.medium = medium
    }
}
