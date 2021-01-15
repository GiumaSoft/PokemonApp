//
//  CatalogViewController.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import UIKit


extension CatalogViewController: UICollectionViewDelegateFlowLayout {

    
}

//MARK: - Prefetch Delegate
extension CatalogViewController: UICollectionViewDataSourcePrefetching {
    
    
    
    //MARK: - prefetchItemAt
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {

        dataSource.getCatalog(offset: dataSource.dataSet.count) { done in
            if done {
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
            }
        }
    }
    
}

//MARK: - DataSource Delegate
extension CatalogViewController: UICollectionViewDataSource {
    
    

    //MARK: - Section.Enum
    private enum Section {
        case Catalog
        case unknown
        
        init(_ indexPath: IndexPath) {
            switch indexPath.section {
            case 0: self = .Catalog
            default:
                self = .unknown
            }
        }

    }
    
    //MARK: - numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.dataSet.count
    }
    
    //MARK: - cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch Section(indexPath) {
        case .Catalog:
            if let cell = collectionView.dequeueReusableCell(fromClass: CatalogViewCell.self, for: indexPath) {
                
                return cell.setup(with: dataSource[indexPath])

            }
        case .unknown:
            // Produce here debug logs for unknown section condition
            break
        }
        
        // Produce here debug logs for unhandled conditions
        return UICollectionViewCell()
    }
    
    //MARK: - didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.indexPath = indexPath
        performSegue(withIdentifier: "PokemonDetailsSegue", sender: self)
    }
    
}

//MARK: - Controller
class CatalogViewController: UIViewController, UICollectionViewDelegate {
    
    
    
    //MARK: - outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK: - properties
    var dataSource = CatalogDataSource()
    var indexPath: IndexPath?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.bringSubviewToFront(activityIndicator)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        collectionView.reloadData()
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        collectionView.register(cellNibClass: CatalogViewCell.self)
        
        dataSource.getCatalog(offset: 0, limit: 90) { done in
            if done {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "PokemonDetailsSegue":
            if let controller = segue.destination as? DetailsViewController,
               let indexPath = indexPath {
                controller.dataSource = dataSource
                controller.dataSourcePath = indexPath
            }
        default:
            return
        }
    }
    
}
