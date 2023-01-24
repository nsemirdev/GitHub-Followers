//
//  GFRepoItemVC.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 25.01.2023.
//

import UIKit

final class GFRepoItemVC: GFItemInfoVC {
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }

  private func configure() {
    leftItemInfoView.set(itemInfoType: .repos, count: user.publicRepos)
    rightItemInfoView.set(itemInfoType: .gists, count: user.publicGists)
    actionButton.backgroundColor = .systemPurple
    actionButton.setTitle("Github Profile", for: .normal)
    actionButton.addTarget(nil, action: #selector(handleTap), for: .touchUpInside)
  }
  
  @objc private func handleTap() {
    delegate?.didTapGithubProfile(for: user)
  }
}
