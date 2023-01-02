import UIKit
import CoreInterface

final class DecoratedViewFactory: DecoratedViewFactoryProtocol {
    func makeDecoratedView(
        decorator: some ViewDecorator
    ) -> UIView {
        DecoratableView(decorator: decorator)
    }
}
