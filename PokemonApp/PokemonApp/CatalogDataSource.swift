//
//  CatalogDataSource.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import UIKit

struct CatalogItem {
    let id: Int
    let name: String
    let image: UIImage
    let stats: [PDM.PokemonStat]
    let types: [PDM.PokemonType]
}

class CatalogDataSource {
    
    var dataSet: [CatalogItem] = []
    
    var maxCount: Int = 0
    
    var service = PokeApiService()
    
    private var isLoading: Bool = false
    
    subscript(_ indexPath: IndexPath) -> CatalogItem {
        dataSet[indexPath.item]
    }

    func getCatalog(offset: Int = 0, limit: Int = 20, completion: ((Bool) -> Void)? = nil) {
        if !isLoading {
            isLoading = true
            
            DispatchQueue.main.async {
                self.service.fetch(api: .getResourceList((offset, limit))) { (result: RestAPIResult<PDM.ResourceList, DummyError>) in
                    switch result {
                    case .Decoded(let resource):
                        for (index, pokemon) in resource.results.enumerated() {
                            
                            DispatchQueue.main.async {
                                self.service.fetch(api: .getPokemon(name: pokemon.name)) { (result: RestAPIResult<PDM.Pokemon, DummyError>) in
                                    switch result {
                                    case .Decoded(let details):
                                        
                                        DispatchQueue.main.async {
                                            self.service.fetch(api: .getSprite(id: details.id)) { (result: RestAPIResult<Data, DummyError>) in
                                                    
                                                switch result {
                                                case .Encoded(let imageData):
                                                    guard let image = UIImage(data: imageData) else {
                                                        completion?(false)
                                                        return
                                                    }
                                                    
                                                    let item = CatalogItem(id: details.id,
                                                                           name: details.name,
                                                                           image: image,
                                                                           stats: details.stats,
                                                                           types: details.types)
                                                    
                                                    self.dataSet.append(item)
                                                    
                                                    if index == resource.results.count - 1 {
                                                        completion?(true)
                                                        self.isLoading = false
                                                        return
                                                    }
                                                    
                                                default:
                                                    completion?(false)
                                                    self.isLoading = false
                                                    return
                                                }
                                                
                                            }
                                        }
                                    default:
                                        completion?(false)
                                        self.isLoading = false
                                        return
                                    }
                                }
                            }
                        }
                    default:
                        completion?(false)
                        self.isLoading = false
                        return
                    }
                    
                }
                
            }

        }
        
    }
    
}
