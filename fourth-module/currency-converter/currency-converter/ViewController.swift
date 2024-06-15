//
//  ViewController.swift
//  currency-converter
//
//  Created by Jorge Ferrusca on 08/06/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let countryModel = CountryModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        try? countryModel.getAll()
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        countryModel.getNumberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath)) as! CountryCollectionViewCell
        
        let country = countryModel.getItem(index: indexPath.row)
        
        cell.setup(countryName: country.name, imagePath: country.imagePath)
        return cell
    }
}

// Collection view cell click handler
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let countryDetailViewController = CountryDetailViewController(nibName: "CountryDetailViewController", bundle: nil)
        countryDetailViewController.country = countryModel.getItem(index: indexPath.row)
        print(countryDetailViewController.country!)
        
        navigationController?.pushViewController(countryDetailViewController, animated: true)
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 150, height: 150)
    }
}
