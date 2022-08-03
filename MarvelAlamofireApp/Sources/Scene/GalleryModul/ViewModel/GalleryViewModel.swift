//
//  GalleryViewModel.swift
//  MarvelAlamofireApp
//
//  Created by Elena Noack on 02.08.22.
//

import Foundation
import UIKit
// MARK: - ViewState

enum ViewState {
    case loading
    case loaded
    case fail
}

class GalleryViewModel: NSObject {
    // MARK: - Properties
    
    var characters: Observable<[Character]> = Observable([])
    private let networkService: NetworkService = .init()
    var viewState: Observable<ViewState> = Observable(.loading)
    var error: Observable<NetworkError> = Observable(.serverError)
    
    // MARK: - Initialization
    
    override init() {
        super .init()
        fetchCharactersData()
    }
    
    // MARK: - Settings
    
    func fetchCharactersData(with name: String? = nil) {
        self.viewState.value = .loading
        networkService.fetchData(with: name) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case let .success(result):
                    self.characters.value = result
                    self.viewState.value = .loaded
                case let .failure(error):
                    self.error.value = error
                    self.viewState.value = .fail
                }
            }
        }
    }
    
    func presentModalVC(_ vc: UIViewController, characterName: String?) {
        let modalVC = InfoViewController()
        let navController = UINavigationController(rootViewController: modalVC)
        navController.navigationBar.topItem?.title = characterName
        vc.navigationController?.present(navController, animated: true)
    }
    
    func addCharacters() {
        NetworkService.limitCount += 1
        //        networkService.parameters["limit"] = "\(20)"
        networkService.parameters["offset"] = "\( NetworkService.limitCount)"
        fetchCharactersData()
    }
}



