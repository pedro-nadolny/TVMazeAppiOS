import UIKit

public protocol ControllerDecorator {
    func loadView(controller: UIViewController)
    func viewDidLoad(controller: UIViewController)
    func viewDidAppear(_ animated: Bool, controller: UIViewController)
    func viewDidLayoutSubviews(controller: UIViewController)
    func viewWillAppear(_ animated: Bool, controller: UIViewController)
    func viewWillLayoutSubviews(controller: UIViewController)
    func viewWillDisappear(_ animated: Bool, controller: UIViewController)
    func viewDidDisappear(_ animated: Bool, controller: UIViewController)
}

public extension ControllerDecorator {
    func loadView(controller: UIViewController) {}
    func viewDidLoad(controller: UIViewController) {}
    func viewDidAppear(_ animated: Bool, controller: UIViewController) {}
    func viewDidLayoutSubviews(controller: UIViewController) {}
    func viewWillAppear(_ animated: Bool, controller: UIViewController) {}
    func viewWillLayoutSubviews(controller: UIViewController) {}
    func viewWillDisappear(_ animated: Bool, controller: UIViewController) {}
    func viewDidDisappear(_ animated: Bool, controller: UIViewController) {}
}
