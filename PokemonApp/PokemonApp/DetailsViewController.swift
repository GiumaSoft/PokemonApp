//
//  DetailsViewController.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import UIKit


//MARK: - Data Prefetching
extension DetailsViewController: UITableViewDataSourcePrefetching {
    
    
    
    //MARK: - prefetchRowsAt
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
    }
    
}

//MARK: - DataSource Delegate
extension DetailsViewController {
    
    
    
    //MARK: - Section.Enum
    enum Section {
        case Profile
        case Stats
        case Types
        case unkonwn
        
        init(_ section: Int) {
            switch section {
            case 0: self = .Profile
            case 1: self = .Stats
            case 2: self = .Types
            default:
                self = .unkonwn
            }
        }
        
        init(_ indexPath: IndexPath) {
            self.init(indexPath.section)
        }

    }
    
    //MARK: - numberOfSections
    override func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    //MARK: - numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(section) {
        case .Profile:
            return 1
        case .Stats:
            return dataSource[dataSourcePath].stats.count
        case .Types:
            return dataSource[dataSourcePath].types.count
        default:
            return 0
        }
    }
    
    //MARK: - cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(indexPath) {
        
        //MARK: - .Profile
        case .Profile:
            if let cell = tableView.dequeueReusableCell(fromClass: ProfileViewCell.self) {
                
                return cell.setup(dataSource[dataSourcePath])
            }
        //MARK: - .Stats
        case .Stats:
            if let cell = tableView.dequeueReusableCell(fromClass: ProfileStatsViewCell.self) {
                
                return cell.setup(dataSource[dataSourcePath].stats[indexPath.item])
            }
            
        //MARK: - .Kind
        case .Types:
            if let cell = tableView.dequeueReusableCell(fromClass: ProfileTypeViewCell.self) {
                
                return cell.setup(dataSource[dataSourcePath].types[indexPath.item])
            }
            
        //MARK: - Default
        case .unkonwn:
            break
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let view = tableView.dequeueReusableHeaderFooterView(fromClass: DetailsSectionHeader.self) {
            switch Section(section) {
            case .Stats:
                view.titleLabel.text = "Stats"
            case .Types:
                view.titleLabel.text = "Elemental Type"
            default:
                view.titleLabel.text = nil
            }
            return view
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    
}

class DetailsViewController: UITableViewController {
    

    
    //MARK: - outlet

    
    
    
    //MARK: - properties
    var dataSource: CatalogDataSource!
    var dataSourcePath: IndexPath!
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(headerFooterNibClass: DetailsSectionHeader.self)
    }

    
}
