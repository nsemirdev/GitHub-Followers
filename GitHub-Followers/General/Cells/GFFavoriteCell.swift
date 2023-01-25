//
//  GFFavoriteCell.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 25.01.2023.
//

import SnapKit
import UIKit

final class GFFavoriteCell: UITableViewCell {
  static let identifier = "GFFavoriteCell"
  private let profileImageView = GFAvatarImageView(frame: .zero)
  private let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configure()
    layout()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configure() {
    accessoryType = .disclosureIndicator
  }

  private func layout() {
    addSubviews(profileImageView, usernameLabel)
    let padding: CGFloat = 12

    profileImageView.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().offset(padding)
      make.height.width.equalTo(60)
    }

    usernameLabel.snp.makeConstraints { make in
      make.leading.equalTo(profileImageView.snp.trailing).offset(padding * 2)
      make.trailing.equalToSuperview().offset(-padding)
      make.centerY.equalTo(profileImageView.snp.centerY)
      make.height.equalTo(40)
    }
  }

  func set(favorite: Follower) {
    usernameLabel.text = favorite.username
    profileImageView.downloadImage(from: favorite.profileImage)
  }
}
