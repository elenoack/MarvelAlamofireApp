//
//  InfoViewController.swift
//  MarvelAlamofireApp
//
//  Created by Elena Noack on 02.08.22.
//

import UIKit


class InfoViewController: UIViewController, UITableViewDelegate {
    // MARK: - Properties
    
    private var infoView: InfoView? {
        guard isViewLoaded else { return nil }
        return view as? InfoView
    }
    
    private let viewModel: InfoViewModel = .init()
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        view = InfoView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureView()
        subscribe()
    }
    
    // MARK: - Settings
    
    private func setupView() {
        guard let nameCharacter = navigationController?.navigationBar.topItem?.title
        else {
            return }
        viewModel.fetchCharactersData(with: nameCharacter)
    }
    
    func configureView() {
        infoView?.tableView.delegate = self
        infoView?.tableView.dataSource = self
    }
    
    private func setupImage() {
        infoView?.avatarView.image = viewModel.characters.value.first?.image?.largeImage
    }
    
    private func setupDescription() {
        var description: String = viewModel.characters.value.first?.description ?? Strings.descriptionDefault
        if description.isEmpty{
            description = Strings.descriptionDefault
        }
        infoView?.descriptionLabel.text = description
    }
    
    private func endSetting() {
        if self.viewModel.comics.value.isEmpty {
            self.infoView?.tableView.backgroundColor = .black
            
        }
        self.infoView?.backgroundView.isHidden = true
        self.infoView?.activityIndicator.stopAnimating()
    }
}

// MARK: - UITableViewDataSource

extension InfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.comics.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ComicsCell.reuseID, for: indexPath) as? ComicsCell
        else {
            return ComicsCell() }
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        let comicsLarge = self.viewModel.comics.value[indexPath.row].image?.largeImage
        let comics = self.viewModel.comics.value[indexPath.row].image?.portraitMedium
        let title = self.viewModel.characters.value.first?.comics?.items?[indexPath.row].name
        let description = self.viewModel.comics.value[indexPath.row].description
        cell.comicsView.image = comics
        cell.basicView.image = comicsLarge
        cell.titleLabel.text = title
        cell.descriptionLabel.text = description
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Metric.cellHeight
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                   section: Int) -> String? {
        
        return "List of comics:"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = UIColor.systemGray
        }
    }
}

// MARK: - Private

extension InfoViewController {
    
    private func showError() {
        let action = UIAlertAction(title: Strings.ok, style: .default, handler: nil)
        self.showAlert( message: self.viewModel.error.value.localizedDescription,
                        actions: [action])
    }
    
    private func restart(action: UIAlertAction) {
        setupView()
    }
}

// MARK: - Observing

extension InfoViewController {
    
    private func subscribe() {
        viewModel.viewState.observe(on: self) { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                self.infoView?.backgroundView.isHidden = false
                self.infoView?.activityIndicator.startAnimating()
            case .loaded:
                self.setupImage()
                self.setupDescription()
                self.endSetting()
                self.infoView?.tableView.reloadData()
            case .fail:
                self.showError()
            }
        }
    }
}

// MARK: - Constants

extension InfoViewController {
    
    enum Metric {
        static let cellHeight: CGFloat = 210
    }
    
    enum Strings {
        static let descriptionDefault: String = "Description is missing."
        static let ok: String = "OK"
    }
    
}
