//
//  PizzaListTableViewController.swift
//  PizzaShop
//
//  Created by Jorge Ferrusca on 29/06/24.
//

import UIKit

class PizzaListTableViewController: UITableViewController {
    let viewModel = PizzaListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: viewModel.cellIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pizzasCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier,
                                                 for: indexPath)
        
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = viewModel.getPizza(at: indexPath).name
        
        cell.contentConfiguration = contentConfiguration

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let pizza = viewModel.getPizza(at: indexPath)
        let pizzaViewController = PizzaViewController(pizza: pizza)
        navigationController?.pushViewController(pizzaViewController, animated: true)
    }

}
