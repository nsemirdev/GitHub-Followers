//
//  MainBuilder.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import UIKit

struct MainBuilder {
  // MARK: - Internal interface
  
  static func createTabBar() -> UITabBarController {
    let tabBar = UITabBarController()
    tabBar.viewControllers = [
      createSearchNavigationController(),
      createFavoritesNavigationController()
    ]
    
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    
    UITabBar.appearance().standardAppearance = appearance
    UITabBar.appearance().scrollEdgeAppearance = appearance
    UITabBar.appearance().tintColor = .systemGreen
    
    setUpNavBarAppearance()
    
    return tabBar
  }
  
  // MARK: - Private interface
  
  private static func createFavoritesNavigationController() -> UINavigationController {
    let favoritesVC = FavoritesListVC()
    favoritesVC.title = "Favorites"
    favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
    
    return UINavigationController(rootViewController: favoritesVC)
  }
  
  private static func createSearchNavigationController() -> UINavigationController {
    let searchVC = SearchVC()
    searchVC.title = "Search"
    searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
    
    return UINavigationController(rootViewController: searchVC)
  }
  
  private static func setUpNavBarAppearance() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithTransparentBackground()
    
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    UINavigationBar.appearance().tintColor = .systemGreen
  }
}
