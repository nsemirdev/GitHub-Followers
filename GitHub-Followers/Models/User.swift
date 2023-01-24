//
//  User.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import Foundation

struct User: Decodable {
  let username: String
  let profileImage: String
  let name: String?
  let location: String?
  let bio: String?
  let publicRepos: Int
  let publicGists: Int
  let htmlUrl: String
  let following: Int
  let followers: Int
  let createdAt: String

  private enum CodingKeys: String, CodingKey {
    case username = "login"
    case profileImage = "avatar_url"
    case name, location, bio
    case publicRepos = "public_repos"
    case publicGists = "public_gists"
    case htmlUrl = "html_url"
    case following, followers
    case createdAt = "created_at"
  }
}
