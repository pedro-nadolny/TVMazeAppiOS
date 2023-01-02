import UIKit
import CoreInterface

public final class DecoratableView: UIView {
    private let decorator: ViewDecorator
    
    public init(decorator: ViewDecorator) {
        self.decorator = decorator
        super.init(frame: .zero)
        decorator.buildViewHierarchy(view: self)
        decorator.setConstraints(view: self)
        decorator.setProperties(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
