//
//  SearchVC.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import SnapKit
import UIKit

final class SearchVC: UIViewController {
  private let logoImageView = UIImageView()
  private let usernameTextField = GFTextField()
  private let getFollowersButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")

  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    layout()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: true)
    usernameTextField.text = ""
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }

  private func configure() {
    view.backgroundColor = .systemBackground
    logoImageView.image = UIImage(named: "gh-logo")
    let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
    view.addGestureRecognizer(tapGesture)
    usernameTextField.delegate = self
    getFollowersButton.addTarget(nil, action: #selector(pushFollowersListVC), for: .touchUpInside)
  }

  @objc private func pushFollowersListVC() {
    guard !usernameTextField.text!.isEmpty else {
      presentGFAlertOnMainThread(
        title: "Empty Username",
        body: "Please enter a username. We need to know who to look for 😄",
        buttonTitle: "ok"
      )
      return
    }

    usernameTextField.resignFirstResponder()
    let followersListVC = FollowersListVC()
    followersListVC.username = usernameTextField.text
    followersListVC.title = usernameTextField.text
    navigationController?.pushViewController(followersListVC, animated: true)
  }

  // Auto layout
  private func layout() {
    view.addSubviews(logoImageView, usernameTextField, getFollowersButton)

    logoImageView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
      make.centerX.equalToSuperview()
      make.height.width.equalTo(200)
    }

    usernameTextField.snp.makeConstraints { make in
      make.top.equalTo(logoImageView.snp.bottom).offset(50)
      make.leading.equalToSuperview().offset(50)
      make.trailing.equalToSuperview().offset(-50)
      make.height.equalTo(50)
    }

    getFollowersButton.snp.makeConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
      make.leading.equalToSuperview().offset(50)
      make.trailing.equalToSuperview().offset(-50)
      make.height.equalTo(50)
    }
  }
}

extension SearchVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    pushFollowersListVC()
    return true
  }
}
