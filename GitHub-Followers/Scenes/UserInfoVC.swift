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
  private let headerView = UIView()
  private let topItemView = UIView()
  private let bottomItemView = UIView()
  private let dateLabel = GFBodyLabel(textAlignment: .center)
  
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
    view.addSubviews(headerView, topItemView, bottomItemView, dateLabel)
    
    headerView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(180)
    }
    
    topItemView.snp.makeConstraints { make in
      make.top.equalTo(headerView.snp.bottom).offset(20)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
      make.height.equalTo(140)
    }
    
    bottomItemView.snp.makeConstraints { make in
      make.top.equalTo(topItemView.snp.bottom).offset(20)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
      make.height.equalTo(140)
    }
    
    dateLabel.snp.makeConstraints { make in
      make.top.equalTo(bottomItemView.snp.bottom).offset(20)
      make.centerX.equalToSuperview()
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
          self.add(childVC: GFRepoItemVC(user: user), to: self.topItemView)
          self.add(childVC: GFFollowerItemVC(user: user), to: self.bottomItemView)
          self.dateLabel.text = "GitHub since \(user.createdAt.convertToDate()?.convertToString() ?? "N/A")"
        }
      case .failure(let failure):
        self.presentGFAlertOnMainThread(title: "Error Occured", body: failure.rawValue, buttonTitle: "Ok")
      }
    }
  }
}
