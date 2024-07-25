//
//  CollectionViewTableViewCell.swift
//  CollectionViewTableCell
//
//  Created by Jorge Ferrusca on 10/14/20.
//

import UIKit

/**
 - Note: 
 The name of this class was given since the class itself is a TableView cell,
 however it defines a `UICollectionView` with **horizontal scroll**, so that a list of movies can be displayed inside.
  */
class CollectionViewTableViewCell: UITableViewCell {
    
    public var movies = [Movie]()
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 250)
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
    }
}




// MARK: UICollectionViewDataSource

extension CollectionViewTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        
        cell.setup(movie: movies[indexPath.item])

        return cell
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 185, height: 200)
    }
}
