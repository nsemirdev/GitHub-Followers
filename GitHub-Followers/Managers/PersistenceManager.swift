//
//  PersistenceManager.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 25.01.2023.
//

import Foundation

final class PersistenceManager {
  static let shared = PersistenceManager()
  private let defaults = UserDefaults.standard
  private init() {}

  private enum Keys: String {
    case favorites
  }

  enum PersistenceActionType {
    case add, remove
  }

  func updateWith(favorite: Follower, actionType: PersistenceActionType, completion: @escaping (String?) -> Void) {
    retrieveFavorites { [weak self] result in
      guard let self else { return }
      switch result {
      case .success(let favorites):
        var retrievedFavorites = favorites
        switch actionType {
        case .add:
          var flag = true
          retrievedFavorites.forEach {
            if $0.username == favorite.username {
              flag = false
              completion("Already in favorites.")
              return
            }
          }
          if flag {
            retrievedFavorites.append(favorite)
          }
        case .remove:
          retrievedFavorites.removeAll {
            $0.username == favorite.username
          }
        }
        completion(self.save(favorites: retrievedFavorites)?.localizedDescription)
      case .failure(let error):
        completion(error.localizedDescription)
      }
    }
  }

  func retrieveFavorites(completion: @escaping (Result<[Follower], Error>) -> Void) {
    guard let favoritesData = defaults.object(forKey: Keys.favorites.rawValue) as? Data else {
      completion(.success([]))
      return
    }

    do {
      let followers = try JSONDecoder().decode([Follower].self, from: favoritesData)
      completion(.success(followers))
    } catch {
      completion(.failure(error))
    }
  }

  func save(favorites: [Follower]) -> Error? {
    do {
      let data = try JSONEncoder().encode(favorites)
      defaults.set(data, forKey: Keys.favorites.rawValue)
      return nil
    } catch {
      return error
    }
  }
}
