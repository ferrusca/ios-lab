//
//  ViewController.swift
//  CollectionView
//
//  Created by Jorge Ferrusca on 24/05/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let movies = ["Buscando a nemo", "Annabelle", "Barbie", "El rey leon", "El padrino", "Star Wars", "Spiderman", "Harry Potter", "Eso", "Yo antes de ti"];

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        // set cells size
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.delegate = self
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }

    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // MARK: the cell identitied was hardcoded in the editor
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        
        cell.setup(movie: movies[indexPath.row])
        
        return cell
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 200, height: 250)
    }
}

// Delegating collection view to get the selected cell
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(movies[indexPath.row])
    }
}
