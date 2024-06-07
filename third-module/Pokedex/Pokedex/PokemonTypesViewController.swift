//
//  PokemonTypesViewController.swift
//  Pokedex
//
//  Created by Jorge Ferrusca on 31/05/24.
//

import UIKit

class PokemonTypesViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let pokemonTypeModel = PokemonTypeModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        
        
        // register custom collection cell
        collectionView.register(UINib(nibName: "PokemonTypeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PokemonTypeCollectionViewCell")
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.delegate = self
        
    }
    

    

}

extension PokemonTypesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pokemonTypeModel.getPokemonTypes().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonTypeCollectionViewCell", for: indexPath)) as! PokemonTypeCollectionViewCell
        
        cell.setup(type: pokemonTypeModel.getPokemonType(index: indexPath.row))
        
        return cell
    }
}

extension PokemonTypesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 128, height: 128)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 4
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 1
        }

}

// Collection view cell click handler
extension PokemonTypesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemonTypeDetailViewController = PokemonTypeDetailViewController(nibName: "PokemonTypeDetailViewController", bundle: nil)
        pokemonTypeDetailViewController.pokemonType = self.pokemonTypeModel.getPokemonType(index: indexPath.row)
        
        navigationController?.pushViewController(pokemonTypeDetailViewController, animated: true)
    }
}
