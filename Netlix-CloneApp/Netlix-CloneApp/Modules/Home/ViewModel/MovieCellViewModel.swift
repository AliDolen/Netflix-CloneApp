//
//  MovieCellViewModel.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 4.09.2022.
//

import Foundation

protocol MovieCellViewModelProtocol {
    func prepareUI()
}

final class MovieCellViewModel {
 
    weak var view: MovieCollectionCellInterface?
    private var movieObject: MovieModel?
    
    init(view: MovieCollectionCellInterface?, movieObject: MovieModel?) {
        self.view = view
        self.movieObject = movieObject
    }
}

extension MovieCellViewModel: MovieDetailViewModelProtocol {
    func prepareUI() {
        guard let movieObject = movieObject else {
            Logger.log(.error, "Car Object not handled on Detail page")
            return
        }
        view?.updateUI(with: movieObject)
    }
}
