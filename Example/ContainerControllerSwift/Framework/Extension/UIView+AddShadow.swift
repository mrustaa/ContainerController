//
//  UIView+AddShadow.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 08.05.2021.
//

import UIKit

extension UIView {
  
  func addShadowFigma(blur: CGFloat, offset: CGSize, color: UIColor, bColor: UIColor = UIColor.background, radius: CGFloat, alpha: Float = 1.0) {
    
    let layer = self.layer
    layer.frame = bounds
    layer.backgroundColor = bColor.cgColor
    layer.shadowOpacity = alpha
    layer.shadowColor = color.cgColor
    layer.shadowOffset = offset
    layer.shadowRadius = (blur / 2)
    layer.cornerRadius = radius
    
    layer.shouldRasterize = true
  }
}

