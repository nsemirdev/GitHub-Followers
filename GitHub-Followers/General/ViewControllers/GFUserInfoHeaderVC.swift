//
//  GFUserInfoHeaderVC.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import SnapKit
import UIKit

final class GFUserInfoHeaderVC: UIViewController {
  private let avatarImageView = GFAvatarImageView(frame: .zero)
  private let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
  private let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
  private let locationImageView = UIImageView()
  private let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
  private let bioLabel = GFBodyLabel(textAlignment: .left)
  
  var user: User!
  
  init(user: User!) {
    self.user = user
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    layout()
  }
  
  private func configure() {
    avatarImageView.downloadImage(from: user.profileImage)
    locationImageView.image = UIImage(systemName: "mappin.and.ellipse")
    locationImageView.tintColor = .secondaryLabel
    usernameLabel.text = user.username
    nameLabel.text = user.name ?? "N/A"
    locationLabel.text = user.location ?? "No Location"
    bioLabel.text = user.bio ?? "No bio available"
    bioLabel.numberOfLines = 3
  }
  
  private func layout() {
    view.addSubviews(
      avatarImageView, usernameLabel, nameLabel,
      locationImageView, locationLabel, bioLabel
    )
    
    let padding: CGFloat = 20
    let textImagePadding: CGFloat = 12
    
    avatarImageView.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().offset(padding)
      make.width.height.equalTo(90)
    }
    
    usernameLabel.snp.makeConstraints { make in
      make.top.equalTo(avatarImageView.snp.top)
      make.leading.equalTo(avatarImageView.snp.trailing).offset(textImagePadding)
      make.trailing.equalToSuperview().offset(-padding)
      make.height.equalTo(38)
    }
    
    nameLabel.snp.makeConstraints { make in
      make.centerY.equalTo(avatarImageView.snp.centerY).offset(8)
      make.leading.equalTo(avatarImageView.snp.trailing).offset(textImagePadding)
      make.trailing.equalToSuperview().offset(-padding)
      make.height.equalTo(20)
    }
    
    locationImageView.snp.makeConstraints { make in
      make.bottom.equalTo(avatarImageView.snp.bottom)
      make.leading.equalTo(avatarImageView.snp.trailing).offset(textImagePadding)
      make.width.height.equalTo(20)
    }
    
    locationLabel.snp.makeConstraints { make in
      make.centerY.equalTo(locationImageView.snp.centerY)
      make.leading.equalTo(locationImageView.snp.trailing).offset(5)
      make.trailing.equalToSuperview().offset(-padding)
      make.height.equalTo(20)
    }
    
    bioLabel.snp.makeConstraints { make in
      make.top.equalTo(avatarImageView.snp.bottom).offset(textImagePadding)
      make.leading.equalTo(avatarImageView.snp.leading)
      make.trailing.equalToSuperview().offset(-padding)
      make.bottom.equalToSuperview()
    }
  }
}
