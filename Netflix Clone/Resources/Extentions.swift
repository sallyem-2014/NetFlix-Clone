//
//  Extentions.swift
//  Netflix Clone
//
//  Created by Sally on 11/08/2024.
//

import Foundation

extension String {
  
  func capitalizeFirstLetter() -> String {
    return self.prefix(1).uppercased() + self.lowercased().dropFirst()
  }
}
