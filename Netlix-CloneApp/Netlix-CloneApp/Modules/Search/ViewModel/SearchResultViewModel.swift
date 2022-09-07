//
//  SearchResultViewModel.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 27.08.2022.
//

import Foundation

protocol SearchResultViewModelProtocol {
    func prepareUI()
}

class SearchResultViewModel {
    
    weak var view: SearchResultViewControllerDelegate?
    private var movieObject: MovieModel?
    
    init(view: SearchResultViewControllerDelegate?, movieObject: MovieModel?) {
        self.view = view
        self.movieObject = movieObject
    }

}

extension SearchResultViewModel: SearchResultViewModelProtocol {
    func prepareUI() {
        guard let movieObject = movieObject else {
            Logger.log(.error, "movie object is not handled")
            return
        }
        view?.searchResultItemTapped(with: movieObject)
    }
}
