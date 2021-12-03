//
//  CatalogViewModel.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 30/11/21.
//

import UIKit

class CatalogViewControllerModel {
    
    private var countLimit = 0
    private var dataSet = [PokeApiService.Resource]()
    private var fetchInProgress = Bool(false)
    private let service = PokeApiService()
    
    enum Section {
        case catalogViewCell

        init?(_ index: IndexPath) {
            switch (index.section, index.item) {
            case (let section, _) where section == 0:
                self = .catalogViewCell
            default:
                return nil
            }
        }
    }
    
    func fetchInitialData(completion: @escaping () -> Void, onFailure: @escaping ((PokeApiService.Error) -> Void)) {
        dataSet = []
        
        service.getResource(offset: 0, limit: 80, completion: { [weak self] (limit, resources) in
            self?.countLimit = limit
            self?.dataSet = resources.sorted(by: { $0.name < $1.name })
            DispatchQueue.main.async {
                completion()
            }
        }, onFailure: onFailure)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(indexPath) {
        case .catalogViewCell:
            let cell = tableView.dequeueReusableCell(CatalogViewCell.self)
            
            cell.imagePokemon.image = dataSet[indexPath.item].image
            cell.labelPokemonName.text = dataSet[indexPath.item].name
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ controller: CatalogViewController, tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Section(indexPath) {
        case .catalogViewCell:
            let detailVC = DetailViewController()
            detailVC.model = DetailViewControllerModel(
                image: dataSet[indexPath.item].image,
                name: dataSet[indexPath.item].name,
                stats: dataSet[indexPath.item].stats,
                types: dataSet[indexPath.item].types
            )
            controller.navigationController?.pushViewController(detailVC, animated: true)
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath], onFailure: @escaping ((PokeApiService.Error) -> Void)) {
        if dataSet.count < countLimit {
            if fetchInProgress == false {
                print(dataSet.count, countLimit)
                fetchInProgress = true
                
                self.service.getResource(offset: dataSet.count, limit: 80, completion: { [weak self] (_, resources) in
                    self?.fetchInProgress = false
                    self?.dataSet.append(contentsOf: resources)
                    if let sortedDataSet = self?.dataSet.sorted(by: { $0.name < $1.name }) {
                        self?.dataSet = sortedDataSet
                        DispatchQueue.main.async {
                            tableView.reloadData()
                        }
                    }
                }, onFailure: onFailure)

            }
        }
    }
}

class CatalogViewCellModel {
    
    func prepareForReuse(_ controller: CatalogViewCell) {
        controller.imagePokemon.image = nil
        controller.labelPokemonName.text = nil
    }
    
}
