//
//  HomeViewModel.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 13.08.2022.
//

import Foundation
import Combine

protocol HomeViewModelProtocol: AnyObject {
    var movieList: [MovieModel]? { get }
    var trendingMovies: [MovieModel]? { get }
    var trendingTvs: [MovieModel]? { get }
    var upcomingMovies: [MovieModel]? { get }
    var popularMovies: [MovieModel]? { get }
    var topRatedMovies: [MovieModel]? { get }
    func showAlert(title: String?, Message: String?)
    func getTrendingMovies()
    func getTrendingTvs()
    func getUpcomingMovies()
    func getPopularMovies()
    func getTopRated()
}

final class HomeViewModel {
    weak var movieListView: MovieListViewInterface?
    var networkService: NetworkServiceProtocol?
    var movieList: [MovieModel]?
    var trendingMovies: [MovieModel]?
    var trendingTvs: [MovieModel]?
    var upcomingMovies: [MovieModel]?
    var popularMovies: [MovieModel]?
    var topRatedMovies: [MovieModel]?
    
    private var cancellable = Set<AnyCancellable>()
    
    init(view: MovieListViewInterface? = nil, networkService: NetworkServiceProtocol? = nil) {
        self.movieListView = view
        self.networkService = networkService
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    
    func showAlert(title: String?, Message: String?) {
        
    }
        
    func getTrendingMovies() {
        networkService?.getTrendingMovies().sink(receiveCompletion: { [weak self] (completion) in
            switch completion {
            case .failure(let error):
                Logger.log(.error, "oops got an error \(error.localizedDescription)")
                self?.showAlert(title: "asda", Message: "asda")
            case .finished:
                Logger.log(.success, "fetch car list task has finished")
                self?.movieListView?.movieListFetched()
            }
        }, receiveValue: { [weak self] (response) in
            guard let result = response.results else { return }
            self?.trendingMovies = result
        }).store(in: &cancellable)
    }
    
    func getTrendingTvs() {
        networkService?.getTrendingTvs().sink(receiveCompletion: { [weak self] (completion) in
            switch completion {
            case .failure(let error):
                Logger.log(.error, "oops got an error \(error.localizedDescription)")
                self?.showAlert(title: "asda", Message: "asda")
            case .finished:
                Logger.log(.success, "fetch car list task has finished")
                self?.movieListView?.movieListFetched()
            }
        }, receiveValue: { [weak self] (response) in
            guard let result = response.results else { return }
            self?.trendingTvs = result
        }).store(in: &cancellable)
    }
    
    func getUpcomingMovies() {
        networkService?.getUpcomingMovies().sink(receiveCompletion: { [weak self] (completion) in
            switch completion {
            case .failure(let error):
                Logger.log(.error, "oops got an error \(error.localizedDescription)")
                self?.showAlert(title: "asda", Message: "asda")
            case .finished:
                Logger.log(.success, "fetch car list task has finished")
                self?.movieListView?.movieListFetched()
            }
        }, receiveValue: { [weak self] (response) in
            guard let result = response.results else { return }
            self?.upcomingMovies = result
        }).store(in: &cancellable)
    }
    
    func getPopularMovies() {
        networkService?.getPopularMovies().sink(receiveCompletion: { [weak self] (completion) in
            switch completion {
            case .failure(let error):
                Logger.log(.error, "oops got an error \(error.localizedDescription)")
                self?.showAlert(title: "asda", Message: "asda")
            case .finished:
                Logger.log(.success, "fetch car list task has finished")
                self?.movieListView?.movieListFetched()
            }
        }, receiveValue: { [weak self] (response) in
            guard let result = response.results else { return }
            self?.popularMovies = result
        }).store(in: &cancellable)
    }
    
    func getTopRated() {
        networkService?.getTopRated().sink(receiveCompletion: { [weak self] (completion) in
            switch completion {
            case .failure(let error):
                Logger.log(.error, "oops got an error \(error.localizedDescription)")
                self?.showAlert(title: "asda", Message: "asda")
            case .finished:
                Logger.log(.success, "fetch car list task has finished")
                self?.movieListView?.movieListFetched()
            }
        }, receiveValue: { [weak self] (response) in
            guard let result = response.results else { return }
            self?.topRatedMovies = result
        }).store(in: &cancellable)
    }
    
}
