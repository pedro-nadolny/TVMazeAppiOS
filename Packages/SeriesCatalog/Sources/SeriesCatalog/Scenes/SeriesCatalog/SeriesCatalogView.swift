import UIKit
import CoreInterface
import LayoutExtensions
import TVMazeServicesInterface
import Combine

protocol SeriesCartalogViewInput {
    func update(seriesList: [Show])
    func showSearch(seriesList: [Show])
    func startLoading()
}

protocol SeriesCartalogViewOutput { 
    var wantsMoreContent: AnyPublisher<Void, Never> { get }
    var selectedShow: AnyPublisher<Show, Never> { get }
}

typealias SeriesCartalogViewProtocol = SeriesCartalogViewOutput & SeriesCartalogViewInput

final class
SeriesCartalogViewDecorator: NSObject, ViewDecorator {
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: TwoColumnsFlowLayout()
    )
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    private let dataSource = CollectionDataSource<Show, SeriesCell>()
    private var pageSize: Int?
    private var showingSearchResult = false
    
    @Published private var publishedWantsMoreContent = false
    @Published private var publishedSelectedShow: Show? = nil
    
    func buildViewHierarchy(view: UIView) {
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        activityIndicator.centerToSuperview()
    }
    
    func setConstraints(view: UIView) {
        collectionView.fillSuperview()
    }
    
    func setProperties(view: UIView) {
        view.backgroundColor = .systemBackground
        
        collectionView.register(SeriesCell.self)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
}

extension SeriesCartalogViewDecorator: SeriesCartalogViewInput {
    func showSearch(seriesList: [Show]) {
        showingSearchResult = true
        dataSource.data = [seriesList]
        
        collectionView.performBatchUpdates {
            collectionView.reloadSections(.init(integer: 0))
        } completion: { [weak self] completed in
            guard let self, completed else { return }
            self.activityIndicator.stopAnimating()
        }
    }
    
    func update(seriesList: [Show]) {
        if pageSize == nil && !seriesList.isEmpty {
            pageSize = seriesList.count
        }
        
        showingSearchResult = false
        dataSource.data = [seriesList]
        collectionView.reloadData()
        activityIndicator.stopAnimating()
        publishedWantsMoreContent = false
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
        dataSource.data = []
    }
}

extension SeriesCartalogViewDecorator: SeriesCartalogViewOutput {
    var wantsMoreContent: AnyPublisher<Void, Never> {
        $publishedWantsMoreContent
            .removeDuplicates()
            .filter { $0 }
            .map { _ in }
            .eraseToAnyPublisher()
    }
    
    var selectedShow: AnyPublisher<Show, Never> {
        $publishedSelectedShow
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
}

extension SeriesCartalogViewDecorator: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if publishedWantsMoreContent || showingSearchResult { return }
        
        let numberOfItems = dataSource.data
            .compactMap { $0.count }
            .reduce(0, +)
        
        if indexPath.row != numberOfItems - 1 { return }
        publishedWantsMoreContent = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        publishedSelectedShow = dataSource.data[indexPath.section][indexPath.row]
    }
}

enum UnwrapError: Error {
   case unwrapError
}

extension Publisher {
    func unwrap<T>(
        orThrow error: @escaping @autoclosure () -> Failure
    ) -> Publishers.TryMap<Self, T> where Output == Optional<T> {
        tryMap { output in
            switch output {
            case .some(let value):
                return value
            case nil:
                throw error()
            }
        }
    }
}
