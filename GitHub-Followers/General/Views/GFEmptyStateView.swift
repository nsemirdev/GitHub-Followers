//
//  GFEmptyView.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import SnapKit
import UIKit

final class GFEmptyStateView: UIView {
  private let informationLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
  private let backgroundImageView = UIImageView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
    layout()
  }
  
  init(title: String) {
    super.init(frame: .zero)
    configure()
    layout()
    informationLabel.text = title
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configure() {
    informationLabel.numberOfLines = 3
    informationLabel.textColor = .secondaryLabel
    backgroundImageView.image = UIImage(named: "empty-state-logo")
  }

  private func layout() {
    addSubviews(informationLabel, backgroundImageView)

    informationLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview().offset(-150)
      make.leading.equalToSuperview().offset(40)
      make.trailing.equalToSuperview().offset(-40)
      make.height.equalTo(200)
    }
    
    backgroundImageView.snp.makeConstraints { make in
      make.height.equalTo(UIScreen.main.bounds.size.width * 1.3)
      make.width.equalTo(UIScreen.main.bounds.size.width * 1.3)
      make.trailing.equalToSuperview().offset(170)
      make.bottom.equalToSuperview().offset(40)
    }
  }
}
