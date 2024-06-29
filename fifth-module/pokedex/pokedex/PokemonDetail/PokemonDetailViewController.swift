//
//  PokemonDetailViewController.swift
//  pokedex
//
//  Created by Jorge Ferrusca on 21/06/24.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    var viewModel: PokemonDetailViewModel;
    let pokemon: Pokemon!
    
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemMint
        
        return scrollView
    }()
    
    // any other UI element will be placed into this contentView.
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        
        return view
    }();
    
    // Pokemon image
    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(systemName: "lizard")
        imageView.image = image
        
        // Constraints narrowed to imageView
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        return imageView
    }()
    
    // Pokemon name label
    private lazy var pokemonName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.pokemonName
        
        // set dynamic font's size
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        
        label.accessibilityLabel = "Pokemon name: \(viewModel.pokemonName)"
        
        return label
    }()
    
    private lazy var pokemonLocationButton: UIButton = {
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.title = "Pokemon Location"
        
        
        
        return UIButton(configuration: buttonConfig)
    }()
    
    init(pokemon: Pokemon) {
        viewModel = PokemonDetailViewModel(with: pokemon)
        self.pokemon = pokemon
        
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    // this init helps to throw an error when this viewController is tried to be implemented as XIB or Storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // gets called when the instance is removed from memory
    deinit {
        print("Hola")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView();
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        // adding views
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let contentViewHeightAnchor = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentViewHeightAnchor.isActive = true
        
        // all other constraints wil have higher priority
        contentViewHeightAnchor.priority = .required - 1
        
//        let pinkView = UIView()
//        pinkView.backgroundColor = .systemPink
//        pinkView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(pinkView)
        
        NSLayoutConstraint.activate([
            // stick to safearea on top
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
//            pinkView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            pinkView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            pinkView.widthAnchor.constraint(equalToConstant: 50),
//            pinkView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            pinkView.heightAnchor.constraint(equalToConstant: 1000)
        ])
        
        let pokemonInfoStack = UIStackView()
        pokemonInfoStack.translatesAutoresizingMaskIntoConstraints = false
        pokemonInfoStack.axis = .vertical
        pokemonInfoStack.distribution = .fillProportionally
        
        pokemonInfoStack.addArrangedSubview(pokemonImageView)
        pokemonInfoStack.addArrangedSubview(pokemonName)
        pokemonInfoStack.addArrangedSubview(pokemonLocationButton)
        
        contentView.addSubview(pokemonInfoStack)
        NSLayoutConstraint.activate([
            pokemonInfoStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            pokemonInfoStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            pokemonInfoStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -8),
            pokemonInfoStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
        
        // adding target to the button
        pokemonLocationButton.addTarget(self,
                                        action: #selector(locationButtonTapped),
                                        for: .touchUpInside)
    }
    
    @objc
    func locationButtonTapped() {
        present(PokemonLocationViewController(pokemon: pokemon), animated: true)
    }

}

extension PokemonDetailViewController: PokemonDetailViewModelDelegate {
    func updatePokemonImage(to image: UIImage) {
        pokemonImageView.image = image
    }
}
