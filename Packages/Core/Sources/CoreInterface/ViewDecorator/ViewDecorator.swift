import UIKit

public protocol ViewDecorator {
    func setProperties(view: UIView)
    func setConstraints(view: UIView)
    func buildViewHierarchy(view: UIView)
}

public extension ViewDecorator {
    func setProperties(view: UIView) {}
    func setConstraints(view: UIView) {}
    func buildViewHierarchy(view: UIView) {}
}
