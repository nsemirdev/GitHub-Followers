//
//  GFAvatarImageView.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 24.01.2023.
//

import UIKit

final class GFAvatarImageView: UIImageView {
  let placeholderImage = UIImage(named: "avatar-placeholder")
  private let cache = NetworkManager.shared.cache
  
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
    clipsToBounds = true
    image = placeholderImage
  }
  
  private func updateImageOnMainThread(data: Data?, cacheKey: String) {
    DispatchQueue.main.async {
      guard let data else {
        self.image = self.placeholderImage
        return
      }
      let image = UIImage(data: data) ?? self.placeholderImage
      self.cache.setObject(image!, forKey: NSString(string: cacheKey))
      self.image = image
    }
  }
  
  func downloadImage(from urlString: String) {
    if let image = cache.object(forKey: NSString(string: urlString)) {
      self.image = image
      return
    }
    
    guard let url = URL(string: urlString) else { return }
    let req = URLRequest(url: url)
    URLSession.shared.dataTask(with: req) { [weak self] data, _, error in
      guard let self else { return }
      guard let data, error == nil else {
        self.updateImageOnMainThread(data: nil, cacheKey: "")
        return
      }
      self.updateImageOnMainThread(data: data, cacheKey: urlString)
    }.resume()
  }
}
