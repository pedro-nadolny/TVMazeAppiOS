import Foundation
import UIKit
import CoreInterface
import SeriesDetailInterface
import TVMazeServicesInterface

final class SeriesDetailFactory: SeriesDetailFactoryProtocol {
    func makeSeriesDetail(
        with dependencies: Dependencies,
        for show: Show
    ) -> UIViewController {
        let viewModel = SeriesDetailViewModel(dependencies: (), show: show)
        let router = SeriesDetailRouter()
        let viewDecorator = SeriesDetailViewDecorator(show: show)
        let view = dependencies
            .decoratedViewFactory
            .makeDecoratedView(decorator: viewDecorator)
        
        let controller = dependencies
            .decoratedControllerFactory
            .makeDecoratedController(
                decorator: SeriesDetailControllerDecorator(
                    viewModel: viewModel,
                    router: router,
                    viewProtocol: viewDecorator,
                    view: view
                )
            )

        router.controller = controller
        controller.title = show.name
        
        return controller
    }
}
