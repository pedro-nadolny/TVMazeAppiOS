import UIKit

extension UICollectionViewCell {
    static var identifier: String { .init(describing: self) }
}

public extension UICollectionView {
    func register(_ cellType: UICollectionViewCell.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.identifier)
    }
    
    func dequeue<T: UICollectionViewCell>(cellForRowAt indexPath: IndexPath) -> T {
        if let dequeuedCell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T {
            return dequeuedCell
        }
        
        fatalError("Something unexpeceted happened while dequeuing the cell \(T.self).")
    }
}

