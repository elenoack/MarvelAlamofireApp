//
//  ViewController.swift
//  MarvelAlamofireApp
//
//  Created by Elena Noack on 01.08.22.
//

import UIKit


class GalleryViewController: UIViewController, UICollectionViewDelegate, UISearchControllerDelegate {
    // MARK: - Properties
    
    private var galleryView: GalleryView? {
        guard isViewLoaded else { return nil }
        return view as? GalleryView
    }
    
    let viewModel: GalleryViewModel = .init()
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        view = GalleryView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupNavigationBar()
        configureSearchController()
        subscribe()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupGradient()
    }
    
    // MARK: - Settings
    
    private func setupNavigationBar() {
        navigationItem.searchController = galleryView?.searchController
        self.navigationController?.navigationBar.isTranslucent = false
        self.definesPresentationContext = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = Strings.ncTitle
    }
    
    private func configureView() {
        galleryView?.collectionView.delegate = self
        galleryView?.collectionView.dataSource = self
    }
    
    private func configureSearchController() {
        galleryView?.searchController.searchResultsUpdater = self
        galleryView?.searchController.delegate = self
    }
    
    private func setupGradient() {
        guard let galleryView = galleryView
        else {
            return
        }
        galleryView.gradient.frame = galleryView.gradientView.bounds
        galleryView.gradientView.layer.addSublayer(galleryView.gradient)
    }
}

// MARK: - UICollectionViewDataSource

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.characters.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.reuseID, for: indexPath) as? CustomCell
        else {
            return UICollectionViewCell() }
        
        let character = viewModel.characters.value[indexPath.row]
        cell.nameLabel.text = character.name
        cell.avatarView.image = character.image?.mediumImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = viewModel.characters.value[indexPath.row]
        viewModel.presentModalVC(self, characterName: character.name)
    }
}

// MARK: - UISearchResultsUpdating

extension GalleryViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text
        else {
            return }
        viewModel.fetchCharactersData(with: text)
    }
}

// MARK: - Private

extension GalleryViewController {
    
    private func showError() {
        let action = UIAlertAction(title: Strings.ok, style: .default, handler: nil)
        self.showAlert( message: self.viewModel.error.value.localizedDescription,
                        actions: [action])
    }
    
    private func restart(action: UIAlertAction) {
        viewModel.fetchCharactersData()
    }
}

// MARK: - Observing

extension GalleryViewController {
    
    private func subscribe() {
        viewModel.characters.observe(on: self) { [weak self] _ in
            guard let self = self else { return }
            self.galleryView?.collectionView.reloadData()
        }
        
        viewModel.viewState.observe(on: self) { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                self.galleryView?.backgroundView.isHidden = false
                self.galleryView?.activityIndicator.startAnimating()
            case .loaded:
                self.galleryView?.backgroundView.isHidden = true
                self.galleryView?.activityIndicator.stopAnimating()
            case .fail:
                self.showError()
            }
        }
    }
}

// MARK: - Constants

extension GalleryViewController {
    
    enum Strings {
        static let ncTitle: String = "MARVEL"
        static let ok: String = "OK"
    }
    
}



