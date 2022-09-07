//
//  NetworkServiceEndpoint.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 3.08.2022.
//

import Foundation
import Combine

public typealias Headers = [String: String]

fileprivate enum Constants {
    static let API_KEY = "e91439e7ba17b8aa0f34d3f239ee24cc"
    static let YoutubeAPI_KEY = "AIzaSyBvkERE3NbIyFcw0wDdstZMyGarOrQQzE4"
    static let YoutubebaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum NetworkServiceEndpoints {
    
    case getTrendingMovies
    case getTrendingTvs
    case getUpcomingMovies
    case getPopular
    case getTopRated
    case getDiscoverMovies
    case getSearchMovies
    case getMovie(query: String)
    
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
        case .getMovie(let query):
            guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return ""}
            return "\(Constants.YoutubebaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)"
        case .getTrendingMovies:
            return "\(baseUrl)/3/trending/movie/day?api_key=\(Constants.API_KEY)"
        case .getTrendingTvs:
            return "\(baseUrl)/3/trending/tv/day?api_key=\(Constants.API_KEY)"
        case .getUpcomingMovies:
            return "\(baseUrl)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1"
        case .getPopular:
            return "\(baseUrl)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1"
        case .getTopRated:
            return "\(baseUrl)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
        case .getDiscoverMovies:
            return "\(baseUrl)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
        case .getSearchMovies:
            return ""
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
    
    
