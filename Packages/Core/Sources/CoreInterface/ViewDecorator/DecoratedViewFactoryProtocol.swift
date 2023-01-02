import UIKit

public protocol DecoratedViewFactoryProtocol {
    func makeDecoratedView(
        decorator: some ViewDecorator
    ) -> UIView
}
