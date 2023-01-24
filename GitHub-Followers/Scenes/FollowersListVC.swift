//
//  FollowersListVC.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import UIKit

final class FollowersListVC: UIViewController {
  var username: String!
  var followers = [Follower]() {
    didSet {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let width = UIScreen.main.bounds.size.width
    let padding: CGFloat = 12
    let minimumItemSpacing: CGFloat = 10
    let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
    let itemWidth = availableWidth / 3

    layout.itemSize = .init(
      width: itemWidth,
      height: itemWidth * 1.5
    )
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(GFFollowerCell.self, forCellWithReuseIdentifier: GFFollowerCell.identifier)
    return collectionView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    layout()
    fetchFollowers(on: 1)
  }

  private func fetchFollowers(on page: Int) {
    NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
      guard let self else { return }
      switch result {
      case .success(let followers):
        self.followers = followers
      case .failure(let error):
        self.presentGFAlertOnMainThread(title: "Error Occured", body: error.rawValue, buttonTitle: "Ok")
      }
    }
  }

  private func configure() {
    view.backgroundColor = .white
    navigationController?.navigationBar.prefersLargeTitles = true
    collectionView.dataSource = self
    collectionView.frame = view.bounds
  }
  
  private func layout() {
    view.addSubview(collectionView)
  }
}

extension FollowersListVC: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    followers.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GFFollowerCell.identifier, for: indexPath) as? GFFollowerCell else {
      fatalError()
    }
    cell.configure(with: Follower(
      username: followers[indexPath.row].username,
      profileImage: "avatar-placeholder")
    )
    return cell
  }
}
