//
//  NetworkManager.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import Foundation

final class NetworkManager {
  static let shared = NetworkManager()
  private init() {}

  enum GFError: String, Error {
    case noUsername = "This username created an invalid request. Please try again."
    case internetIssue = "Unable to complete your request. Please check your internet connection."
    case invalidData = "No data received from the server"
    case canNotDecode = "The data received from the server was unexpected"
  }

  let baseURL = "https://api.github.com/"

  func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void) {
    let wholeURL = baseURL + "users/" + username + "/followers?per_page=100&page=\(page)"
    guard let url = URL(string: wholeURL) else {
      completion(.failure(.noUsername))
      return
    }
    let req = URLRequest(url: url)

    URLSession.shared.dataTask(with: req) { data, _, error in
      guard let data, error == nil else {
        completion(.failure(error != nil ? .internetIssue : .invalidData))
        return
      }
      do {
        let responseData = try JSONDecoder().decode([Follower].self, from: data)
        completion(.success(responseData))
      } catch {
        completion(.failure(.canNotDecode))
      }
    }.resume()
  }
}
