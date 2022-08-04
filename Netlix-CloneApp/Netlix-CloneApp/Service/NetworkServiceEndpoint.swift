//
//  NetworkServiceEndpoint.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 3.08.2022.
//

import Foundation
import Combine

public typealias Headers = [String: String]

enum NetworkServiceEndpoints {
    
    case getTrendingMovies
    case getTrendingTvs
    case getUpcomingMovies
    case getPopular
    case getTopRated
    case getDiscoverMovies
    case getSearchMovies
    case getMovie
    
    var requestTimeOut: Int {
        return 20
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getTrendingMovies:
            return .GET
        case .getTrendingTvs:
            return .GET
        case .getUpcomingMovies:
            return .GET
        case .getPopular:
            return .GET
        case .getTopRated:
            return .GET
        case .getDiscoverMovies:
            return .GET
        case .getSearchMovies:
            return .GET
        case .getMovie:
            return .GET
        }
    }
    
    func createRequest(environment: Environment) -> NetworkRequest {
        var headers: Headers = [:]
        headers["Content-Type"] = "application/json"
        return NetworkRequest(url: getUrl(from: .development), headers: headers, reqBody: requestBody, httpMethod: httpMethod)
    }
    
    var requestBody: Encodable? {
        switch self {
        default:
            return nil
        }
    }
    
    func getUrl(from environment: Environment ) -> String {
        let baseUrl = environment.networkServiceEnvironment
        switch self {
        case .getMovie:
            return baseUrl
        case .getTrendingMovies:
            return baseUrl
        case .getTrendingTvs:
            return baseUrl
        case .getUpcomingMovies:
            return baseUrl
        case .getPopular:
            return baseUrl
        case .getTopRated:
            return baseUrl
        case .getDiscoverMovies:
            return baseUrl
        case .getSearchMovies:
            return baseUrl
        }
        
    }
}
    public enum Environment: String, CaseIterable {
        case development
        case production
    }
    
    extension Environment {
        var networkServiceEnvironment: String {
            switch self {
            case .development:
                return "https://api.themoviedb.org"
            case .production:
                return ""
            
            }
        }
    }
    
    
