//
//  UIViewController+.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import UIKit

extension UIViewController {
  func presentGFAlertOnMainThread(title: String, body: String, buttonTitle: String) {
    let alert = GFAlertVC(alertTitle: title, message: body, buttonTitle: buttonTitle)
    alert.modalPresentationStyle = .overFullScreen
    alert.modalTransitionStyle = .crossDissolve
    DispatchQueue.main.async {
      self.present(alert, animated: true)
    }
  }
}
