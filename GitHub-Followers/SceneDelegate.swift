//
//  SceneDelegate.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 13.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        UINavigationController.setUpAppearance()
        UITabBarController.setUpAppearance()
        
        window?.rootViewController = createTabBarController()
    }
    
    // MARK: - Custom Functions
    
    func createTabBarController() -> UITabBarController {
        let searchNC = UINavigationController(rootViewController: createSearchVC())
        let favoritesNC = UINavigationController(rootViewController: createFavoritesVC())
        
        let tabBar = UITabBarController()
        tabBar.setViewControllers([searchNC, favoritesNC], animated: true)
        
        return tabBar
    }
    
    func createSearchVC() -> UIViewController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return searchVC
    }
    
    func createFavoritesVC() -> UIViewController {
        let favoritesVC = FavoritesListVC()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return favoritesVC
    }
}

