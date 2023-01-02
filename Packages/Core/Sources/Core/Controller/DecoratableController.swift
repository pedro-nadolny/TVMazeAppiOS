import UIKit
import CoreInterface

/// This controller is meant to be used via the injection of a ControllerDecorator to define it's life cycle methods.
/// Its intention is to minimalize the direct inheritance on UIViewController class, which when done each time increases the final size of the compiled App due to how subclassing works.
final class DecoratableController: UIViewController {
    private let decorator: ControllerDecorator
    
    /// - Parameters:
    ///     - decorator:  The decorator that implements de UIViewController lifecycle
    init(decorator: ControllerDecorator) {
        self.decorator = decorator
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        decorator.loadView(controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorator.viewDidLoad(controller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        decorator.viewWillAppear(animated, controller: self)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        decorator.viewWillLayoutSubviews(controller: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        decorator.viewDidLayoutSubviews(controller: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        decorator.viewDidAppear(animated, controller: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        decorator.viewWillDisappear(animated, controller: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        decorator.viewDidAppear(animated, controller: self)
    }
    
}
