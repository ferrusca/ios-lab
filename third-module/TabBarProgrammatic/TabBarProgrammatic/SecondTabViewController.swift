//
//  SecondTabViewController.swift
//  TabBarProgrammatic
//
//  Created by Jorge Ferrusca on 31/05/24.
//

import UIKit

class SecondTabViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Customizing the tab bar manually
        self.title = "Second Controller"
        self.tabBarItem.image = UIImage(systemName: "car")
        self.tabBarItem.selectedImage = UIImage(systemName: "car.fill")
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
