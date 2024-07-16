//
//  UIButton+AllAnimations.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 20.08.2021.
//

import UIKit

// MARK: Animations

extension UIColor {
  var inverted: UIColor {
    var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
    self.getRed(&r, green: &g, blue: &b, alpha: &a)
    return UIColor(red: (1 - r), green: (1 - g), blue: (1 - b), alpha: a) // Assuming you want the same alpha value.
  }
}

//MARK: - Button extension

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
  
  func updateLayerGray(with views: [UIView], cornRadius: CGFloat? = nil, visible: Alpha, value: CGFloat, duration: Speed?) {
    
//    let filterViews = views
    let filterViews = views.filter { !(($0 is UIButton) || ($0 is UILabel)) }
    
    guard let mainView = filterViews.last else { return }
    let shTag = 31
    let spechialColor = UIColor(red: 10.0 / 255.0, green: 13.0 / 255.0, blue: 38.0 / 255.0, alpha: value)
    
    if visible == .visible {
      
      for v in mainView.subviews {
        
        if v.tag == shTag {
          if let duration = duration {
            UIView.animate(
              with: duration,
              animations: {
                v.alpha = 0
              },
              completion: { fin in
                v.removeFromSuperview()
              }
            )
          } else {
            v.alpha = 0
            v.removeFromSuperview()
          }
        }
      }
      
    } else {
      
      if mainView.viewWithTag(shTag) == nil {
        
        var radius = cornRadius ?? mainView.layer.cornerRadius
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
        
        if mainView.viewWithTag(shTag) != nil {
          return
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

//MARK: - View extension

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
  
  
  func inversionColor(duration: Speed = .ms300, cornRadius: CGFloat? = nil, value: UIColor) { // .s1
    
    let v = UIView(frame: frame)
    v.backgroundColor = value.inverted
    v.layer.compositingFilter = "differenceBlendMode"
    addSubview(v)
  }
  
  // MARK: - Change Color
  
  func animationColor(duration: Speed = .ms300, cornRadius: CGFloat? = nil, value: UIColor) { // .s1
    
    let color = CABasicAnimation(keyPath: "backgroundColor")
    let fromColor = backgroundColor ?? .clear
    color.fromValue = value.cgColor   //UIColor.white.cgColor
    color.toValue = fromColor.cgColor
    color.duration = duration.rawValue
    color.beginTime = CACurrentMediaTime() + 0.1
    color.autoreverses = false
    
//    if let r = cornRadius {
//      layer.cornerRadius = r
//    }
    
    
    layer.add(color, forKey: "animationColor")
  }
  
  // MARK: - Pulsate
  
  func pulsate(duration: Speed = .ms200) {
    
    let pulse = CASpringAnimation(keyPath: "transform.scale")
    pulse.duration = duration.rawValue
    pulse.fromValue = 1.0
    pulse.toValue = 0.85
    pulse.autoreverses = true
    pulse.repeatCount = 2
    pulse.initialVelocity = 0.5
     
    
    layer.add(pulse, forKey: "pulse")
  }
  
  // MARK: - Pulsate 2
  
  func pulsateNew(visible: Alpha) {
    if visible == .visible {
      animate(self, transform: .identity)
    } else {
      animate(self, transform: CGAffineTransform.identity.scaledBy(x: 0.85, y: 0.85))
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
  
  func androidPulseAnimation(duration: Speed = .ms1, dark: Bool, value: CGFloat? = nil, position: CGPoint) {
    
    var color = dark ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2786076018) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    if let alpha = value {
      color = color.withAlphaComponent(alpha)
    }
    
    let pulse = PulseAnimation(numberOfPulse: 1, radius: 200, postion: position)
    pulse.animationDuration = duration.rawValue
    pulse.backgroundColor = color.cgColor// #colorLiteral(red: 0.05282949957, green: 0.5737867104, blue: 1, alpha: 1)
    layer.insertSublayer(pulse, below: layer)
  }
  
}

