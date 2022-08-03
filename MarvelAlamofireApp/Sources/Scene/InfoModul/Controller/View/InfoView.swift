//
//  InfoView.swift
//  MarvelAlamofireApp
//
//  Created by Elena Noack on 02.08.22.
//

import UIKit


class InfoView: UIView {
    // MARK: - Views
    
    lazy var avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Metric.radius
        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return imageView
    }()
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: Metric.textFontBold, weight: .bold)
        label.textColor = UIColor.white
        label.text = Strings.headerText
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: Metric.textFontRegular, weight: .regular)
        label.textColor = UIColor.white
        label.numberOfLines = .zero
        label.sizeToFit()
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero)
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = Metric.radius
        tableView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        tableView.separatorStyle = .none
        tableView.register(ComicsCell.self, forCellReuseIdentifier: ComicsCell.reuseID)
        return tableView
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.isHidden = false
        return view
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = .white
        view.hidesWhenStopped = true
        view.startAnimating()
        return view
    }()
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .black
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        addSubviewsForAutoLayout([avatarView,
                                  headerLabel,
                                  descriptionLabel,
                                  tableView,
                                  backgroundView,
                                  activityIndicator])
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            avatarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            avatarView.heightAnchor.constraint(equalToConstant: Metric.imageHeight),
            
            headerLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: Metric.indent),
            headerLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: Metric.indentText),
            descriptionLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: - Constants

extension InfoView {
    
    enum Metric {
        static let radius: CGFloat = 30
        static let textFontBold: CGFloat = 20
        static let textFontRegular: CGFloat = 16
        static let imageHeight: CGFloat = 200
        static let indent: CGFloat = 12
        static let indentText: CGFloat = 10
    }
    
    enum Strings {
        static let headerText: String = "LaunchListCell"
    }
}
