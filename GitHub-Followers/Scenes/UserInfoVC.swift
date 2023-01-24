//
//  UserInfoVC.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import UIKit

final class UserInfoVC: UIViewController {
  var username: String!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureNavBar()
    fetchUser()
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
  
  private func fetchUser() {
    NetworkManager.shared.getUser(for: username) { [weak self] result in
      guard let self else { return }
      
      switch result {
      case .success(let user):
        print(user)
      case .failure(let failure):
        self.presentGFAlertOnMainThread(title: "Error Occured", body: failure.rawValue, buttonTitle: "Ok")
      }
    }
  }
}
