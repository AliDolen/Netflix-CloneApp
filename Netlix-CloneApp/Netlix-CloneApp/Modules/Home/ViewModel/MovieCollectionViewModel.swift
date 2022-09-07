//
//  MovieCollectionViewModel.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 1.09.2022.
//

import Foundation
import Combine

protocol MovieCollectionViewModelProtocol {
    var movieList: [MovieModel]? { get set }
    var videoElement: [VideoElementsModel]? { get }
    func getMovies(title: String)
    func downloadTitleAt(indexPath: IndexPath)
    func numberOfMovieList() -> Int
    func getMovieObject(row: Int) -> MovieModel?
    func getSelectedMovie(row: Int)
    func getVideoObject(row: Int) -> VideoElementsModel?
}

class MovieCollectionViewModel {
    var movieList: [MovieModel]?
    var videoElement: [VideoElementsModel]?
    var networkService: NetworkServiceProtocol?
    private var cancellable = Set<AnyCancellable>()
    
    init(networkService: NetworkServiceProtocol? = nil) {
        self.networkService = networkService
    }
}

extension MovieCollectionViewModel: MovieCollectionViewModelProtocol {
    
    func getMovies(title: String) {
        networkService?.getMovie(with: title).sink(receiveCompletion: { [weak self] (completion) in
            switch completion {
            case .failure(let error):
                Logger.log(.error, "oops got an error \(error.localizedDescription)")
                self?.showAlert(title: "asda", message: "asda")
            case .finished:
                Logger.log(.success, "fetch car list task has finished")
            }
        }, receiveValue: { [weak self] (response) in
            self?.videoElement = response.items
        }).store(in: &cancellable)
    }
    
    func downloadTitleAt(indexPath: IndexPath) {
        guard let movies = movieList else { return }
        DataPersistentManager.shared.downloadTitleWith(model: movies[indexPath.row]) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: Notification.Name("Downloaded"), object: nil)
            case .failure(let error):
                Logger.log(.error, "Title couldnt downloaded \(error.localizedDescription)")
            }
        }
    }
    
    func numberOfMovieList() -> Int {
        movieList?.count ?? 0
    }
    
    func getMovieObject(row: Int) -> MovieModel? {
        movieList?[safeIndex: row]
    }
    
    func getVideoObject(row: Int) -> VideoElementsModel? {
        videoElement?[safeIndex: row]
    }
    
    func getSelectedMovie(row: Int) {
        guard let movieObject = getMovieObject(row: row), let videoObject = getVideoObject(row: row) else {
            Logger.log(.error, "Ooops Something happened")
            return
        }
        navigateToMovieDetail(movieObject: movieObject, videoObject: videoObject)
    }
    
    func navigateToMovieDetail(movieObject: MovieModel, videoObject: VideoElementsModel) {
        Router.navigate(to: .movieDetail(movieobject: movieObject, videoObject: videoObject))
    }
    
    func showAlert(title: String, message: String) {
        
    }
    
}
