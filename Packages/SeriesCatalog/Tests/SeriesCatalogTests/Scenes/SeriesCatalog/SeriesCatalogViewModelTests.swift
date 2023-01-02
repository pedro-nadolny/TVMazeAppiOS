import XCTest
import Combine
import TVMazeServicesInterface
@testable import SeriesCatalog

final class SeriesCatalogViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    
    private let closureSpy = ClosureSpy<[Show]>()
    private let indexServiceStub = IndexServiceStub()
    private let searchServiceStub = SearchServiceStub()
    
    private lazy var indexServiceFactoryStub: IndexServiceFactoryStub = {
        let stub = IndexServiceFactoryStub()
        stub.stubbedResult = indexServiceStub
        return stub
    }()
    
    private lazy var searchServiceFactoryStub: SearchServiceFactoryStub = {
        let stub = SearchServiceFactoryStub()
        stub.stubbedResult = searchServiceStub
        return stub
    }()
    
    private lazy var dependencies: DependencyContainer = {
        let container = DependencyContainer()
        container.indexServiceFactory = indexServiceFactoryStub
        container.searchServiceFactory = searchServiceFactoryStub
        return container
    }()
    
    private lazy var sut = SeriesCatalogViewModel(dependencies: dependencies)
    
    func test_loadNewPage_WhenServiceReturnSuccess_ShouldReturn() {
        // Given
        let stubbedContent = [DummyShow(id: 1), DummyShow(id: 2), DummyShow(id: 3)]
        indexServiceStub.stubbedResult = .success(.init(content: stubbedContent))
        
        sut.list
            .sink(receiveValue: closureSpy.closure)
            .store(in: &cancellables)
        
        // When
        sut.loadNewPage()
        
        // Then
        XCTAssertEqual(closureSpy.callCount, 2)
        XCTAssertEqual(closureSpy.receivedValues[0].map(\.id), [])
        XCTAssertEqual(closureSpy.receivedValues[1].map(\.id), [1, 2, 3])
    }
    
    func test_loadNewPage_WhenServiceReturnError_ShouldNotSendNewList() {
        // Given
        indexServiceStub.stubbedResult = .failure(.emptyData)
        
        sut.list
            .sink(receiveValue: closureSpy.closure)
            .store(in: &cancellables)
        
        // When
        sut.loadNewPage()
        
        // Then
        XCTAssertEqual(closureSpy.callCount, 1)
        XCTAssertEqual(closureSpy.receivedValues[0].map(\.id), [])
    }
    
    func test_searchDelegateActiveStatusChanged_WhenStatusIsFalse_ShouldDisplayPaginatedContent() {
        // Given
        let stubbedContent = [DummyShow(id: 1), DummyShow(id: 2), DummyShow(id: 3)]
        indexServiceStub.stubbedResult = .success(.init(content: stubbedContent))
        
        sut.list
            .sink(receiveValue: closureSpy.closure)
            .store(in: &cancellables)
        
        sut.loadNewPage()
        
        // When
        sut.searchDelegateActiveStatusChanged(false)
        
        // Then
        XCTAssertEqual(closureSpy.callCount, 3)
        XCTAssertEqual(closureSpy.receivedValues[0].map(\.id), [])
        XCTAssertEqual(closureSpy.receivedValues[1].map(\.id), [1, 2, 3])
        XCTAssertEqual(closureSpy.receivedValues[2].map(\.id), [1, 2, 3])
    }
    
    func test_searchDelegateActiveStatusChanged_WhenStatusIsTrue_ShouldDoNothing() {
        // Given
        let stubbedContent = [DummyShow(id: 1), DummyShow(id: 2), DummyShow(id: 3)]
        indexServiceStub.stubbedResult = .success(.init(content: stubbedContent))
        
        sut.list
            .sink(receiveValue: closureSpy.closure)
            .store(in: &cancellables)
        
        sut.loadNewPage()
        
        // When
        sut.searchDelegateActiveStatusChanged(true)
        
        // Then
        XCTAssertEqual(closureSpy.callCount, 2)
        XCTAssertEqual(closureSpy.receivedValues[0].map(\.id), [])
        XCTAssertEqual(closureSpy.receivedValues[1].map(\.id), [1, 2, 3])
    }
    
    func test_searchForQuery_WhenQueryIsNotEmptyAndSearchServiceReturnsSuccess_ShouldSendSearch() {
        // Given
        let stubbedContent = [
            DummySearchItem(show: DummyShow(id: 1)),
            DummySearchItem(show: DummyShow(id: 2)),
            DummySearchItem(show: DummyShow(id: 3)),
        ]
        
        searchServiceStub.stubbedResult = .success(stubbedContent)
        
        sut.search
            .sink(receiveValue: closureSpy.closure)
            .store(in: &cancellables)
        
        // When
        sut.searchFor(query: "Naruto")
        
        // Then
        XCTAssertEqual(closureSpy.callCount, 2)
        XCTAssertEqual(closureSpy.receivedValues[0].map(\.id), [])
        XCTAssertEqual(closureSpy.receivedValues[1].map(\.id), [1, 2, 3])
    }
    
    func test_searchForQuery_WhenQueryIsNotEmptyAndSearchServiceReturnsSuccess_ShouldSendEmptySearchResult() {
        // Given
        searchServiceStub.stubbedResult = .failure(.emptyData)
        
        sut.search
            .sink(receiveValue: closureSpy.closure)
            .store(in: &cancellables)
        
        // When
        sut.searchFor(query: "Naruto")
        
        // Then
        XCTAssertEqual(closureSpy.callCount, 2)
        XCTAssertEqual(closureSpy.receivedValues[0].map(\.id), [])
        XCTAssertEqual(closureSpy.receivedValues[0].map(\.id), [])
    }
    
    func test_searchForQuery_WhenQueryIsEmpty_ShouldDoNothing() {
        // Given
        let stubbedContent = [
            DummySearchItem(show: DummyShow(id: 1)),
            DummySearchItem(show: DummyShow(id: 2)),
            DummySearchItem(show: DummyShow(id: 3)),
        ]
        
        searchServiceStub.stubbedResult = .success(stubbedContent)
        
        sut.search
            .sink(receiveValue: closureSpy.closure)
            .store(in: &cancellables)
        
        // When
        sut.searchFor(query: "")
        
        // Then
        XCTAssertEqual(closureSpy.callCount, 1)
        XCTAssertEqual(closureSpy.receivedValues[0].map(\.id), [])
    }
}
