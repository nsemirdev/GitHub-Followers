//
//  FollowersListVC.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import UIKit

final class FollowersListVC: UIViewController {
  var username: String!

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    navigationController?.navigationBar.prefersLargeTitles = true
  }
}
