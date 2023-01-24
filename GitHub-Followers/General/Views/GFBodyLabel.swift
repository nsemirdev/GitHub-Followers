//
//  GFBodyLabel.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import UIKit

final class GFBodyLabel: UILabel {
  init(textAlignment: NSTextAlignment) {
    super.init(frame: .zero)
    self.textAlignment = textAlignment
    textColor = .secondaryLabel
    adjustsFontSizeToFitWidth = true
    minimumScaleFactor = 0.75
    lineBreakMode = .byWordWrapping
    font = .preferredFont(forTextStyle: .body)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
