//
//  MainViewController.swift
//  Tourism
//
//  Created by Adhitya Bagas on 13/08/22.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTabBarView()
    }
    
    private func srtupNavigationBar() {
        
    }
    
    private func initTabBarView() {
        let vcHome = UINavigationController(rootViewController: HomeViewController())
        let vcProfile = UINavigationController(rootViewController: ProfileViewController())
        
        vcHome.tabBarItem.image = iconHome
        vcProfile.tabBarItem.image = iconProfile
        
        vcHome.tabBarItem.title = "Home"
        vcProfile.tabBarItem.title = "Profile"
        
        tabBar.tintColor = primaryColor
        tabBar.backgroundColor = .white
        
        setViewControllers([vcHome, vcProfile], animated: true)
        
    }
}
