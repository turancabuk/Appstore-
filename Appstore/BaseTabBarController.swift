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
        
        
        let appViewController = UIViewController()
        appViewController.view.backgroundColor = .white
        appViewController.navigationItem.title = "Apps"
        
        let appNavViewController = UINavigationController(rootViewController: appViewController)
        appNavViewController.tabBarItem.title = "Apps"
        appNavViewController.navigationBar.prefersLargeTitles = true
        appNavViewController.tabBarItem.image = UIImage(named: "apps")
        
        
        let searchViewController = UIViewController()
        searchViewController.view.backgroundColor = .white
        searchViewController.navigationItem.title = "Search"
        
        let searchNavViewController = UINavigationController(rootViewController: searchViewController)
        searchNavViewController.tabBarItem.title = "Search"
        searchNavViewController.tabBarItem.image = UIImage(imageLiteralResourceName: "search")
        searchNavViewController.navigationBar.prefersLargeTitles = true
        
        viewControllers = [
        appNavViewController,
        searchNavViewController
        ]
    }
}
