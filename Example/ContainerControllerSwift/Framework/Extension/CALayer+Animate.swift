//
//  CALayer+Animate.swift
//  PlusBank
//
//  Created by Valentin Titov on 04.02.2021.
//

import UIKit

extension CALayer {
    
    public func animate() -> CALayerAnimate {
        return CALayerAnimate(layer: self)
    }
}

public class CALayerAnimate {
    
  private var animations: [String: CAAnimation]
  private var duration: CFTimeInterval
  let layer: CALayer
  
  init(layer: CALayer) {
    self.animations = [String: CAAnimation]()
    self.duration = 0.25 // second
    self.layer = layer
  }
  
  public func shadowOpacity(shadowOpacity: Float) -> CALayerAnimate {
    let key = "shadowOpacity"
    let animation = CABasicAnimation(keyPath: key)
    animation.fromValue = layer.shadowOpacity
    animation.toValue = shadowOpacity
    animation.isRemovedOnCompletion = false
    animation.fillMode = .forwards
    animations[key] = animation
    return self
  }
  
  public func shadowRadius(shadowRadius: CGFloat) -> CALayerAnimate {
    let key = "shadowRadius"
    let animation = CABasicAnimation(keyPath: key)
    animation.fromValue = layer.shadowRadius
    animation.toValue = shadowRadius
    animation.isRemovedOnCompletion = false
    animation.fillMode = CAMediaTimingFillMode.forwards
    animations[key] = animation
    return self
  }
  
  public func shadowOffsetX(shadowOffsetX: CGFloat) -> CALayerAnimate {
    let key = "shadowOffset"
    
    var toValue: CGSize
    if let currentAnimation = animations[key] as? CABasicAnimation, let currentValue = currentAnimation.toValue {
      toValue = (currentValue as AnyObject).cgSizeValue
    } else {
      toValue = .zero
    }
    toValue.width = shadowOffsetX
    
    let animation = CABasicAnimation(keyPath: key)
    animation.fromValue = NSValue(cgSize: layer.shadowOffset)
    animation.toValue = NSValue(cgSize: toValue)
    animation.isRemovedOnCompletion = false
    animation.fillMode = CAMediaTimingFillMode.forwards
    animations[key] = animation
    return self
  }
  
  public func shadowOffsetY(shadowOffsetY: CGFloat) -> CALayerAnimate {
    let key = "shadowOffset"
    
    var toValue: CGSize
    if let currentAnimation = animations[key] as? CABasicAnimation, let currentValue = currentAnimation.toValue {
      toValue = (currentValue as AnyObject).cgSizeValue
    } else {
      toValue = .zero
    }
    toValue.height = shadowOffsetY
    
    let animation = CABasicAnimation(keyPath: key)
    animation.fromValue = NSValue(cgSize: layer.shadowOffset)
    animation.toValue = NSValue(cgSize: toValue)
    animation.isRemovedOnCompletion = false
    animation.fillMode = CAMediaTimingFillMode.forwards
    animations[key] = animation
    return self
  }
  
  public func duration(duration: CFTimeInterval) -> CALayerAnimate {
      self.duration = duration
      return self
  }
  
  public func start() {
      for (key, animation) in animations {
          animation.duration = duration
        layer.removeAnimation(forKey: key)
        layer.add(animation, forKey: key)
      }
  }
}
