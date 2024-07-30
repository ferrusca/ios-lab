//
//  PizzaGeneratorViewController.swift
//  PizzaShop
//
//  Created by Jorge Ferrusca on 29/06/24.
//

import UIKit

class PizzaGeneratorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let toppingsModel = PizzaListViewModel()
    private let viewModel: CustomPizzaListModel!
    
    private let toppingsTableView = UITableView()
    private let toppingCellIdentifier = "toppingCell"
    private var pizza: Pizza!
    
    private let pizzaImageView: UIImageView = {
        let image = UIImage(named: "pizza-slice")?.resized(to: CGSize(width: 250, height: 230))

        
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // use `lazy var` to be able to get the pizza name when available.
    private lazy var pizzaNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = pizza.name
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .largeTitle)
        
        return label
    }()
    
    private lazy var savePizzaButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Create"
        config.baseBackgroundColor = .systemGreen
        config.cornerStyle = .fixed
    
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        // button disabled until ingredients are added
        button.isEnabled = false
        
        button.addTarget(self, action: #selector(saveCustomPizza), for: .touchUpInside)
        
        return button
    }()
    
    init(viewModel: CustomPizzaListModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pizza = createNewPizza()
        title = "Pizza Creation"

        toppingsTableView.dataSource = self
        toppingsTableView.delegate = self
        
        // setting up view (will use a StackView)
        setupStackView()
        
        // registering the topping cell
        toppingsTableView.register(UITableViewCell.self,
                                   forCellReuseIdentifier: self.toppingCellIdentifier)
    }
    
    private func createNewPizza() -> Pizza {
        return Pizza(name: "Custom Pizza \(viewModel.total + 1)", ingredients: [])
    }
    
    private func addPizzaTopping(_ topping: String) {
        pizza.ingredients.append(topping)
        savePizzaButton.isEnabled = pizza.ingredients.count > 0
    }
    
    private func setupStackView() {
        view.backgroundColor = .systemBackground
        
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.isLayoutMarginsRelativeArrangement = true
        
        // this 2nd stack acts a wrapper in order to add padding to the pizza images.
        let imageViewStack = UIStackView()
        imageViewStack.addArrangedSubview(pizzaImageView)
        imageViewStack.layoutMargins = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 80)
        imageViewStack.isLayoutMarginsRelativeArrangement = true
        
        stack.addArrangedSubview(imageViewStack)
        stack.addArrangedSubview(pizzaNameLabel)
        stack.addArrangedSubview(toppingsTableView)
        stack.addArrangedSubview(savePizzaButton)
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            savePizzaButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func saveCustomPizza() {
        print("storing pizza \(pizza!)")
        viewModel.addPizza(pizza: pizza)
        self.navigationController?.popViewController(animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toppingsModel.toppingsCount
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Add Your Toppings"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.toppingCellIdentifier,
                                                 for: indexPath)
        
        var cellConfig = cell.defaultContentConfiguration()
        cellConfig.text = toppingsModel.getTopping(at: indexPath)
        cell.contentConfiguration = cellConfig
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addToppingAction = UIContextualAction(style: .normal, title: "Add topping") {
            [weak self] _, _, completition in
            if let topping = self?.toppingsModel.getTopping(at: indexPath) {
                self?.addPizzaTopping(topping)
                completition(true)
            }
        }
        
        addToppingAction.backgroundColor = .systemGreen
        addToppingAction.image = UIImage(systemName: "plus")
        
        return UISwipeActionsConfiguration(actions: [addToppingAction])
    }
    
    
}
