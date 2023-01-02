import UIKit
import CoreInterface
import TVMazeServicesInterface
import LayoutExtensions

final class SeriesCell: UICollectionViewCell {
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private let titleContainer = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .label
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
        
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGroupedBackground
        return imageView
    }()
    
    private var imageRequestTask: URLSessionDataTask?

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewHierarchy(view: contentView)
        setConstraints(view: contentView)
        setProperties(view: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        imageRequestTask?.cancel()
        posterImageView.image = nil
        titleLabel.text = nil
    }
}

extension SeriesCell: ViewDecorator {
    func buildViewHierarchy(view: UIView) {
        view.addSubview(stackView)
        stackView.addArrangedSubviews(posterImageView, titleContainer)
        titleContainer.addSubview(titleLabel)
    }
    
    func setConstraints(view: UIView) {
        stackView.constraintToSuperview(leading: 0, top: 0, trailing: 0, bottom: 16)
        titleLabel.constraintToSuperview(leading: 8, top: 0, trailing: 8, bottom: 8)
    }
    
    func setProperties(view: UIView) {
        view.backgroundColor = .secondarySystemFill
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
    }
}

extension SeriesCell: ConfiguratableCell {
    func configure<Model>(with model: Model) {
        guard let model = model as? Show else { return }
        titleLabel.text = model.name
        
        guard let url = URL(string: model.image?.medium ?? "") else { return }
        
        imageRequestTask = URLSession.shared.dataTask(with: url) { [posterImageView] data, _, _ in
            guard let data else { return }
            DispatchQueue.main.async {
                
                UIView.transition(with: posterImageView,
                                  duration: 0.35,
                                  options: .transitionCrossDissolve) {
                    posterImageView.image = UIImage(data: data)
                }
            }
        }
        
        imageRequestTask?.resume()
    }
}
