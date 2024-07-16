//
//  UIButton+AllAnimations.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 20.08.2021.
//

import UIKit

// MARK: Animations

extension UIButton {
  
  // MARK: - Alpha
  
  func updateChangeAlpha(with views: [UIView], visible: Alpha, value: CGFloat, duration: Speed?) {
    
    var alpha: CGFloat = 1.0
    if visible != .visible {
      alpha = value
    }
    
    if let duration = duration {
      UIView.animate(with: duration) {
        for view in views {
          view.alpha = alpha
        }
      }
    } else {
      for view in views {
        view.alpha = alpha
      }
    }
  }
  
  // MARK: - Layer Gray
  
  func updateLayerGray(with views: [UIView], visible: Alpha, value: CGFloat, duration: Speed?) {
    
    guard let mainView = views.last else { return }
    let shTag = 31
    let spechialColor = UIColor(red: 10.0 / 255.0, green: 13.0 / 255.0, blue: 38.0 / 255.0, alpha: value)
    
    if visible == .visible {
      
      if let view = mainView.viewWithTag(shTag) {
        view.alpha = 1
        
        if let duration = duration {
          UIView.animate(
            with: duration,
            animations: {
              view.alpha = 0
            },
            completion: { fin in
              view.removeFromSuperview()
            }
          )
        } else {
          view.alpha = 0
          view.removeFromSuperview()
        }
      }
      
    } else {
      
      if mainView.viewWithTag(shTag) == nil {
        
        var radius = mainView.layer.cornerRadius
        if radius == 0 {
          for sv in mainView.subviews {
            if sv.layer.cornerRadius != 0 {
              radius = mainView.layer.cornerRadius
            }
            if let desFig = mainView as? DesignFigure {
              radius = desFig.cornerRadius
              if radius == -1 {
                let minSize =  min(mainView.frame.width, mainView.bounds.height)
                radius = minSize / 2
              }
            }
          }
        }
        
        let shadowView = UIView(frame: mainView.bounds)
        shadowView.tag = shTag
        shadowView.backgroundColor = spechialColor
        shadowView.layer.cornerRadius = radius
        mainView.addSubview(shadowView)
        shadowView.alpha = ((duration == nil) ? 1 : 0)
        if let duration = duration {
          if duration == .zero {
            shadowView.alpha = 1
          } else {
            UIView.animate(with: duration) {
              shadowView.alpha = 1
            }
          }
        }
      }
    }
  }
}

extension UIView {
  
  // MARK: - Flash
  
  func flash(duration: Speed = .ms200) {
    
    let flash = CABasicAnimation(keyPath: "opacity")
    flash.duration = duration.rawValue
    flash.fromValue = 1
    flash.toValue = 0.1
    flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    flash.autoreverses = true
    flash.repeatCount = 3
    
    layer.add(flash, forKey: nil)
  }
  
  // MARK: - Change Color
  
  func animationColor(duration: Speed = .s1) {
    
    let color = CABasicAnimation(keyPath: "backgroundColor")
    color.fromValue = UIColor.white.cgColor
    color.toValue = UIColor.red.cgColor
    color.duration = duration.rawValue
    color.beginTime = CACurrentMediaTime() + 0.3
    color.autoreverses = true
    
    layer.add(color, forKey: "animationColor")
  }
  
  // MARK: - Pulsate
  
  func pulsate(duration: Speed = .ms200) {
    
    let pulse = CASpringAnimation(keyPath: "transform.scale")
    pulse.duration = duration.rawValue
    pulse.fromValue = 0.95
    pulse.toValue = 1.0
    pulse.autoreverses = true
    pulse.repeatCount = 2
    pulse.initialVelocity = 0.5
    pulse.damping = 1.0
    
    layer.add(pulse, forKey: "pulse")
  }
  
  // MARK: - Pulsate 2
  
  func pulsateNew(visible: Alpha) {
    if visible == .visible {
      animate(self, transform: .identity)
    } else {
      animate(self, transform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95))
    }
  }
  
  private func animate(_ view: UIView, transform: CGAffineTransform) {
    UIView.animate(withDuration: 0.4,
                   delay: 0,
                   usingSpringWithDamping: 0.5,
                   initialSpringVelocity: 3,
                   options: [.curveEaseInOut],
                   animations: {
                    view.transform = transform
                   }, completion: nil)
  }
  
  // MARK: - Shake
  
  func shake() {
    let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    animation.duration = 0.6
    animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
    layer.add(animation, forKey: "shake")
  }

  // MARK: - Shake 2
  
  func shakeNew(duration: Speed = .ms50) {
    
    let shake = CABasicAnimation(keyPath: "position")
    shake.duration = duration.rawValue
    shake.repeatCount = 2
    shake.autoreverses = true
    
    let fromPoint = CGPoint(x: center.x - 5, y: center.y)
    let fromValue = NSValue(cgPoint: fromPoint)
    
    let toPoint = CGPoint(x: center.x + 5, y: center.y)
    let toValue = NSValue(cgPoint: toPoint)
    
    shake.fromValue = fromValue
    shake.toValue = toValue
    
    layer.add(shake, forKey: "position")
  }
  
  // MARK: - Android Pulse
  
  func androidPulseAnimation( duration: Speed = .ms1, color: UIColor, position: CGPoint) {
    
    let pulse = PulseAnimation(numberOfPulse: 1, radius: 200, postion: position)
    pulse.animationDuration = duration.rawValue
    pulse.backgroundColor = color.cgColor // #colorLiteral(red: 0.05282949957, green: 0.5737867104, blue: 1, alpha: 1)
    layer.insertSublayer(pulse, below: layer)
  }
  
}


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
