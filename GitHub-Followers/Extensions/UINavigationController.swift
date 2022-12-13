//
//  UINavigationController.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 13.12.2022.
//

import UIKit

extension UINavigationController {
    static func setUpAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
