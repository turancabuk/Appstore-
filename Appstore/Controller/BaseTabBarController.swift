//
//  BaseTabBarController.swift
//  Appstore
//
//  Created by Turan Çabuk on 3.01.2024.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
        createNavController(viewController: AppsPageController(), title: "Apps", imageName: "apps"),
        createNavController(viewController: AppsSearchController(), title: "Search", imageName: "search"),
        createNavController(viewController: UIViewController(), title: "Today", imageName: "today_icon"),
        ]
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.navigationBar.prefersLargeTitles = true
        
        viewController.view.backgroundColor = .white
        viewController.navigationItem.title = title
        
        return navController
    }
}
