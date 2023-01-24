//
//  FollowersListVCDelegate.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 25.01.2023.
//

import Foundation

protocol FollowersListVCDelegate: AnyObject {
  func didTapGetFollowersButton(for user: User)
}
