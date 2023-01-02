import Foundation
import UIKit
import CoreInterface
import SeriesCatalogInterface

final class SeriesCatalogFactory: SeriesCatalogFactoryProtocol {    
    func makeSeriesCatalog(with dependencies: Dependencies) -> UIViewController {
        let viewModel = SeriesCatalogViewModel(dependencies: dependencies)
        let router = SeriesCatalogRouter(dependencies: dependencies)
        let viewDecorator = SeriesCartalogViewDecorator()
        
        let view = dependencies
            .decoratedViewFactory
            .makeDecoratedView(decorator: viewDecorator)
        
        let controller = dependencies
            .decoratedControllerFactory
            .makeDecoratedController(
                decorator: SeriesCatalogControllerDecorator(
                    viewModel: viewModel,
                    router: router,
                    viewProtocol: viewDecorator,
                    view: view
                )
            )
        
        router.controller = controller
        return controller
    }
}
