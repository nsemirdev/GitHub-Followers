//
//  SearchVC.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 13.12.2022.
//

import UIKit
import SnapKit

class SearchVC: UIViewController {
    
    // MARK: - UI Elements
    
    let logoImageView       = UIImageView(image: UIImage(named: "gh-logo")!)
    let usernameTextField   = GFTextField()
    let searchButton        = GFButton(title: "Get Followers", backgroundColor: .systemGreen)
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Custom Functions
    
    private func configure() {
        configureImageView()
        configureTextField()
        configureButton()
        createTapGesture()
    }
    
    private func configureImageView() {
        view.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(80)
            make.width.height.equalTo(200)
        }
    }
    
    private func configureTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        usernameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.logoImageView.snp.bottom).offset(60)
            make.leading.equalTo(self.view.snp.leading).offset(50)
            make.trailing.equalTo(view.snp.trailing).offset(-50)
            make.height.equalTo(50)
        }
    }
    
    private func configureButton() {
        view.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        searchButton.snp.makeConstraints { make in
            make.leading.equalTo(self.usernameTextField.snp.leading)
            make.trailing.equalTo(self.usernameTextField.snp.trailing)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            make.height.equalTo(50)
        }
    }
    
    private func createTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC() {
        guard !usernameTextField.text!.isEmpty else { return }
        
        let followerListVC = FollowerListVC()
        followerListVC.username = usernameTextField.text
        followerListVC.title = usernameTextField.text
        
        navigationController?.pushViewController(followerListVC, animated: true)
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            pushFollowerListVC()
            return true
        }
        return false
    }
}
