import UIKit
import CoreInterface
import Combine

final class SeriesDetailControllerDecorator: ControllerDecorator {
    private let router: SeriesDetailRouterProtocol
    private let viewOutput: SeriesDetailViewOutput
    private let viewInput: SeriesDetailViewInput
    private let view: UIView
    private let viewModelInput: SeriesDetailViewModelInput
    private let viewModelOutput: SeriesDetailViewModelOutput
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        viewModel: SeriesDetailViewModelProtocol,
        router: SeriesDetailRouterProtocol,
        viewProtocol: SeriesDetailViewProtocol,
        view: UIView
    ) {
        self.viewModelInput = viewModel
        self.viewModelOutput = viewModel
        self.viewOutput = viewProtocol
        self.viewInput = viewProtocol
        self.router = router
        self.view = view
        makeBindings()
    }
    
    func loadView(controller: UIViewController) {
        controller.view = view
    }
    
    func viewDidLoad(controller: UIViewController) {
        controller.navigationItem.largeTitleDisplayMode = .always
        viewModelInput.loadContent()
    }
}

private extension SeriesDetailControllerDecorator {
    func makeBindings() {
        viewModelOutput
            .poster
            .receive(on: RunLoop.main)
            .sink(receiveValue: viewInput.display(poster: ))
            .store(in: &cancellables)
    }
}
