//
//  GFAlertVC.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import UIKit

final class GFAlertVC: UIViewController {
  private let containerView = UIView()
  private let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
  private let bodyLabel = GFBodyLabel(textAlignment: .center)
  private let actionButton = GFButton(backgroundColor: .systemPink, title: "Ok")
  
  var alertTitle: String!
  var message: String!
  var buttonTitle: String!
  let padding: CGFloat = 20
  
  init(alertTitle: String, message: String, buttonTitle: String) {
    super.init(nibName: nil, bundle: nil)
    self.alertTitle = alertTitle
    self.message = message
    self.buttonTitle = buttonTitle
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    layout()
  }
  
  private func configure() {
    view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
    containerView.layer.cornerRadius = 16
    containerView.layer.borderColor = UIColor.white.cgColor
    containerView.layer.borderWidth = 2
    containerView.backgroundColor = .systemBackground
    
    titleLabel.text = alertTitle
    bodyLabel.text = message
    actionButton.setTitle(buttonTitle, for: .normal)
    actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    bodyLabel.numberOfLines = 0
  }
  
  @objc private func dismissVC() { dismiss(animated: true) }
  
  private func layout() {
    view.addSubview(containerView)
    containerView.addsubviews(titleLabel, bodyLabel, actionButton)
    
    containerView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.width.equalTo(280)
      make.height.equalTo(220)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().offset(padding)
      make.trailing.equalToSuperview().offset(-padding)
      make.height.equalTo(28)
    }
    
    actionButton.snp.makeConstraints { make in
      make.bottom.trailing.equalToSuperview().offset(-padding)
      make.leading.equalToSuperview().offset(padding)
      make.height.equalTo(44)
    }
    
    bodyLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(8)
      make.bottom.equalTo(actionButton.snp.top).offset(-8)
      make.leading.equalToSuperview().offset(padding)
      make.trailing.equalToSuperview().offset(-padding)
    }
  }
}
