//
//  InfoViewModel.swift
//  MarvelAlamofireApp
//
//  Created by Elena Noack on 03.08.22.
//

import Foundation
import UIKit


class InfoViewModel: NSObject {
    // MARK: - Properties
    
    var characters: Observable<[Character]> = Observable([])
    let networkService: NetworkService = .init()
    var viewState: Observable<ViewState> = Observable(.loading)
    var comics: Observable<[Character]> = Observable([])
    var error: Observable<NetworkError> = Observable(.serverError)
    
    // MARK: - Private

    func fetchCharactersData(with name: String? = nil) {
        self.viewState.value = .loading
        networkService.fetchData(with: name) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case let .success(result):
                    self.characters.value = result
                    guard let idCharacter = self.characters.value.first?.id else {
                        return }
                    self.fetchComicsData(with: String(idCharacter))
                case let .failure(error):
                    self.error.value = error
                    self.viewState.value = .fail
                }
            }
        }
    }
    
    private func fetchComicsData(with id: String) {
        networkService.fetchComicsData(with: id) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case let .success(result):
                    self.comics.value = result
                    self.viewState.value = .loaded
                case let .failure(error):
                    self.error.value = error
                    self.viewState.value = .fail
                }
            }
        }
    }
    
}
