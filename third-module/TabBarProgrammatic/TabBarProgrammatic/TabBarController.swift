//
//  TabBarController.swift
//  TabBarProgrammatic
//
//  Created by Jorge Ferrusca on 31/05/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    let first = FirstTabViewController()
    let second = SecondTabViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // adding the view controllers and customizing tabBar
        self.setViewControllers([first, second], animated: true)
        tabBar.backgroundColor = .systemPink
        tabBar.tintColor = .white
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
