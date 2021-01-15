//
//  RestAPI.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import Foundation

public enum RestAPIResult<U, V> where U : Decodable, V : Decodable {
    case Decoded(U)
    case DecodedWithError(V)
    case Serialized([String: Any])
    case Encoded(Data)
    case Failure(Data?, URLResponse)
    case Error(Error)
}

// MARK:- RestAPI
public protocol RestAPI : WebAPI {
    
    func fetch<U, V>(api service: Service, completion: @escaping (RestAPIResult<U, V>) -> Void) where U : Decodable, V : Decodable
    
}

public extension RestAPI {
    
// MARK:- Public methods
    
    
    
    
    
    
    // MARK:- fetch(_:)
    func fetch<U, V>(api service: Service, completion: @escaping (RestAPIResult<U, V>) -> Void) where U : Decodable, V : Decodable {
        
        session(api: service) { result in
            switch result {
            case .Success(let data, _):
                self.evalFormat(data: data, completion: completion)
            case .Failure(let .some(data), _):
                self.evalFormat(data: data, completion: completion)
            case .Failure(let data, let response):
                completion(.Failure(data, response))
            case .Error(let error):
                completion(.Error(error))
            }
        }
    }

// MARK:- Private methods
    
    private var DEBUG_LOG: Bool { false }
    
    // MARK:- evalFormat(_:)
    private func evalFormat<U, V>(data: Data, completion: (RestAPIResult<U, V>) -> Void) where U : Decodable, V : Decodable {
        
        if let decode = try? JSONDecoder().decode(U.self, from: data) {
            if DEBUG_LOG {
                print("@@@@@@@@@@@ RestAPIClient :: ")
                print("---\nevalJSON Decoded")
                dump(decode)
            }
            completion(.Decoded(decode))
            return
        }
        
        if let decode = try? JSONDecoder().decode(V.self, from: data) {
            if DEBUG_LOG {
                print("@@@@@@@@@@@ RestAPIClient :: ")
                print("---\nevalJSON DecodedWithError")
                dump(decode)
            }
            completion(.DecodedWithError(decode))
            return
        }
        
        if let serialized = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            if DEBUG_LOG {
                print("@@@@@@@@@@@ RestAPIClient :: ")
                print("---\nevalJSON Serialized")
                print(serialized.description)
            }
            completion(.Serialized(serialized))
            return
        }
        
        if DEBUG_LOG {
            print("@@@@@@@@@@@ RestAPIClient :: ")
            print("---\nevalJSON Encoded")
        }
        completion(.Encoded(data))

    }
    
}
