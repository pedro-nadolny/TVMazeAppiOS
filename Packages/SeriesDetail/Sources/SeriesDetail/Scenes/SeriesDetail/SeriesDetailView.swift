import Foundation
import CoreInterface
import UIKit
import TVMazeServicesInterface
import LayoutExtensions
import CoreGraphics

protocol SeriesDetailViewOutput {

}

protocol SeriesDetailViewInput {
    func display(poster: UIImage)
}

typealias SeriesDetailViewProtocol = SeriesDetailViewInput & SeriesDetailViewOutput

final class SeriesDetailViewDecorator: NSObject {
    private let show: Show
    private var image: UIImage?
    
    init(show: Show) {
        self.show = show
    }

    private let layout: UICollectionLayoutListConfiguration = {
        var layout = UICollectionLayoutListConfiguration(appearance: .plain)
        layout.showsSeparators = false
        return layout
    }()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout.list(using: layout))
}

extension SeriesDetailViewDecorator: ViewDecorator {
    func buildViewHierarchy(view: UIView) {
        view.addSubview(collectionView)
    }
    
    func setConstraints(view: UIView) {
        collectionView.fillSuperview()
    }
    
    func setProperties(view: UIView) {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(SeriesDetailHeader.self)
        collectionView.dataSource = self
    }
}

extension SeriesDetailViewDecorator: SeriesDetailViewOutput {
    
}

extension SeriesDetailViewDecorator: SeriesDetailViewInput {
    func display(poster: UIImage) {
        image = poster
        collectionView.reloadSections(.init(integer: 0))
    }
}

extension SeriesDetailViewDecorator: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            return dequeueSeriesDetailHeader(collectionView, indexPath: indexPath)
        default:
            return .init(frame: .zero)
        }
    }
}

private extension SeriesDetailViewDecorator {
    func dequeueSeriesDetailHeader(_ collectionView: UICollectionView, indexPath: IndexPath) -> SeriesDetailHeader {
        let cell: SeriesDetailHeader = collectionView.dequeue(cellForRowAt: indexPath)
        cell.configure(show: show, and: image)
        return cell
    }
}
