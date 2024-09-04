//
//  ViewAnimationSelect.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 22.06.2021.
//

import UIKit

@IBDesignable
class ButtonAnimationView: UIView {
  
  @IBInspectable var cornerRadius: CGFloat = 0.0
  @IBInspectable var animationType: Int = 0
  
  public var type: UIButton.TapType = .alpha(0.5)
  private var subviewsAnimation = false
  public var button: UIButton?
  
  // MARK: - Initialize
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    updateSubviews()
  }
  
  public init() {
    super.init(frame: .zero)
    updateSubviews()
  }
  
  override func layoutSubviews() { updateSubviews() }
  
  public func setAnimation(type: UIButton.TapType, views: [UIView]? = nil) {
    self.type = type
//    updateSubviews()
    
    layer.cornerRadius = cornerRadius
    
    var nviews: [UIView] = []
    if let views = views {
      nviews = views
    } else {
      nviews.append(self)
      subviews.forEach {
        nviews.append($0)
      }
    }
    
    button?.tapHideAnimation(views: nviews, type: type, callback: { type in
      if type == .touchUpInside {
        
      }
    })
    subviewsAnimation = true
  }
  
  public func updateSubviews() {
    
    if button == nil {
      createButton()
    }
    
    
    if animationType != 0 {
      
      let type: UIButton.TapType = {
        switch animationType {
        case 1: return .alpha(0.5)
        case 2: return .layerGray(0.1845)
        case 3: return .pulsate(new: false, value: 0.9)
        case 4: return .pulsate(new: true, value: 0.9)
        case 5: return .shake(new: false)
        case 6: return .shake(new: true)
        case 7: return .flash
        case 8: return .color([.white, .red])
        case 9: return .androidStyle(color: .white)
        default: return .alpha(0.5)
        }
      }()
      
      setAnimation(type: type)
    }
    
  }
  
  public func createButton() {
    let btn = UIButton(type: .system)
    btn.frame = bounds
    btn.backgroundColor = .clear
    btn.setTitle(nil, for: .normal)
    btn.contentVerticalAlignment = .center
      btn.autoresizingMask = [ .flexibleTopMargin,
                               .flexibleBottomMargin,
                               .flexibleLeftMargin,
                               .flexibleRightMargin,
                               .flexibleWidth,
                               .flexibleHeight ]
    addSubview(btn)
    self.button = btn
  }
}

extension UIButton {
  
  // MARK: Tap Animation Type
  
  static let setTag = 963
  
  enum TapType {
    case alpha(_ value: CGFloat) // 0.5
    case layerGray(_ value: CGFloat = 0.1845) // 0.1845 add black shadow
    case pulsate(new: Bool = false, value: CGFloat = 0.9)
    case shake(new: Bool = false)
    case flash
    case color(_ arr: [UIColor] = [.white, .red])
    case androidStyle(color: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
  }
  
  // MARK: Set
  
  func tapHideAnimation(
    view: UIView?,
    type: TapType = .alpha(0.0),
    hideSpeed: Speed? = .ms100,
    callback: ((UIControl.Event) -> Void)? = nil
  ) {
    guard let view = view else { return }
    tapHideAnimation(views: [view], type: type, callback: callback)
  }
  
  func tapHideAnimation(
    views: [UIView],
    type: TapType = .alpha(0.0),
    hideSpeed: Speed? = .ms100,
    callback: ((UIControl.Event) -> Void)? = nil
  ) {
    
    switch type {
    case .androidStyle(let color): do {
      
      var tapAdded: Bool = false
      gestureRecognizers?.forEach {
        if $0 is BindableGestureRecognizer {
          tapAdded = true
        }
      }
      if !tapAdded {
        
        let tapp = BindableGestureRecognizer { [weak self] sender in
          
          guard let superview = self?.superview else { return }
          let touchPoint = sender.location(in: superview)
          
          guard let dur: Speed = self?.defaultDuration(type: type) else { return }
          self?.androidPulseAnimation(duration: dur, color: color, position: touchPoint)
          
            
            if sender.state == .began {
                callback?(.touchDown)
            } else if sender.state == .changed {
                callback?(.touchDown)
            } else if sender.state == .ended {
                callback?(.touchUpInside)
            }
//            callback?(.touchUpInside)
        }
        addGestureRecognizer(tapp)
      }
    }
    default: break
    }
  
    
    //    if tag != UIButton.setTag { return }
    //       tag  = UIButton.setTag
    
    tap(for: .touchDown) { [weak self] in
      callback?(.touchDown)
      self?.hideAnimation(with: views, type: type, event: .touchDown, duration: hideSpeed)
    }
    tap(for: .touchUpInside) { [weak self] in
      callback?(.touchUpInside)
      self?.hideAnimation(with: views, visible: .visible, type: type, event: .touchUpInside)
    }
    tap(for: .touchUpOutside) { [weak self] in
      callback?(.touchUpOutside)
      self?.hideAnimation(with: views, visible: .visible, type: type, event: .touchUpOutside)
    }
    tap(for: .touchCancel) { [weak self] in
      callback?(.touchCancel)
      self?.hideAnimation(with: views, visible: .visible, type: type, event: .touchCancel)
    }
  }
  
