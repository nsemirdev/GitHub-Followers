//
//  FollowersShowable.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import UIKit

private var containerView: UIView!

protocol FollowersShowable where Self: UIViewController {
  func showLoadingView()
}

extension FollowersShowable {
  func showLoadingView() {
    DispatchQueue.main.async {
      containerView = UIView(frame: self.view.bounds)
      self.view.addSubview(containerView)
      containerView.backgroundColor = .systemBackground
      containerView.alpha = 0

      UIView.animate(withDuration: 0.3, delay: 0) {
        containerView.alpha = 0.8
      }

      let activityIndicator = UIActivityIndicatorView(style: .large)
      containerView.addSubview(activityIndicator)
      activityIndicator.center = self.view.center
      activityIndicator.startAnimating()
    }
  }
  
  func dismissLoadingView() {
    DispatchQueue.main.async {
      containerView.removeFromSuperview()
      containerView = nil
    }
  }
  
  func showEmptyView() {
    DispatchQueue.main.async {
      containerView  = GFEmptyStateView()
      containerView.frame = self.view.bounds
      self.view.addSubview(containerView)
    }
  }
}
