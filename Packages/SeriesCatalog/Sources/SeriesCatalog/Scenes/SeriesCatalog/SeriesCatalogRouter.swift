import UIKit
import SeriesDetailInterface
import CoreInterface
import TVMazeServicesInterface

protocol SeriesCatalogRouterProtocol {
    func routeToSeriesDetail(with show: Show)
}

final class SeriesCatalogRouter: SeriesCatalogRouterProtocol {
    typealias Dependencies = SeriesDetailFactoryProvider
        & DecoratedViewFactoryProvider
        & DecoratedControllerFactoryProvider
    
    private let dependencies: Dependencies
    weak var controller: UIViewController?
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func routeToSeriesDetail(with show: Show) {
        let seriesDetailController = dependencies
            .seriesDetailFactory
            .makeSeriesDetail(
                with: dependencies,
                for: show)
        
        controller?.navigationController?.pushViewController(seriesDetailController, animated: true)
    }
}
