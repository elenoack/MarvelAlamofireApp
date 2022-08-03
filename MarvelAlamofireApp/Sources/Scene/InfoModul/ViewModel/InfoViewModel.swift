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
    
    // MARK: - Private

    func fetchCharactersData(with name: String? = nil) {
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
                    print(error)
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
                    print(self.comics.value)
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
}
