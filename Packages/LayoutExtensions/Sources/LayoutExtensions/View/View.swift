import UIKit

public extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach(addSubview(_:))
    }
    
    func addSubviews(_ views: UIView...) {
        addSubviews(views)
    }
}
