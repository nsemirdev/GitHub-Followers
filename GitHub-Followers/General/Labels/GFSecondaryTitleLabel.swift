//
//  GFSecondaryTitleLabel.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import UIKit

final class GFSecondaryTitleLabel: UILabel {
  init(fontSize: CGFloat) {
    super.init(frame: .zero)
    textColor = .secondaryLabel
    adjustsFontSizeToFitWidth = true
    minimumScaleFactor = 0.90
    lineBreakMode = .byTruncatingTail
    font = .systemFont(ofSize: fontSize, weight: .medium)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
