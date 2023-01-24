//
//  GFItemInfoVC.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import SnapKit
import UIKit

class GFItemInfoVC: UIViewController {
  private let stackView = UIStackView()
  let leftItemInfoView = GFItemInfoView()
  let rightItemInfoView = GFItemInfoView()
  let actionButton = GFButton(backgroundColor: .white, title: "Go")

  var user: User!
  weak var delegate: UserInfoVCDelegate?
  
  init(user: User) {
    self.user = user
    super.init(nibName: nil, bundle: nil)
    configure()
    layout()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

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
    stackView.addArrangedSubviews(leftItemInfoView, rightItemInfoView)

    let padding: CGFloat = 20
    stackView.snp.makeConstraints { make in
      make.leading.top.equalToSuperview().offset(padding)
      make.trailing.equalToSuperview().offset(-padding)
      make.height.equalTo(50)
    }

    actionButton.snp.makeConstraints { make in
      make.top.equalTo(stackView.snp.bottom).offset(padding)
      make.leading.equalToSuperview().offset(padding)
      make.trailing.equalToSuperview().offset(-padding)
      make.height.equalTo(44)
    }
  }
}
