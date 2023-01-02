import Foundation
import UIKit
import Combine
import TVMazeServicesInterface

protocol SeriesDetailViewModelInput {
    func loadContent()
}

protocol SeriesDetailViewModelOutput {
    var poster: AnyPublisher<UIImage, Never> { get }
}

typealias SeriesDetailViewModelProtocol = SeriesDetailViewModelInput & SeriesDetailViewModelOutput

final class SeriesDetailViewModel {
    typealias Dependencies = Void
    private let dependencies: Dependencies
    
    private let show: Show
    
    @Published private var publishedPoster: UIImage? = nil
    
    init(dependencies: Dependencies = (), show: Show) {
        self.dependencies = dependencies
        self.show = show
    }
}

extension SeriesDetailViewModel: SeriesDetailViewModelInput {
    func loadContent() {
        guard let imageUrl = URL(string: show.image?.original ?? "") else { return }
        
        let request = URLRequest(url: imageUrl)
        URLSession.shared.dataTask(with: request) { [weak self] data, _, _ in
            guard let self, let data else { return }
            self.publishedPoster = UIImage(data: data)
        }.resume()
    }
}

extension SeriesDetailViewModel: SeriesDetailViewModelOutput {
    var poster: AnyPublisher<UIImage, Never> { $publishedPoster
        .compactMap { $0 }
        .eraseToAnyPublisher()
    }
}
