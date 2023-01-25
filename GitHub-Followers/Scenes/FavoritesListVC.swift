//
//  FavoritesListVC.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import UIKit

final class FavoritesListVC: UIViewController {
  var favorites = [Follower]() {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
        self.view.bringSubviewToFront(self.tableView)
      }
    }
  }
  
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(GFFavoriteCell.self, forCellReuseIdentifier: GFFavoriteCell.identifier)
    tableView.rowHeight = 80
    
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    tableView.dataSource = self
    tableView.delegate = self
    view.addSubview(tableView)
    showEmptyView(title: "No Favorites?\nAdd one on the followers screen.")
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    fetchFavorites()
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  private func fetchFavorites() {
    PersistenceManager.shared.retrieveFavorites { [weak self] result in
      guard let self else { return }
      
      switch result {
      case .success(let favorites):
        if !favorites.isEmpty {
          self.favorites = favorites
          
        }
      case .failure(let error):
        self.presentGFAlertOnMainThread(title: "Error", body: error.localizedDescription, buttonTitle: "Ok")
      }
    }
  }
}

extension FavoritesListVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    favorites.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: GFFavoriteCell.identifier, for: indexPath) as? GFFavoriteCell else {
      fatalError()
    }
    
    cell.set(favorite: favorites[indexPath.row])
    return cell
  }
}

extension FavoritesListVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

extension FavoritesListVC: FollowersShowable {}
