//
//  This file is for educational purposes only. It may contain code snippets, examples, images, and explanations
//  intended to help understand concepts and improve programming skills.
//

import UIKit

class PostsViewController: UITableViewController {
    
    private var postsModel = PostsModel()
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        tabBarItem.image = UIImage(systemName: "text.viewfinder")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Post"
        if let user = Settings.user {
            try? postsModel.getUserPosts(userId: user.id)
        }
        tableView.reloadData()

//        setupTableView()
    }
}


//MARK: - Delegate and data source methods
extension PostsViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") ?? UITableViewCell(style: .default, reuseIdentifier: "postCell")
        
        var cellContent = cell.defaultContentConfiguration()
        cellContent.text = postsModel.post(for: indexPath.section).body
        cell.contentConfiguration = cellContent;
      
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        postsModel.getNumberOfPosts()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
}
