//
//  NetworkService.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 3.08.2022.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func getMovies() -> AnyPublisher<MovieResponse, NetworkError>
}

