//
//  GFItemInfoVC.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import SnapKit
import UIKit

final class GFItemInfoVC: UIViewController {
  private let stackView = UIStackView()
  private let topItemInfoView = GFItemInfoView()
  private let bottomItemInfoView = GFItemInfoView()
  private let actionButton = GFButton(backgroundColor: .white, title: "Go")

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  private func configure() {
    view.layer.cornerRadius = 18
    view.backgroundColor = .secondarySystemBackground
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
  }

  private func layout() {
    view.addSubviews(stackView, actionButton)
    stackView.addArrangedSubviews(topItemInfoView, bottomItemInfoView)
    
    let padding: CGFloat = 20
    stackView.snp.makeConstraints { make in
      make.leading.top.leading.equalToSuperview().offset(padding)
      make.trailing.equalToSuperview().offset(-padding)
      make.height.equalTo(50)
    }

    actionButton.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().offset(padding)
      make.trailing.equalToSuperview().offset(-padding)
      make.height.equalTo(44)
    }
  }
}
