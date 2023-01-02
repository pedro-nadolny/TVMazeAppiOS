import Foundation
import SeriesCatalogInterface
import SeriesCatalog
import Core
import CoreInterface
import TVMazeServicesInterface
import TVMazeServices
import SeriesDetail
import SeriesDetailInterface

private typealias AllDependencies = SeriesCatalogFactoryProvider
    & DecoratedControllerFactoryProvider
    & DecoratedViewFactoryProvider
    & IndexServiceFactoryProvider
    & SearchServiceFactoryProvider
    & SeriesDetailFactoryProvider

final class DependencyContainer: AllDependencies {
    private(set) lazy var seriesCatalogFactory: SeriesCatalogFactoryProtocol = SeriesCatalog.seriesCatalogFatory
    private(set) lazy var decoratedControllerFactory: DecoratedControllerFactoryProtocol = Core.decoratedControllerFactory
    private(set) lazy var decoratedViewFactory: DecoratedViewFactoryProtocol = Core.decoratedViewFactory
    private(set) lazy var indexServiceFactory: IndexServiceFactoryProtocol = TVMazeServices.indexServiceFactory
    private(set) lazy var searchServiceFactory: SearchServiceFactoryProtocol = TVMazeServices.searchServiceFactory
    private(set) lazy var seriesDetailFactory: SeriesDetailFactoryProtocol = SeriesDetail.seriesDetailFactory
    
    private init() {}
    static let shared = DependencyContainer()
}
