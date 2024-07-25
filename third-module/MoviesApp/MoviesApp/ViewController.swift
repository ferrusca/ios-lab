//
//  ViewController.swift
//  CollectionViewTableCell
//
//  Created by Jorge Ferrusca on 10/14/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(nibName: "CollectionViewTableViewCell", bundle: nil),
            forCellReuseIdentifier: "foobar"
        )
        
        
    }
}

extension ViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        Genre.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Animation"
        case 1:
            return "Drama"
        case 2:
            return "Fantasy"
        default:
            return "Unknown"
        }
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foobar") as? CollectionViewTableViewCell
        
        var genre: Genre!
        
        switch indexPath.section {
        case 0:
            genre = .animation
        case 1:
            genre = .drama
        case 2:
            genre = .fantasy
        default:
            genre = .animation
        }

    
        cell?.movies = MovieModel().getMoviesFilter(genre: genre)
        
        
        return cell!
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 250
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .systemRed
           
        }
    }
}
