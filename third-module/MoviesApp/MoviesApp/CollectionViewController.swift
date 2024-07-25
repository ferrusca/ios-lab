//
//  CollectionViewController.swift
//  CollectionViewTableCell
//
//  Created by Viet Tran on 10/14/20.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    //  Set this action during initialization to get a callback when the collection view finishes its layout.
    //  To prevent infinite loop, this action should be called only once. Once it is called, it resets itself
    //  to nil.
    var didLayoutAction: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "foobar")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        didLayoutAction?()
        didLayoutAction = nil   //  Call only once
        
//        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
//        collectionView.delegate = self
    }


