//
//  String+.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 25.01.2023.
//

import Foundation

extension String {
  func convertToDate() -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = .current
    
    return dateFormatter.date(from: self)
  }
}
