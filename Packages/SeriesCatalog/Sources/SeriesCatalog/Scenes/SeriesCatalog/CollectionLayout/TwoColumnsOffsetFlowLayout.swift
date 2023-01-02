import UIKit

final class TwoColumnsFlowLayout: UICollectionViewFlowLayout {
    private let height: CGFloat
    
    init(height: CGFloat = 350) {
        self.height = height
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var attributes: [UICollectionViewLayoutAttributes] = []
    private var contentHeigt = CGFloat.zero
    
    override func prepare() {
        super.prepare()
        attributes.removeAll()
        
        guard let collectionView else { return }
         
        let insets = collectionView.contentInset
        let itemsWidth = collectionView.frame.width / 2 - 1.5 * minimumInteritemSpacing - insets.right - insets.left
        var yPosition = 0.0
        
        for section in 0..<collectionView.numberOfSections {
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                
                let columnIndex = item % 2
                let position: CGPoint
                
                if columnIndex == .zero {
                    position = .init(x: itemsWidth + insets.left + 2 * minimumInteritemSpacing, y: yPosition)
                } else {
                    position = .init(
                        x: minimumInteritemSpacing,
                        y: yPosition + height/2
                    )
                    
                    yPosition += height + minimumLineSpacing
                }
            
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attribute.frame = CGRect(
                    origin: position,
                    size: .init(width: itemsWidth, height: height)
                )
                
                attributes += [attribute]
            }
        }
    }
    
    override var collectionViewContentSize: CGSize {
        guard let collectionView else { return .zero }

        var totalNumberOfItems = 0
        for section in 0..<collectionView.numberOfSections {
            totalNumberOfItems += collectionView.numberOfItems(inSection: section)
        }
        
        let finalAttributedIndex: Int
        if totalNumberOfItems % 2 == 0 {
            finalAttributedIndex = totalNumberOfItems - 1
        } else {
            finalAttributedIndex = totalNumberOfItems - 2
        }
        
        guard attributes.indices.contains(finalAttributedIndex) else {
            return .zero
        }
        
        return .init(
            width: collectionView.frame.width,
            height: attributes[finalAttributedIndex].frame.maxY
        )
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        super.layoutAttributesForItem(at: indexPath)
        return attributes[indexPath.row]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        super.layoutAttributesForElements(in: rect)
        return attributes.filter { $0.frame.intersects(rect) }
    }
}
