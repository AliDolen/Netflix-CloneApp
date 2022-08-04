//
//  APICaller.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 2.08.2022.
//

import Foundation
import Combine

protocol Requestable {
    var requestTimeOut: Float { get }
    func request<T: Codable>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError>
}

class NetworkManager: Requestable {
    var requestTimeOut: Float = 30
    
    func request<T>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError> where T : Decodable, T : Encodable {
        let timeInterval = URLSessionConfiguration.default
        timeInterval.timeoutIntervalForRequest = TimeInterval(req.requestTimeOut ?? requestTimeOut)
        
        guard let url = URL(string: req.url) else {
            return AnyPublisher(Fail<T, NetworkError>(error: NetworkError.badUrl("invalid url")))
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: req.buildURLRequest(with: url))
            .tryMap { output in
                guard output.response is HTTPURLResponse else {
                    throw NetworkError.serverError(code: 0, error: "Server Error")
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                return NetworkError.invalidJSON(code: 0, error: "Invalid JSON")
            }
            .eraseToAnyPublisher()
    }
    
}

public struct NetworkRequest {
    let url: String
    let headers: [String: String]?
    let body: Data?
    let requestTimeOut: Float?
    let httpMethod: HTTPMethod
    
    public init(url: String, headers: [String: String]? = nil, reqBody: Encodable? = nil, requestTimeOut: Float? = nil, httpMethod: HTTPMethod) {
        self.url = url
        self.headers = headers
        self.body = reqBody?.encode()
        self.requestTimeOut = requestTimeOut
        self.httpMethod = httpMethod
    }
    
    func buildURLRequest(with url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = body
        urlRequest.allHTTPHeaderFields = headers ?? [:]
        return urlRequest
    }
}

public enum HTTPMethod: String {
    case POST
    case GET
    case DELETE
    case PUT
}

public enum NetworkError: Error, Equatable {
    case badUrl(_ error: String)
    case apiError(code: Int, error: String)
    case invalidJSON(code: Int, error: String)
    case unauthorized(code: Int, error: String)
    case badRequest(code: Int, error: String)
    case serverError(code: Int, error: String)
    case noResponse(code: Int, error: String)
    case unableToParseData(code: Int, error: String)
    case unknown(code: Int, error: String)
}

extension Encodable {
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}
