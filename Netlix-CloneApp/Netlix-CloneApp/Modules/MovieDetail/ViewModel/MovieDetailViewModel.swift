//
//  HomeViewModel.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 10.08.2022.
//

import Foundation

protocol MovieDetailViewModelProtocol {
    func prepareUI()
}

final class MovieDetailViewModel {
 
    weak var view: MovieDetailViewControllerInterface?
    private var movieObject: MovieModel?
    private var videoObject: VideoElementsModel?
    
    init(view: MovieDetailViewControllerInterface?, movieObject: MovieModel?, videoObject: VideoElementsModel?) {
        self.view = view
        self.movieObject = movieObject
        self.videoObject = videoObject
    }
}

extension MovieDetailViewModel: MovieDetailViewModelProtocol {
    func prepareUI() {
        guard let movieObject = movieObject, let videoObject = videoObject else {
            Logger.log(.error, "Car Object not handled on Detail page")
            return
        }
        view?.updateUI(with: movieObject, with: videoObject)
    }
}
