//
//  PokemonTypeDetailViewController.swift
//  Pokedex
//
//  Created by Jorge Ferrusca on 31/05/24.
//

import UIKit

class PokemonTypeDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    public var pokemonType: PokemonTypeDamage!
    
    let sections = [
        "Double damage dealt",
        "Double damage received",
        "Half damage dealt",
        "Half damage received",
        "Not affected by",
        "No effect against",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        imageView.image = UIImage(named: pokemonType.imagePath)
        label.text = pokemonType.name
        // Do any additional setup after loading the view.
    }

}

extension PokemonTypeDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        var cellContent = cell.defaultContentConfiguration()
        var pokemonInterestedTypes: [PokemonType] = []
        
        switch indexPath.section {
        case 0:
            pokemonInterestedTypes = pokemonType.doubleDamageDealt
        case 1:
            pokemonInterestedTypes = pokemonType.doubleDamageReceived
        case 2:
            pokemonInterestedTypes = pokemonType.halfDamageDealt
        case 3:
            pokemonInterestedTypes = pokemonType.halfDamageReceived
        case 4:
            pokemonInterestedTypes = pokemonType.notAffectedBy
        case 5:
            pokemonInterestedTypes = pokemonType.noAffectedAgainst
        default:
            fatalError("Case in pokemon types not found")
        }
        cellContent.text = pokemonInterestedTypes.map({ pokemonType in pokemonType.rawValue }).joined(separator: ", ")
        
        cell.contentConfiguration = cellContent
        return cell
    }
}
