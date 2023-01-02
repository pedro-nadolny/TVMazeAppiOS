import UIKit

public protocol DecoratedControllerFactoryProtocol {
    func makeDecoratedController(
        decorator: some ControllerDecorator
    ) -> UIViewController
}
