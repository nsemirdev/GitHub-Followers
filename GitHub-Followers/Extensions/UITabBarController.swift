//
//  UITabBarController.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 13.12.2022.
//

import UIKit

extension UITabBarController {
    static func setUpAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().tintColor = .label
    }
}
