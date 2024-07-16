//
//  PulseAnimation.swift
//  ButtonLayersClickStyle
//
//  Created by Рустам Мотыгуллин on 09.03.2022.
//

import UIKit

class PulseAnimation: CALayer {
  
  var animationGroup = CAAnimationGroup()
  var animationDuration: TimeInterval = 1.5
  var radius: CGFloat = 200
  var numebrOfPulse: Float = Float.infinity
  
  override init(layer: Any) {
    super.init(layer: layer)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(numberOfPulse: Float = Float.infinity, radius: CGFloat, postion: CGPoint){
    super.init()
    self.backgroundColor = UIColor.black.cgColor
    self.contentsScale = UIScreen.main.scale
    self.opacity = 0
    self.radius = radius
    self.numebrOfPulse = numberOfPulse
    self.position = postion
    
    self.bounds = CGRect(x: 0, y: 0, width: radius*2, height: radius*2)
    self.cornerRadius = radius
    
    DispatchQueue.global(qos: .default).async {
      self.setupAnimationGroup()
      DispatchQueue.main.async {
        self.add(self.animationGroup, forKey: "pulse")
      }
    }
  }
  
  func scaleAnimation() -> CABasicAnimation {
    let scaleAnimaton = CABasicAnimation(keyPath: "transform.scale.xy")
    scaleAnimaton.fromValue = NSNumber(value: 0)
    scaleAnimaton.toValue = NSNumber(value: 1)
    scaleAnimaton.duration = animationDuration
    return scaleAnimaton
  }
  
  func createOpacityAnimation() -> CAKeyframeAnimation {
    let opacityAnimiation = CAKeyframeAnimation(keyPath: "opacity")
    opacityAnimiation.duration = animationDuration
    opacityAnimiation.values = [0.4,0.8,0]
    opacityAnimiation.keyTimes = [0,0.3,1]
    return opacityAnimiation
  }
  
  func setupAnimationGroup() {
    self.animationGroup.duration = animationDuration
    self.animationGroup.repeatCount = numebrOfPulse
    let defaultCurve = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
    self.animationGroup.timingFunction = defaultCurve
    self.animationGroup.animations = [scaleAnimation(),createOpacityAnimation()]
  }
  
  
}
