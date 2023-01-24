//
//  GFFollowerItemVC.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 25.01.2023.
//

import UIKit

final class GFFollowerItemVC: GFItemInfoVC {
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
  
  private func configure() {
    leftItemInfoView.set(itemInfoType: .followers, count: user.followers)
    rightItemInfoView.set(itemInfoType: .following, count: user.following)
    actionButton.backgroundColor = .systemGreen
    actionButton.setTitle("Get Followers", for: .normal)
    actionButton.addTarget(nil, action: #selector(handleTap), for: .touchUpInside)
  }
  
  @objc private func handleTap() {
    delegate?.didTapGetFollowers(for: user)
  }
}
