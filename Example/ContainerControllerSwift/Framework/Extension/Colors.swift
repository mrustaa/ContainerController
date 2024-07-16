//
//  Colors.swift
//  Dieta
//
//  Created by Рустам Мотыгуллин on 23.01.2022.
//

import UIKit


extension UIColor {
  
  // 16진수로 컬러값 세팅
  convenience init(hex: Int, alpha: CGFloat = 1.0) {
    let newRed = CGFloat((hex >> 16) & 0xff) / 255
    let newGreen = CGFloat((hex >> 08) & 0xff) / 255
    let newBlue = CGFloat((hex >> 00) & 0xff) / 255
    
    self.init(red:newRed, green:newGreen, blue:newBlue, alpha:alpha)
  }
  
}
