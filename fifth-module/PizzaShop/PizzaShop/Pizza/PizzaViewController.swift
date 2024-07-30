//
//  PizzaViewController.swift
//  PizzaShop
//
//  Created by Jorge Ferrusca on 29/06/24.
//

import UIKit

class PizzaViewController: UIViewController {
    private let pizza: Pizza!
    private var ingredientCellIdentifier = "ingredientCell"
    
    private var pizzaImageView: UIImageView = {
        let image = UIImage(named: "full-pizza")?.resized(to: CGSize(width: 300, height: 300))

        
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
                
        return imageView
    }()
    
    // Use lazy since pizza is available after initialization
    private lazy var pizzaName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = pizza.name
        
        // set dynamic font's size
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        
        label.accessibilityLabel = "Pizza name: \(pizza.name)"
        
        return label
    }()
    
    private var ingredientsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    
    
    init(pizza: Pizza) {
        self.pizza = pizza
        super.init(nibName: nil, bundle: nil)
        
        // register ingredientsCell
        ingredientsTableView.register(UITableViewCell.self,
                                      forCellReuseIdentifier: self.ingredientCellIdentifier)
        ingredientsTableView.dataSource = self
        // delegate only to deselect the topping rows
        ingredientsTableView.delegate = self
        addPizzaAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addPizzaAnimation() {
        UIView.animate(withDuration: 10000, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5) {
            self.pizzaImageView.transform = CGAffineTransform(rotationAngle: .pi)

        }
    }
    
    func setLayoutConstraints() {
        NSLayoutConstraint.activate([
            // TODO: use safe view as parent anchor
            pizzaImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            pizzaImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            pizzaName.topAnchor.constraint(equalTo: pizzaImageView.bottomAnchor, constant: 10),
            pizzaName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            ingredientsTableView.topAnchor.constraint(equalTo: pizzaName.bottomAnchor),
            ingredientsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            ingredientsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            ingredientsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"

        setupView()
        setLayoutConstraints()
    }
    

    private func setupView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(pizzaImageView)
        view.addSubview(pizzaName)
        view.addSubview(ingredientsTableView)
    }
}

extension PizzaViewController: UITableViewDataSource, UITableViewDelegate  {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pizza.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Toppings"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.ingredientCellIdentifier, 
                                                 for: indexPath)
        
        var cellConfig = cell.defaultContentConfiguration()
        cellConfig.text = pizza.ingredients[indexPath.row]
        cell.contentConfiguration = cellConfig
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("deselecting")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
