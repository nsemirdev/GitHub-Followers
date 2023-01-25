//
//  FollowersListVC.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import UIKit

final class FollowersListVC: UIViewController {
  var username: String!
  var currentPage = 1
  var followers = [Follower]()
  var filteredFollowers = [Follower]()
  
  private var hasMoreFollowers = true
  private var isSearching = false
  
  private enum Section {
    case main
  }
  
  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let width = UIScreen.main.bounds.size.width
    let padding: CGFloat = 12
    let minimumItemSpacing: CGFloat = 10
    let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
    let itemWidth = availableWidth / 3
    
    layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)

    layout.itemSize = .init(
      width: itemWidth,
      height: itemWidth * 1.5)
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(GFFollowerCell.self, forCellWithReuseIdentifier: GFFollowerCell.identifier)
    return collectionView
  }()
  
  private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Follower> = {
    let dataSource = UICollectionViewDiffableDataSource<Section, Follower>(
      collectionView: collectionView,
      cellProvider: { collectionView, indexPath, follower in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GFFollowerCell.identifier, for: indexPath) as! GFFollowerCell
        cell.configure(with: follower)
        return cell
      })
    
    return dataSource
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    layout()
    fetchFollowers(on: currentPage)
  }
  
  private func updateData(on followers: [Follower]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
    snapshot.appendSections([.main])
    snapshot.appendItems(followers)
    DispatchQueue.main.async {
      self.dataSource.apply(snapshot, animatingDifferences: true)
    }
  }

  private func fetchFollowers(on page: Int) {
    showLoadingView()
    NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
      guard let self else { return }
      self.dismissLoadingView()
      guard self.hasMoreFollowers else { return }
      
      switch result {
      case .success(let followers):
        self.hasMoreFollowers = followers.count < 100 ? false : true
        self.followers += followers
        self.updateData(on: self.followers)
        if self.followers.isEmpty {
          self.showEmptyView(title: "This user doesn't have any followers 🥹. Go follow them 😄.")
          return
        }
        self.currentPage += 1
      case .failure(let error):
        self.presentGFAlertOnMainThread(title: "Error Occured", body: error.rawValue, buttonTitle: "Ok")
      }
    }
  }

  private func configure() {
    view.backgroundColor = .white
    navigationController?.navigationBar.prefersLargeTitles = true
    collectionView.dataSource = dataSource
    collectionView.delegate = self
    collectionView.frame = view.bounds
    
    let searchController = UISearchController()
    searchController.searchResultsUpdater = self
    searchController.searchBar.placeholder = "Search for a username"
    navigationItem.searchController = searchController
    
    let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddButton))
    navigationItem.rightBarButtonItem = addBarButton
  }
  
  @objc private func handleAddButton() {
    NetworkManager.shared.getUser(for: username) { [weak self] result in
      guard let self else { return }
      switch result {
      case .success(let user):
        let favorite = Follower(username: user.username, profileImage: user.profileImage)
        PersistenceManager.shared.updateWith(favorite: favorite, actionType: .add) { [weak self] str in
          guard let self else { return }
          guard str == nil else {
            self.presentGFAlertOnMainThread(title: "Something went wrong", body: str!, buttonTitle: "Ok")
            return
          }
          self.presentGFAlertOnMainThread(
            title: "Success!",
            body: "You have successfully favorited this user 🎉.",
            buttonTitle: "Ok")
        }
      case .failure(let error):
        self.presentGFAlertOnMainThread(title: "Something went wrong", body: error.rawValue, buttonTitle: "Ok")
      }
    }
  }
  
  private func layout() {
    view.addSubview(collectionView)
  }
}

extension FollowersListVC: UICollectionViewDelegate {
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let offSetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let height = scrollView.frame.size.height
    
    if offSetY + height > contentHeight {
      fetchFollowers(on: currentPage)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let activeArray = isSearching ? filteredFollowers : followers
    let follower = activeArray[indexPath.item]
    
    let destVC = UserInfoVC()
    destVC.delegate = self
    destVC.username = follower.username
    let navController = UINavigationController(rootViewController: destVC)
    present(navController, animated: true)
  }
}

extension FollowersListVC: FollowersShowable {}

extension FollowersListVC: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let filter = searchController.searchBar.text, !filter.isEmpty else {
      updateData(on: followers)
      return
    }
    isSearching = true
    filteredFollowers = followers.filter {
      $0.username.lowercased().contains(filter.lowercased())
    }
    updateData(on: filteredFollowers)
  }
}

extension FollowersListVC: FollowersListVCDelegate {
  func didTapGetFollowersButton(for user: User) {
    currentPage = 1
    username = user.username
    followers = []
    filteredFollowers = []
    isSearching = false
    hasMoreFollowers = true
    title = user.username
    fetchFollowers(on: currentPage)
  }
}
