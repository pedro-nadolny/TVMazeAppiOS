import TVMazeServicesInterface

public enum TVMazeServices {
    public static let indexServiceFactory: IndexServiceFactoryProtocol = IndexServiceFactory()
    public static let searchServiceFactory: SearchServiceFactoryProtocol = SearchServiceFactory()
}
