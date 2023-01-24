//
//  GFItemInfoView.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import UIKit

final class GFItemInfoView: UIView {
  private let symbolImageView = UIImageView()
  private let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
  private let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)

  enum ItemInfoType {
    case repos, gists, followers, following
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
    layout()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func set(itemInfoType: ItemInfoType, count: Int) {
    switch itemInfoType {
    case .repos:
      symbolImageView.image = UIImage(systemName: "folder")
      titleLabel.text = "Public Repos"
    case .gists:
      symbolImageView.image = UIImage(systemName: "text.alignleft")
      titleLabel.text = "Public Gists"
    case .followers:
      symbolImageView.image = UIImage(systemName: "heart")
      titleLabel.text = "Followers"
    case .following:
      symbolImageView.image = UIImage(systemName: "person.2")
      titleLabel.text = "Following"
    }
    
    countLabel.text = "\(count)"
  }
  
  private func configure() {
    symbolImageView.contentMode = .scaleAspectFill
    symbolImageView.tintColor = .label
  }
  
  private func layout() {
    addSubviews(symbolImageView, titleLabel, countLabel)
    
    symbolImageView.snp.makeConstraints { make in
      make.top.leading.equalToSuperview()
      make.width.height.equalTo(20)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.centerY.equalTo(symbolImageView.snp.centerY)
      make.leading.equalTo(symbolImageView.snp.trailing).offset(12)
      make.trailing.equalToSuperview()
      make.height.equalTo(18)
    }
    
    countLabel.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(symbolImageView.snp.bottom).offset(4)
      make.height.equalTo(18)
    }
  }
}
