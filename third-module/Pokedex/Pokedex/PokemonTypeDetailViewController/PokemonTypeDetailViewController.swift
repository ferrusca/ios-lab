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
        
        if indexPath.section == 0 {
            cellContent.text = pokemonType.doubleDamageDealt.map({ pokemonType in pokemonType.rawValue }).joined(separator: ", ")
        } else if indexPath.section == 1 {
            cellContent.text = pokemonType.doubleDamageReceived.map({ pokemonType in pokemonType.rawValue }).joined(separator: ", ")
        } else if indexPath.section == 2 {
            cellContent.text = pokemonType.halfDamageDealt.map({ pokemonType in pokemonType.rawValue }).joined(separator: ", ")
        } else if indexPath.section == 3 {
            cellContent.text = pokemonType.halfDamageReceived.map({ pokemonType in pokemonType.rawValue }).joined(separator: ", ")
        } else if indexPath.section == 4 {
            cellContent.text = pokemonType.notAffectedBy.map({ pokemonType in pokemonType.rawValue }).joined(separator: ", ")
        } else if indexPath.section == 5 {
            cellContent.text = pokemonType.noAffectedAgainst.map({ pokemonType in pokemonType.rawValue }).joined(separator: ", ")
        }
        cell.contentConfiguration = cellContent
        
        return cell
    }
}
