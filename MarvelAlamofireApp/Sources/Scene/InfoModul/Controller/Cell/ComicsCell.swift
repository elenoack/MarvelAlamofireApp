//
//  ComicsCell.swift
//  MarvelCharactersApp
//
//  Created by Elena Noack on 03.08.22.
//

import UIKit


class ComicsCell: UITableViewCell {
    // MARK: - Properties
    
    static let reuseID = Strings.reuseID
    
    // MARK: - Views
    
    lazy var basicView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Metric.radius
        return imageView
    }()
    
    lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blurEffect)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.clipsToBounds = true
        view.layer.cornerRadius = Metric.radius
        return view
    }()
    
    lazy var comicsView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Metric.smallRadius
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: Metric.textFontBold, weight: .bold)
        label.textColor = UIColor.white
        label.numberOfLines = .zero
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: Metric.textFontRegular, weight: .regular)
        label.textColor = UIColor.white
        label.numberOfLines = .zero
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = Metric.minimumScaleFactor
        return label
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configuration

extension ComicsCell {
    
    private func configure() {
        contentView.addSubviewsForAutoLayout([
            basicView,
            blurView,
            comicsView,
            titleLabel,
            descriptionLabel])
        
        NSLayoutConstraint.activate([
            basicView.topAnchor.constraint(equalTo: topAnchor, constant: Metric.basicIndent),
            basicView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metric.basicIndent),
            basicView.bottomAnchor.constraint(equalTo: bottomAnchor),
            basicView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metric.basicIndent),
            
            blurView.topAnchor.constraint(equalTo: basicView.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: basicView.leadingAnchor),
            blurView.bottomAnchor.constraint(equalTo: basicView.bottomAnchor),
            blurView.trailingAnchor.constraint(equalTo: basicView.trailingAnchor),
            
            comicsView.topAnchor.constraint(equalTo: blurView.topAnchor, constant: Metric.indent),
            comicsView.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: Metric.indent),
            comicsView.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -Metric.indent),
            comicsView.widthAnchor.constraint(equalToConstant: Metric.comicsImageHeight),
            
            titleLabel.topAnchor.constraint(equalTo: blurView.topAnchor, constant: Metric.indent),
            titleLabel.leadingAnchor.constraint(equalTo: comicsView.trailingAnchor, constant: Metric.indent),
            titleLabel.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -Metric.indent),
            titleLabel.heightAnchor.constraint(equalToConstant: Metric.textHeight),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metric.textIndent),
            descriptionLabel.leadingAnchor.constraint(equalTo: comicsView.trailingAnchor, constant: Metric.indent),
            descriptionLabel.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -Metric.indent),
            descriptionLabel.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -Metric.indent),
        ])
    }
}

// MARK: - Constants

extension ComicsCell {
    
    enum Metric {
        static let radius: CGFloat = 30
        static let smallRadius: CGFloat = 16
        static let textFontBold: CGFloat = 16
        static let textFontRegular: CGFloat = 15
        static let minimumScaleFactor: CGFloat = 0.2
        static let indent: CGFloat = 18
        static let basicIndent: CGFloat = 12
        static let comicsImageHeight: CGFloat = 110
        static let textHeight: CGFloat = 36
        static let textIndent: CGFloat = 4
    }
    
    enum Strings {
        static let reuseID: String = "ComicsCell"
    }
    
}






