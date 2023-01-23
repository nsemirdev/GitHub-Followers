//
//  UIView+.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import UIKit

extension UIView {
  func addsubviews(_ subviews: UIView...) {
    subviews.forEach {
      addSubview($0)
    }
  }
}
