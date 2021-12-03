//
//  CatalogViewController.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 30/11/21.
//

import UIKit
import CoreData

class CatalogViewController: UIViewController {
    
    let model = CatalogViewControllerModel()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
        model.fetchInitialData {
            self.tableView.reloadData()
        } onFailure: { _ in
            /*
             Put here your code to handle controller behaviour on unsuccessful query result
             */
            Alerts.connectionError.show()
        }
    }
    
    func setupUI() {
        title = Config.catalogViewControllerTitle
        view.addSubview(tableView)
        view.backgroundColor = .white
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.register(CatalogViewCell.self, forCellReuseIdentifier: CatalogViewCell.name)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension CatalogViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Config.catalogTableViewCellHeight
    }
}

extension CatalogViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        model.tableView(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model.tableView(self, tableView: tableView, didSelectRowAt: indexPath)
    }

}

extension CatalogViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        model.tableView(tableView, prefetchRowsAt: indexPaths, onFailure: { _ in
            /*
             Put here your code to handle controller behaviour on unsuccessful query result
             */
            Alerts.connectionError.show()
        })
    }
}

class CatalogViewCell: UITableViewCell {
    
    let model = CatalogViewCellModel()
    
    var stackView = UIStackView()
    var imagePokemon = RoundedImageView()
    var labelPokemonName = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("CatalogViewCell init(coder:) is not implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    override func prepareForReuse() {
        model.prepareForReuse(self)
    }
    
    func setupUI() {
        imagePokemon.backgroundColor = .black
        
        contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        imagePokemon.translatesAutoresizingMaskIntoConstraints = false
        labelPokemonName.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.addArrangedSubview(imagePokemon)
        stackView.addArrangedSubview(labelPokemonName)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            imagePokemon.widthAnchor.constraint(equalTo: stackView.heightAnchor)
        ])
    }
}

class RoundedImageView: UIImageView {
    
    override func layoutSubviews() {
        layer.cornerRadius = bounds.height / 2
    }
    
}
