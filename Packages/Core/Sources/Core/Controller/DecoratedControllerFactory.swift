import UIKit
import CoreInterface

final class DecoratedControllerFactory: DecoratedControllerFactoryProtocol {
    func makeDecoratedController(
        decorator: some ControllerDecorator
    ) -> UIViewController {
        DecoratableController(decorator: decorator)
    }
}
