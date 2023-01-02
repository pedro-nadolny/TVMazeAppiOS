import Foundation
import TVMazeServicesInterface

struct DummySearchItem: SearchItem {
    let score: Double
    let show: Show
    
    init(score: Double = .init(), show: Show = DummyShow()) {
        self.score = score
        self.show = show
    }
}
