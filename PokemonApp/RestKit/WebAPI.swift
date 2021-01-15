//
//  WebAPIResult.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import Foundation

// MARK:- WebAPIResult
public enum WebAPIResult {
    
    case Success(Data, URLResponse)
    case Failure(Data?, URLResponse)
    case Error(Error)
}

// MARK:- WebAPI
public protocol WebAPI : WebAPIFoundation {
    
    associatedtype Service : WebAPIService
    
    var configuration : URLSessionConfiguration { get }
    
    var delegate : URLSessionDelegate? { get }
    
    func session(api service: Service, timeout: Int, completion: @escaping (WebAPIResult) -> Void)

    func session(request: URLRequest, timeout: Int, completion: @escaping (WebAPIResult) -> Void)
    
}

public extension WebAPI {
// MARK:- Public methods

    var configuration : URLSessionConfiguration { .default }
    
    var delegate : URLSessionDelegate? { nil }
    
    // MARK:- session(_:api::)
    func session(api service: Service, timeout: Int = 60, completion: @escaping (WebAPIResult) -> Void) {
        do {
            let request = try use(api: service)
            
            session(request: request, timeout: timeout, completion: completion)
            
        } catch let error {
            logError(error)
        }
    }
    
    // MARK:- session(_:request::)
    func session(request: URLRequest, timeout: Int = 60, completion: @escaping (WebAPIResult) -> Void) {
        
        var request = request
        request.cachePolicy = .reloadIgnoringLocalCacheData
        let configuration = self.configuration
        configuration.timeoutIntervalForRequest = TimeInterval(timeout)
        let session = URLSession(configuration: configuration,
                                 delegate: delegate,
                                 delegateQueue: nil)
    
        session.dataTask(with: request) { (data, response, error) in
            
            self.logSession((request, data, response, error))
            
            switch (data, response, error) {
            // Error case
            case (_, _, let .some(error)):
                completion(.Error(error))
            case (data, let .some(response as HTTPURLResponse), _):
                switch (data, response.statusCode) {
            // Success case
                case (let .some(data), (200...299)):
                    completion(.Success(data, response))
            // All other unsuccesfull cases
                default:
                    completion(.Failure(data, response))
                }
            default:
            // Unhandled response
                break }
            
        }.resume()
        
    }


// MARK:- Private methods
    
    
    
    
    // MARK:- use(_:service:)
    private func use(api service: Service) throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = service.scheme.description
        urlComponents.host = service.host
        urlComponents.path = service.path
        urlComponents.port = service.port
        urlComponents.queryItems = service.queryItems
        
        let url = try urlComponents.urlSafe()
        
        var request = URLRequest(url: url)
        request.httpMethod = service.method.rawValue
        // service.headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.field) }
        request.allHTTPHeaderFields = service.headers
        request.httpBody = service.payload
        return request
    }
    

}


