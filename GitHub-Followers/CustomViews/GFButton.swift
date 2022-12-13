//
//  GFButton.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 13.12.2022.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(title: String, backgroundColor: UIColor) {
        super.init(frame: .zero)
        configure(title: title, backgroundColor: backgroundColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(title: String = "", backgroundColor: UIColor = .clear) {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
        
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
    }
}
