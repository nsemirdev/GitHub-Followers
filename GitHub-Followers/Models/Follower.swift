//
//  Follower.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import Foundation

struct Follower: Decodable {
  let username: String
  let profileImage: String

  enum CodingKeys: String, CodingKey {
    case username = "login"
    case profileImage = "avatar_url"
  }
}
