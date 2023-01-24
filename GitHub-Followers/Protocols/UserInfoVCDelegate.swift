//
//  UserInfoVCDelegate.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 25.01.2023.
//

import Foundation

protocol UserInfoVCDelegate: AnyObject {
  func didTapGithubProfile(for user: User)
  func didTapGetFollowers(for user: User)
}
