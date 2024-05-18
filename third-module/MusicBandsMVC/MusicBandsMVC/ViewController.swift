//
//  ViewController.swift
//  MusicBandsMVC
//
//  Created by Jorge Ferrusca on 18/05/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let bandModel = BandModel();
    let albumModel = AlbumModel();

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        bandModel.getMainTitle()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bandModel.getDataLength()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "myCell")
        }
        
        var cellContent = cell?.defaultContentConfiguration()
        cellContent?.text = bandModel.getBand(indexPath)
        cellContent?.secondaryText = "this is the subtitle"
        
        cell?.contentConfiguration = cellContent;
        
        return cell!
        
    }
}

func foo() {
    print("hola")
}

// Handle row's click
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bandName = bandModel.getBand(indexPath)
        
        let albums = albumModel.getBandAlbums(band: bandName)
        
        let customTableViewController = CustomTableViewController(nibName: "CustomTableView", bundle: nil)
        
        var sections = [Section]()
        
        for album in albums {
            sections.append(
                Section(
                    rows: [
                        CustomTableViewRow(
                            title: album.name, 
                            subtitle: "\(album.releaseYear)", imagePath: album.coverPath,
                             
                            onRowClick: {
                                let customTableViewController = CustomTableViewController(nibName: "CustomTableView", bundle: nil)
                                
                                var rows = [CustomTableViewRow]()
                                
                                for song in album.songs {
                                    rows.append(
                                        CustomTableViewRow(title: song.name, subtitle: song.duration, imagePath: album.coverPath, onRowClick: {} )
                                    )
                                }
                                
                                customTableViewController.sections = [
                                    Section(rows: rows, header: album.name)
                                ]
                                
                                self.navigationController?.pushViewController(customTableViewController, animated: true)
                            }
                        ),
                    ],
                    header: "\(album.bandName) - \(album.name)"
                )
            )
        }
        
        customTableViewController.sections = sections
              
        // push to perform horizontal navigation
      navigationController?.pushViewController(customTableViewController, animated: true)
              
    }
}


