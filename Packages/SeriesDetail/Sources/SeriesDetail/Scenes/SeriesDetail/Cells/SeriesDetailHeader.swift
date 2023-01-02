import UIKit
import CoreInterface
import LayoutExtensions
import TVMazeServicesInterface

final class SeriesDetailHeader: UICollectionViewCell {
    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.backgroundColor = .clear
        return stack
    }()
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.backgroundColor = .clear
        
        stack.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.alpha = 0
        
        return imageView
    }()
    
    private let inAirPeriodLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private let genresLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let summaryText: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewHierarchy(view: contentView)
        setConstraints(view: contentView)
        setProperties(view: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(show: Show, and poster: UIImage?) {
        if show.image != nil, poster == nil { return }
        
        if show.image == nil {
            imageView.isHidden = true
        }
        
        if let poster {
            handlePoster(poster)
        }
        
        handleAirPeriod(show)
        handleGenres(show)

        if let sumarry = show.summary {
            handleSummary(sumarry)
        }
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        guard imageView.bounds != .zero, imageView.image != nil else { return }
        let gradient = CAGradientLayer()
        gradient.frame = imageView.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0, 0.95, 1]
        
        imageView.layer.mask = gradient
    }
}

extension SeriesDetailHeader: ViewDecorator {
    func buildViewHierarchy(view: UIView) {
        view.addSubview(mainStack)
        mainStack.addArrangedSubviews(
            imageView,
            contentStack
        )
        
        contentStack.addArrangedSubviews(
            inAirPeriodLabel,
            genresLabel,
            summaryText
        )
    }
    
    func setConstraints(view: UIView) {
        mainStack.fillSuperview()
        imageView.constraintTo(height: .init(constant: 500))
    }
}

private extension SeriesDetailHeader {
    func handlePoster(_ poster: UIImage) {
        imageView.image = poster
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) { [self] in
            self.imageView.alpha = 1
        }
    }
    
    func handleSummary(_ sumarry: String) {
        let data = sumarry.data(using: .utf16, allowLossyConversion: false) ?? Data()
        
        if let attributedString = try? NSMutableAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil) {
            var attributes = attributedString.attributes(at: 0, effectiveRange: nil)
            attributes[.font] = UIFont.systemFont(ofSize: 16)
            attributes[.foregroundColor] = UIColor.label
            attributes[.backgroundColor] = UIColor.clear
            attributedString.setAttributes(attributes, range: NSRange(location: 0, length: attributedString.length))
            
            summaryText.attributedText = attributedString
        }
    }
    
    func handleAirPeriod(_ show: Show) {
        guard let endedDate = try? Date(show.ended ?? "", strategy: .iso8601.year().month().day()),
              let premieredDate = try? Date(show.premiered ?? "", strategy: .iso8601.year().month().day())
        else { return }
            
        
        let formatStyle = Date.FormatStyle
            .dateTime
            .month(.abbreviated)
            .year()
        
        let endedString = endedDate.formatted(formatStyle)
        
        let premieredString = premieredDate.formatted(formatStyle)
        
        inAirPeriodLabel.text = "\(premieredString) up to \(endedString)"
    }
    
    func handleGenres(_ show: Show) {
        var genres = show.genres
        if genres.isEmpty { return }
            
        let first = genres.removeFirst()
        genresLabel.text = genres
            .reduce(first) { result, value in result + " • " + value }
            .uppercased()
    }
}
