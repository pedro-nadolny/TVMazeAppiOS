import UIKit
import CoreInterface
import TVMazeServicesInterface
import SeriesDetailInterface

public protocol SeriesCatalogFactoryProtocol {
    typealias Dependencies = DecoratedControllerFactoryProvider
        & DecoratedViewFactoryProvider
        & IndexServiceFactoryProvider
        & SearchServiceFactoryProvider
        & SeriesDetailFactoryProvider
    
    func makeSeriesCatalog(with dependencies: Dependencies) -> UIViewController
}
