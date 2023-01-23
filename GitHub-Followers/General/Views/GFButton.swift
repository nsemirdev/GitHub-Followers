//
//  GFButton.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import UIKit

final class GFButton: UIButton {
  init(backgroundColor: UIColor, title: String) {
    super.init(frame: .zero)
    self.backgroundColor = backgroundColor
    setTitle(title, for: .normal)
    configure()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configure() {
    layer.cornerRadius = 10
    titleLabel?.font = .preferredFont(forTextStyle: .headline)
    setTitleColor(.white, for: .normal)
  }
}
