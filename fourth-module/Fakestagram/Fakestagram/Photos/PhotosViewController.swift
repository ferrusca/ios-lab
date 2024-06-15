//
//  This file is for educational purposes only. It may contain code snippets, examples, images, and explanations
//  intended to help understand concepts and improve programming skills.
//

import UIKit

class PhotosViewController: UITableViewController {
    private var picturesModel = PhotosModel()
    
    // configure loader
    private var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        return view
    }()
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        tabBarItem.image = UIImage(systemName: "house.fill")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // add loader
        view.addSubview(activityIndicator)
        tableView.register(PhotoCell.self, forCellReuseIdentifier: PhotoCell.name)
        navigationItem.title = "Photos"
//        Previous version
//        try? picturesModel.getAllPhotos()
//        tableView.reloadData()
        
        // new version
        fetchPhotos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    // function when all UI elements were arranged
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // centering the loader
        activityIndicator.center = view.center
    }
    
    func fetchPhotos() {
        activityIndicator.startAnimating()
        guard let userId = Settings.user?.id else { return }
        picturesModel.getAllPhotosFromExternal(userId: "\(userId)") { [weak self] error in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                if let error {
                    print(error)
                    self?.presentErrorAlert(title: "Error", message: error.localizedDescription)
                    return
                }
                // data returned successfully, reloading table view
                self?.tableView.reloadData()
            }
            
        }
    }

}

//MARK: - Delegate and data source methods
extension PhotosViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.name, for: indexPath) as? PhotoCell,
              let photo = picturesModel.photo(for: indexPath.section) else { return UITableViewCell () }
        cell.captionedPhoto = photo
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        picturesModel.getNumberOfPhotos()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
}
