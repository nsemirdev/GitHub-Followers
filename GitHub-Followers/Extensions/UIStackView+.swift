//
//  UIStackView+.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 25.01.2023.
//

import UIKit

extension UIStackView {
  func addArrangedSubviews(_ subviews: UIView...) {
    subviews.forEach {
      addArrangedSubview($0)
    }
  }
}
