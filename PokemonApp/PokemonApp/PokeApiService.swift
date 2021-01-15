//
//  PokeApiService.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import Foundation

struct PokeApiService: RestAPI {
    
    enum Service : WebAPIService {
        
        case getResourceList((offset: Int, limit: Int)?)
        case getPokemon(name: String)
        case getSprite(id: Int)
        case getOtherSprite(id: Int)
        
        var host: String {
            switch self {
            case .getSprite(_),
                 .getOtherSprite(_):
                return "raw.githubusercontent.com"
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
            case .getSprite(let id):
                return "/PokeAPI/sprites/master/sprites/pokemon/shiny/\(id).png"
            case .getOtherSprite(let id):
                return "/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/\(id).svg"
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
    
}


