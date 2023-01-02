import Foundation
import UIKit

public protocol ConfiguratableCell: UICollectionViewCell {
    func configure<Model>(with model: Model)
}

public final class CollectionDataSource<Model, Cell: ConfiguratableCell>: NSObject, UICollectionViewDataSource {
    public var data: [[Model]] = .init()
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        data.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data[section].count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: Cell = collectionView.dequeue(cellForRowAt: indexPath)
        cell.configure(with: data[indexPath.section][indexPath.row])
        return cell
    }
}
