//
//  UIView+Animation.swift
//  PlusBank
//
//  Created by Valentin Titov on 28.02.2021.
//

import UIKit

extension UIView {
  func shakeAnimation(with duration: TimeInterval = 0.03,
                      repeates: Float = 3.0,
                      delta: CGFloat = 5.0) {
    let animationKey: String = "position"
    let animation = CABasicAnimation(keyPath: animationKey)
    animation.duration = duration
    animation.repeatCount = repeates
    animation.autoreverses = true
    animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - delta, y: center.y))
    animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + delta, y: center.y))
    layer.add(animation,
              forKey: animationKey)
  }
}

