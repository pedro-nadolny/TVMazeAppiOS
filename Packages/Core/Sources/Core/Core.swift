import Foundation
import UIKit
import CoreInterface

public enum Core {
    public static let decoratedControllerFactory: DecoratedControllerFactoryProtocol = DecoratedControllerFactory()
    public static let decoratedViewFactory: DecoratedViewFactoryProtocol = DecoratedViewFactory()
}
