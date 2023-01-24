//
//  GFFollowerCell.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import SnapKit
import UIKit

final class GFFollowerCell: UICollectionViewCell {
  static let identifier = "GFFollowerCell"

  private let avatarImageView = GFAvatarImageView(frame: .zero)
  private let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)

  private let padding: CGFloat = 8

  override init(frame: CGRect) {
    super.init(frame: frame)
    layout()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    usernameLabel.text = nil
    avatarImageView.image = nil
  }

  private func layout() {
    contentView.addSubviews(avatarImageView, usernameLabel)

    avatarImageView.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().offset(padding)
      make.trailing.equalToSuperview().offset(-padding)
      make.height.equalTo(avatarImageView.snp.width)
    }

    usernameLabel.snp.makeConstraints { make in
      make.top.equalTo(avatarImageView.snp.bottom).offset(12)
      make.leading.equalToSuperview().offset(padding)
      make.trailing.equalToSuperview().offset(-padding)
      make.height.equalTo(20)
    }
  }
  
  func configure(with follower: Follower) {
    usernameLabel.text = follower.username
    avatarImageView.image = UIImage(named: "avatar-placeholder")
  }
}
