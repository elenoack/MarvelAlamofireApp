//
//  CustomCell.swift
//  MarvelAlamofireApp
//
//  Created by Elena Noack on 01.08.22.
//

import UIKit


class CustomCell: UICollectionViewCell {
    // MARK: - Properties
    
    static let reuseID = Strings.reuseID
    
    // MARK: - Views
    
    lazy var avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Metric.radius
        return imageView
    }()
    
    lazy var shadowView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Metric.radius
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = Metric.shadowOpacity
        view.layer.shadowOffset = CGSize(width: Metric.shadowOffsetWidth, height: Metric.shadowOffsetHeight)
        view.layer.shadowRadius = Metric.shadowRadius
        return view
    }()
    
    lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blurEffect)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.clipsToBounds = true
        view.layer.cornerRadius = Metric.radius
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: Metric.textFontBold, weight: .bold)
        label.textColor = UIColor.white
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = Metric.numberOfLines
        label.setContentCompressionResistancePriority(
            .defaultHigh,
            for: .horizontal)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configuration

extension CustomCell {
    
    func configure() {
        contentView.addSubviewsForAutoLayout([
            shadowView,
            avatarView,
            blurView,
            nameLabel])
        
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: topAnchor),
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            avatarView.topAnchor.constraint(equalTo: topAnchor),
            avatarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatarView.bottomAnchor.constraint(equalTo: bottomAnchor),
            avatarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            blurView.leadingAnchor.constraint(equalTo: avatarView.leadingAnchor),
            blurView.bottomAnchor.constraint(equalTo: avatarView.bottomAnchor),
            blurView.trailingAnchor.constraint(equalTo: avatarView.trailingAnchor),
            blurView.heightAnchor.constraint(equalToConstant: Metric.blurViewHeight),
            
            nameLabel.centerXAnchor.constraint(equalTo: blurView.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: blurView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: Metric.indent),
            nameLabel.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -Metric.indent),
        ])
    }
}

// MARK: - Constants

extension CustomCell {
    
    enum Metric {
        static let radius: CGFloat = 30
        static let shadowOpacity: Float = 2
        static let shadowOffsetWidth: CGFloat = 4
        static let shadowOffsetHeight: CGFloat = 4
        static let textFontBold: CGFloat = 16
        static let shadowRadius: CGFloat = 4.0
        static let numberOfLines: Int = 2
        static let blurViewHeight: CGFloat = 40
        static let indent: CGFloat = 8
    }
    
    enum Strings {
        static let reuseID: String = "CustomCell"
    }
    
}
