//
//  PokeApiService.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import Foundation
import UIKit

extension PokeApiService {
    
    class SessionManager: NSObject, URLSessionDelegate, URLSessionTaskDelegate, URLSessionDownloadDelegate, URLSessionDataDelegate {
        
        func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
            
        }
        
        func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
            dump(request)
        }
    }
}

struct PokeApiService: RestAPI {

    struct Resource {
        let name: String
        let image: UIImage
        let stats: [PDM.PokemonStat]
        let types: [PDM.PokemonType]
    }
    
    enum Error: Swift.Error {
        case failToGetResource
        case failure
        case error(Swift.Error)
    }

    enum APIService: WebAPIService {

        case getResourceList((offset: Int, limit: Int)?)
        case getPokemon(name: String)
        
        var host: String {
            switch self {
            default:
                return "pokeapi.co"
            }
        }
        
        var path: String {
            switch self {
            case .getResourceList(_):
                return "/api/v2/pokemon"
            case .getPokemon(let name):
                return "/api/v2/pokemon/\(name)"
            }
        }
        
        var queryItems: [URLQueryItem]? {
            switch self {
            case .getResourceList(let param):
                switch param {
                case let .some(param):
                    var items = [URLQueryItem]()
                    items.append(URLQueryItem(name: "offset", value: String(param.offset)))
                    items.append(URLQueryItem(name: "limit", value: String(param.limit)))
                    return items
                default:
                    break
                }
            default:
                break
            }
            return nil
        }
        
        var method: HTTPMethod {
            switch self {
            default:
                return .Get
            }
        }
        
        var payload: Data? {
            switch self {
            default:
                break
            }
            return nil
        }
        
    }
    
    var delegate: URLSessionDelegate?
    var sessionManager: SessionManager
    
    init() {
        self.sessionManager = SessionManager()
        self.delegate = sessionManager
    }
    
    func getResource(offset: Int, limit: Int, completion: @escaping (Int, [Resource]) -> Void, onFailure: @escaping (Error) -> Void) {
        var resources = [Resource]()
        var countLimit = Int.zero
        
        fetch(.getResourceList((offset: offset, limit: limit))) { (result: RestAPIResult<PDM.ResourceList>) in
            guard case .decoded(let resourceList) = result else { onFailure(Error.failToGetResource); return }
            
            countLimit = resourceList.count
            DispatchQueue.global(qos: .userInitiated).async {
                let group = DispatchGroup()
                for namedApi in resourceList.results {
                    group.enter()
                    fetch(.getPokemon(name: namedApi.name)) { (result: RestAPIResult<PDM.Pokemon>) in
                        guard case .decoded(let pokemon) = result else { onFailure(Error.failToGetResource); return }
                        
                        if let urlString = pokemon.sprites.frontDefault, let url = URL(string: urlString) {
                            fetch(URLRequest(url: url)) { result in
                                var image: UIImage
                              
                                if case .success(let data) = result {
                                    image = UIImage(data: data) ?? UIImage(named: "noImage")!
                                } else {
                                    image = UIImage(named: "noImage")!
                                }
                                
                                resources.append(Resource(name: pokemon.name,
                                                          image: image,
                                                          stats: pokemon.stats,
                                                          types: pokemon.types))
                                group.leave()
                            }
                        } else {
                            resources.append(Resource(name: pokemon.name,
                                                      image: UIImage(named: "noImage")!,
                                                      stats: pokemon.stats,
                                                      types: pokemon.types))
                            group.leave()
                        }
                    }
                    
                    _ = group.wait(timeout: .now())
                }
                
                group.notify(queue: .global(qos: .userInitiated)) {
                    print("done with fetch")
                    completion(countLimit, resources)
                }
            }
        }
    }

    
}



