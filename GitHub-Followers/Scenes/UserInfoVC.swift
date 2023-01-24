//
//  UserInfoVC.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import SnapKit
import UIKit

final class UserInfoVC: UIViewController {
  var username: String!
  let headerView = UIView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureNavBar()
    fetchUser()
    layout()
  }
  
  private func configureNavBar() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    navigationItem.scrollEdgeAppearance = appearance
    
    let doneBarButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneBarButton
  }
  
  @objc private func dismissVC() {
    dismiss(animated: true)
  }
  
  private func layout() {
    view.addSubview(headerView)
    headerView.backgroundColor = .systemPink
    
    headerView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(180)
    }
  }
  
  private func add(childVC: UIViewController, to containerView: UIView) {
    addChild(childVC)
    containerView.addSubview(childVC.view)
    childVC.view.frame = containerView.bounds
    childVC.didMove(toParent: self)
  }
  
  private func fetchUser() {
    NetworkManager.shared.getUser(for: username) { [weak self] result in
      guard let self else { return }
      
      switch result {
      case .success(let user):
        DispatchQueue.main.async {
          self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        }
      case .failure(let failure):
        self.presentGFAlertOnMainThread(title: "Error Occured", body: failure.rawValue, buttonTitle: "Ok")
      }
    }
  }
}
