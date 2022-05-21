//
//  MainViewController.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

import UIKit

final class MainViewController: UITabBarController {
    
    private lazy var homeTabBarItem: UITabBarItem = {
        let item: UITabBarItem = UITabBarItem(title: "Home",
                                              image: UIImage(systemName: "house"),
                                              selectedImage: UIImage(systemName: "house.fill"))
        return item
    }()
    
    private lazy var homeTab: UIViewController = {
        let viewController: UIViewController = HomeViewController()
        viewController.tabBarItem = homeTabBarItem
        return viewController
    }()
    
    private lazy var searchTabBarItem: UITabBarItem = {
        let item: UITabBarItem = UITabBarItem(title: "Search",
                                              image: UIImage(systemName: "magnifyingglass.circle"),
                                              selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        return item
    }()
    
    private lazy var searchTab: UIViewController = {
        let viewController: UIViewController = SearchViewController()
        viewController.tabBarItem = searchTabBarItem
        return viewController
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewControllers = [homeTab,
                           searchTab]
    }
}
