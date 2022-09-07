//
//  TitleViewModel.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 9.08.2022.
//

import Foundation
import Combine

protocol UpcomingMovieViewModelProtocol: AnyObject {
    var upcomingMovies: [MovieModel]? { get }
    func getUpcomingMovies()
    func numberOfUpcomingMovie() -> Int
    func getUpcomingMovieObject(row: Int) -> MovieModel?
    func upcomingMovieSelected(row: Int)
}

class UpcomingMovieViewModel {
    var upcomingMovies: [MovieModel]?
    var networkService: NetworkServiceProtocol?
    private var cancellable = Set<AnyCancellable>()
    weak var upcomingMoviesInterface: UpcomingMoviesFetched?
    
    init(view: UpcomingMoviesFetched? = nil, networkService: NetworkServiceProtocol? = nil) {
        self.upcomingMoviesInterface = view
        self.networkService = networkService
    }
}

extension UpcomingMovieViewModel: UpcomingMovieViewModelProtocol {

    func getUpcomingMovies() {
        networkService?.getUpcomingMovies().sink(receiveCompletion: { [weak self] (completion) in
            switch completion {
            case .failure(let error):
                Logger.log(.error, "oops got an error : \(error.localizedDescription)")
            case .finished:
                Logger.log(.success, "fetch upcoming movie list task has finished")
                self?.upcomingMoviesInterface?.upcomingMoviesFetched()
            }
        }, receiveValue: { [weak self] (response) in
            guard let movies = response.results else { return }
            self?.upcomingMovies = movies
        }).store(in: &cancellable)
    }
    
    func numberOfUpcomingMovie() -> Int {
        upcomingMovies?.count ?? 0
    }
    
    func getUpcomingMovieObject(row: Int) -> MovieModel? {
        upcomingMovies?[safeIndex: row]
    }
    
    func upcomingMovieSelected(row: Int) {
        guard let selectedMovies = getUpcomingMovieObject(row: row) else {
            Logger.log(.error, "MovieListModel-movieSelected, selected movie object is nil")
            return
        }
    }
    
}
