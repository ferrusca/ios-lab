//
//  CustomPizzaListTableViewController.swift
//  PizzaShop
//
//  Created by Jorge Ferrusca on 29/06/24.
//

import UIKit

class CustomPizzaListTableViewController: UITableViewController {
    let viewModel = CustomPizzaListModel()
    let tableTitle = "My Pizzas"
    
    let createPizzaButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Customize Pizza"
        
        let button = UIButton()
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = tableTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        
        createPizzaButton.addTarget(self,
                         action: #selector(createPizzaTapped),
                         for: .touchUpInside)
        
        view.addSubview(createPizzaButton)
        
        NSLayoutConstraint.activate([
            createPizzaButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createPizzaButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100),
            createPizzaButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            createPizzaButton.heightAnchor.constraint(equalToConstant: 70)
        ])

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.dataSource = self
        // register ingredientsCell
        tableView.register(UITableViewCell.self,
                                      forCellReuseIdentifier: viewModel.cellIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Reloading data to check whether a pizza was added
        tableView.reloadData()
    }
    
    @objc private func createPizzaTapped() {
        let pizzaGeneratorViewController = PizzaGeneratorViewController(viewModel: viewModel)
        navigationController?.pushViewController(pizzaGeneratorViewController, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.total
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Passing indexPath as second argument returns a non-optional cell
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath)
        let customPizza = viewModel.getPizza(at: indexPath)
        
        var cellConfiguration = cell.defaultContentConfiguration()
        cellConfiguration.text = customPizza.name
        cellConfiguration.secondaryText = customPizza.ingredients.joined(separator: ", ")
        cell.contentConfiguration = cellConfiguration

        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let removeAction = UIContextualAction(style: .normal, title: "Remove") {
                [weak self] _, _, completition in
                self?.viewModel.removePizza(at: indexPath)
                self?.tableView.reloadData()
                completition(true)
            }
            
            removeAction.backgroundColor = .systemRed
            removeAction.image = UIImage(systemName: "trash.fill")
            
            return UISwipeActionsConfiguration(actions: [removeAction])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let pizza = viewModel.getPizza(at: indexPath)
        let pizzaViewController = PizzaViewController(pizza: pizza)
        
        navigationController?.pushViewController(pizzaViewController, animated: true)
    }
}
