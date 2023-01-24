//
//  Follower.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import Foundation

struct Follower: Decodable {
  let uuid = UUID()
  let username: String
  let profileImage: String

  enum CodingKeys: String, CodingKey {
    case username = "login"
    case profileImage = "avatar_url"
  }
}

extension Follower: Hashable {
  static func ==(lhs: Follower, rhs: Follower) -> Bool {
    return lhs.uuid == rhs.uuid
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(uuid)
  }
}
