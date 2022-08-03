//
//  GalleryView.swift
//  MarvelCharactersApp
//
//  Created by Elena Noack on 01.08.22.
//

import UIKit


class GalleryView: UIView {
    // MARK: - Properties
    
    weak var viewController: GalleryViewController?
    
    // MARK: - Views
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Strings.placeholder
        searchController.searchBar.autocapitalizationType = .allCharacters
        return searchController
    }()
    
    let layout: UICollectionViewCompositionalLayout = {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(Metric.cellWidth),
                heightDimension: .fractionalHeight(Metric.cellHeight))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: Metric.indent,
                                                         leading: Metric.smallIndent,
                                                         bottom: Metric.indent,
                                                         trailing: Metric.smallIndent)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(Metric.cellHeight),
                heightDimension: .fractionalWidth(Metric.cellWidth))
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(
                top: .zero,
                leading: Metric.smallIndent,
                bottom: .zero,
                trailing: Metric.smallIndent)
            return section
        }
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: (layout))
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.reuseID)
        collectionView.backgroundColor = .white
        collectionView.layer.cornerRadius = Metric.radius
        collectionView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return collectionView
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
        addSubviewsForAutoLayout([collectionView,
                                  backgroundView,
                                  activityIndicator])
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
        ])
    }
}

// MARK: - Constants

extension GalleryView {
    
    enum Metric {
        static let radius: CGFloat = 30
        static let smallIndent: CGFloat = 8
        static let indent: CGFloat = 12
        static let cellWidth: CGFloat = 1/2
        static let cellHeight: CGFloat = 1
    }
    
    enum Strings {
        static let placeholder: String = "Enter A Marvel Character"
    }
    
}
