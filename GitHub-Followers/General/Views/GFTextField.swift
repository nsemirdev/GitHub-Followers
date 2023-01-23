//
//  GFTextField.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import UIKit

final class GFTextField: UITextField {
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configure() {
    layer.cornerRadius = 10
    layer.borderWidth = 2
    layer.borderColor = UIColor.systemGray4.cgColor
    textColor = .label
    tintColor = .label
    textAlignment = .center
    font = .preferredFont(forTextStyle: .title2)
    adjustsFontSizeToFitWidth = true
    minimumFontSize = 12
    backgroundColor = .tertiarySystemBackground
    autocorrectionType = .no
    placeholder = "Enter a username"
  }
}
