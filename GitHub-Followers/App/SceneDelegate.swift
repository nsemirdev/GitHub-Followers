//
//  SceneDelegate.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 23.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = MainBuilder.createTabBar()
    window?.makeKeyAndVisible()
  }
}