  // MARK: - De-Select
  
  func deselected(_ views: [UIView]) {
    hideAnimation(
      with: views,
      visible: .visible
    )
  }
  
  func defaultDuration(type: TapType) -> Speed {
    switch type {
    case .alpha(_), .layerGray(_):  return .ms300
    case .pulsate(_, _), .flash:    return .ms200
    case .shake(_):                 return .ms50
    case .color(_), .androidStyle(_):  return .s1
    }
  }
  
  // MARK: - Animation Filter
  
  func hideAnimation(
    with views: [UIView],
    visible: Alpha = .invisible,
    type: TapType = .alpha(0.0),
    event: UIControl.Event = .touchUpInside,
    duration: Speed? = nil
  ) {
    
    let dur: Speed = defaultDuration(type: type)
    switch type {
    case .alpha(let value):
      updateChangeAlpha(with: views, visible: visible, value: value, duration: dur)
    case .layerGray(let value):
      if event == .touchDown {
        updateLayerGray(with: views, visible: .invisible, value: value, duration: nil)
      } else {
        updateLayerGray(with: views, visible: .visible, value: value, duration: dur)
      }
    default: break
    }
    
    views.forEach {
      switch type {
      case .flash: $0.flash(duration: dur)
      case .color(let arr): $0.animationColor(duration: dur, colors: arr)
      case .pulsate(let new, let value):
          if new { $0.pulsateNew(visible: visible, value: value) }
        else { $0.pulsate(duration: dur, value: value) }
      case .shake(let new):
        if new { $0.shake() }
        else { $0.shakeNew(duration: dur) }
//      case .androidClickable:
//        androidPulseAnimation(duration: dur)
      default: break
      }
    }
  }
  
}

extension UIControl.Event {
  
  func strName() -> String {
    return enevtName(self)
  }
  
  func enevtName(_ event: UIControl.Event) -> String {
    switch event {
    case .touchDown:      return "touch.Down"
    case .touchCancel:    return "touch.Cancel"
    case .touchUpOutside: return "touch.Up.Outside"
    case .touchUpInside:  return "touch.Up.Inside"
    default: return ""
    }
  }
}

typealias Interval = TimeInterval

enum Speed: Interval {
    case zero = 0.0
    case ms1 = 0.001
    case ms50 = 0.05
    case ms100 = 0.1
    case ms200 = 0.2
    case ms300 = 0.3
    case ms350 = 0.35
    case ms400 = 0.4
    case ms450 = 0.45
    case ms500 = 0.5
    case s1 = 1.0
    case s2 = 2.0
    case s3 = 3.0
    case s4 = 4.0
    case s5 = 5.0
}

enum Delay: Interval {
    case ms1 = 0.001
    case ms100 = 0.1
    case ms200 = 0.2
    case ms300 = 0.3
    case ms400 = 0.4
    case ms500 = 0.5
    case s1 = 1.0
    case s2 = 2.0
    case s3 = 3.0
    case s4 = 4.0
    case s5 = 5.0
}


enum Alpha: CGFloat {
    case invisible = 0.0
    case halfTransluent = 0.5
    case visible = 1.0
}

extension UIView {
    func setAlpha(_ alpha: Alpha) {
        self.alpha = alpha.rawValue
    }
}


//MARK: - Override animations
extension UIView {
    
    static func animate(with duration: Speed,
                        animations: @escaping () -> Void) {
        UIView.animate(withDuration: duration.rawValue, animations: animations)
    }
    
    static func animate(with duration: Speed,
                        animations: @escaping () -> Void,
                        completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: duration.rawValue,
                       animations: animations,
                       completion: completion)
    }
    
    static func animate(with duration: Speed,
                        delay: Delay,
                        options: AnimationOptions,
                        animations: @escaping () -> Void,
                        completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: duration.rawValue,
                       delay: delay.rawValue,
                       options: options,
                       animations: animations,
                       completion: completion)
    }
}

final class BindableGestureRecognizer: UITapGestureRecognizer {
  private var action: (UITapGestureRecognizer) -> Void
  
  init(action: @escaping (UITapGestureRecognizer) -> Void) {
    self.action = action
    super.init(target: nil, action: nil)
    self.addTarget(self, action: #selector(execute(_:)))
  }
  
  @objc private func execute(_ sender: UITapGestureRecognizer) {
    action(sender)
  }
}
