//
//  SearchViewModel.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 25.08.2022.
//

import Foundation
import Combine

protocol SearchViewModelProtocol {
    var movies: [MovieModel]? { get }
    var querry: String? { get set }
    func getDiscoverMovies()
    func numberOfMoviesList() -> Int
    func getMovieObject(row: Int) -> MovieModel?
    func movieSelected(row: Int)
    func getSearchResult()
}

class SearchViewModel {
    var movies: [MovieModel]?
    var querry: String?
    var networkService: NetworkServiceProtocol?
    var view: SearchResultInterface?
    private var cancellebla = Set<AnyCancellable>()
    
    init(networkService: NetworkServiceProtocol? = nil, view: SearchResultInterface? = nil) {
        self.view = view
        self.networkService = networkService
    }
}

extension SearchViewModel: SearchViewModelProtocol {
    
    func getDiscoverMovies() {
        networkService?.getDiscoverMovies().sink(receiveCompletion: { [weak self] (completion) in
            switch completion {
            case .failure(let error):
                Logger.log(.error, "oopss something happened \(error.localizedDescription)")
            case .finished:
                Logger.log(.success, "Discover Movies fetched")
                self?.view?.getMoviesFetched()
            }
        }, receiveValue: { (movieResponse) in
            guard let movieList = movieResponse.results else { return }
            self.movies = movieList
        }).store(in: &cancellebla)
    }
    
    func getSearchResult() {
        networkService?.search(querry: querry ?? "").sink(receiveCompletion: { [weak self] (completion) in
            switch completion {
            case .failure(let error):
                Logger.log(.error, "Oppss something happened \(error.localizedDescription)")
            case .finished:
                Logger.log(.success, "Success")
                self?.view?.getMoviesFetched()
            }
        }, receiveValue: { (response) in
            guard let response = response.results else { return }
        }).store(in: &cancellebla)
    }
    
    func numberOfMoviesList() -> Int {
        movies?.count ?? 0
    }
    
    func getMovieObject(row: Int) -> MovieModel? {
        movies?[safeIndex: row]
    }
    
    func movieSelected(row: Int) {
        if let movies = getMovieObject(row: row) {
            Logger.log(.error, "MovieListModel-movieSelected, selected movie object is nil")
        }
        // navigate to movie page
    }
    
}
