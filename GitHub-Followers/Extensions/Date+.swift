//
//  Date+.swift
//  GitHub-Followers
//
//  Created by Emir Alkal on 25.01.2023.
//

import Foundation

extension Date {
  func convertToString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy"
  
    return dateFormatter.string(from: self)
  }
}
