//
//  NetworkService.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 3.08.2022.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func getTrendingMovies() -> AnyPublisher<MovieResponse, NetworkError>
    func getTrendingTvs() -> AnyPublisher<MovieResponse, NetworkError>
    func getUpcomingMovies() -> AnyPublisher<MovieResponse, NetworkError>
    func getPopularMovies() -> AnyPublisher<MovieResponse, NetworkError>
    func getTopRated() -> AnyPublisher<MovieResponse, NetworkError>
    func getDiscoverMovies() -> AnyPublisher<MovieResponse, NetworkError>
    func search(querry: String) -> AnyPublisher<MovieResponse, NetworkError>
    func getMovie(with titleName: String) -> AnyPublisher<YoutubeSearchResponse, NetworkError>
}

class NetworkService: NetworkServiceProtocol {
 
    private var networkRequest: Requestable
    private var environment: Environment = .development
    
    init(networkRequest: Requestable, environment: Environment) {
        self.networkRequest = networkRequest
        self.environment = environment
    }
    
    func getTrendingMovies() -> AnyPublisher<MovieResponse, NetworkError> {
        let endpoint = NetworkServiceEndpoints.getTrendingMovies
        let request = endpoint.createRequest(environment: environment)
        return self.networkRequest.request(request)
    }
    
    func getTrendingTvs() -> AnyPublisher<MovieResponse, NetworkError> {
        let endpoint = NetworkServiceEndpoints.getTrendingTvs
        let request = endpoint.createRequest(environment: environment)
        return self.networkRequest.request(request)
    }
    
    func getUpcomingMovies() -> AnyPublisher<MovieResponse, NetworkError> {
        let endpoint = NetworkServiceEndpoints.getUpcomingMovies
        let request = endpoint.createRequest(environment: environment)
        return self.networkRequest.request(request)
    }
    
    func getPopularMovies() -> AnyPublisher<MovieResponse, NetworkError> {
        let endpoint = NetworkServiceEndpoints.getPopular
        let request = endpoint.createRequest(environment: environment)
        return self.networkRequest.request(request)
    }
    
    func getTopRated() -> AnyPublisher<MovieResponse, NetworkError> {
        let endpoint = NetworkServiceEndpoints.getTopRated
        let request = endpoint.createRequest(environment: environment)
        return self.networkRequest.request(request)
    }
    
    func getDiscoverMovies() -> AnyPublisher<MovieResponse, NetworkError> {
        let endpoint = NetworkServiceEndpoints.getDiscoverMovies
        let request = endpoint.createRequest(environment: environment)
        return self.networkRequest.request(request)
    }
    
    func search(querry: String) -> AnyPublisher<MovieResponse, NetworkError> {
        let endpoint = NetworkServiceEndpoints.getSearchMovies
        let request = endpoint.createRequest(environment: environment)
        return self.networkRequest.request(request)
    }
    
    func getMovie(with titleName: String) -> AnyPublisher<YoutubeSearchResponse, NetworkError> {
        let endpoint = NetworkServiceEndpoints.getMovie(query: titleName)
        let request = endpoint.createRequest(environment: environment)
        return self.networkRequest.request(request)
    }
    
}
