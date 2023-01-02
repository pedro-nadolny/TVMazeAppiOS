import UIKit
import CoreInterface
import TVMazeServicesInterface

public protocol SeriesDetailFactoryProtocol {
    typealias Dependencies = DecoratedControllerFactoryProvider
        & DecoratedViewFactoryProvider
    
    func makeSeriesDetail(
        with dependencies: Dependencies,
        for show: Show
    ) -> UIViewController
}
