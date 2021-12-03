//
//  DetailViewController.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 30/11/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var model: DetailViewControllerModel?
    
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var stackViewContent = UIStackView()
    private lazy var labelPokemonName = UILabel()
    private lazy var imagePokemon = UIImageView()
    private lazy var labelStats = UILabel()
    private lazy var stackViewStats = UIStackView()
    private lazy var labelElements = UILabel()
    private lazy var stackViewElements = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
        
        if let model = model {
            imagePokemon.image = model.image
            labelPokemonName.text = model.name?.capitalized
            
            for item in model.stats {
                stackViewStats.addArrangedSubview(detailContainer(text: item.stat.name, value: item.baseStat))
            }
            
            for item in model.types {
                stackViewElements.addArrangedSubview(detailContainer(text: item.type.name, value: item.slot))
            }
            
            stackViewElements.addArrangedSubview(spacer(40))
        }
        
    }
    
    private func detailContainer(text: String, value: Int) -> UIStackView {
        let statName = UILabel()
        let statValue = UILabel()
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(statName)
        stackView.addArrangedSubview(statValue)
        
        statName.translatesAutoresizingMaskIntoConstraints = false
        statName.text = text
        
        statValue.translatesAutoresizingMaskIntoConstraints = false
        statValue.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        statValue.text = value.description
        return stackView
    }
    
    private func spacer(_ height: CGFloat) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        // label.layer.borderWidth = 1.0
        // label.layer.borderColor = UIColor.red.cgColor
        label.heightAnchor.constraint(equalToConstant: height).isActive = true
        return label
    }
    
    private func setupUI() {
        
        view.addSubview(scrollView)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = .white
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: 414, height: 1200)
        
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackViewContent)
        
        stackViewContent.translatesAutoresizingMaskIntoConstraints = false
        stackViewContent.axis = .vertical
        
        stackViewStats.axis = .vertical
        stackViewElements.axis = .vertical
        
        stackViewContent.addArrangedSubview(labelPokemonName)
        stackViewContent.addArrangedSubview(imagePokemon)
        stackViewContent.addArrangedSubview(spacer(10))
        stackViewContent.addArrangedSubview(labelStats)
        stackViewContent.addArrangedSubview(spacer(40))
        stackViewContent.addArrangedSubview(stackViewStats)
        stackViewContent.addArrangedSubview(spacer(40))
        stackViewContent.addArrangedSubview(labelElements)
        stackViewContent.addArrangedSubview(spacer(40))
        stackViewContent.addArrangedSubview(stackViewElements)
        
        labelPokemonName.translatesAutoresizingMaskIntoConstraints = false
        labelPokemonName.text = "Pokemon"
        labelPokemonName.textAlignment = .center
        labelPokemonName.font = UIFont.systemFont(ofSize: 40)
        
        imagePokemon.translatesAutoresizingMaskIntoConstraints = false
        imagePokemon.image = UIImage(named: "noImage")
        
        labelStats.translatesAutoresizingMaskIntoConstraints = false
        labelStats.text = "Stats"
        labelStats.font = UIFont.systemFont(ofSize: 25)
        
        labelElements.translatesAutoresizingMaskIntoConstraints = false
        labelElements.text = "Element Type"
        labelElements.font = UIFont.systemFont(ofSize: 25)
        

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            stackViewContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stackViewContent.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackViewContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            stackViewContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imagePokemon.widthAnchor.constraint(equalTo: imagePokemon.heightAnchor)
        ])
    }
}

