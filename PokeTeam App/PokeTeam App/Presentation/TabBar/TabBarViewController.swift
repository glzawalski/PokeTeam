//
//  TabBarViewController.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

import UIKit
import SwiftUI

final class TabBarViewController: UITabBarController {
    
    private lazy var homeTabBarItem: UITabBarItem = {
        let item: UITabBarItem = UITabBarItem(title: "Home",
                                              image: UIImage(systemName: "house"),
                                              selectedImage: UIImage(systemName: "house.fill"))
        return item
    }()
    
    private lazy var homeTab: UIViewController = {
        let homeView = HomeView().environmentObject(HomeViewModel()).environmentObject(AppState())
        let viewController: UIHostingController = UIHostingController(rootView: homeView)
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
    
    private lazy var teamTabBarItem: UITabBarItem = {
        let item: UITabBarItem = UITabBarItem(title: "Team",
                                              image: UIImage(systemName: "rectangle.grid.2x2"),
                                              selectedImage: UIImage(systemName: "rectangle.grid.2x2.fill"))
        return item
    }()
    
    private lazy var teamTab: UIViewController = {
        let viewController: UIViewController = TeamView()
        viewController.tabBarItem = teamTabBarItem
        return viewController
    }()
    
    override func viewDidLoad() {
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewControllers = [homeTab,
                           searchTab,
                           teamTab]
    }
}
