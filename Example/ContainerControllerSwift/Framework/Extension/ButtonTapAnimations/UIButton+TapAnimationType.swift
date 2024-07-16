//
//  ViewAnimationSelect.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 22.06.2021.
//

import UIKit

extension UIButton {
  
  // MARK: Tap Animation Type
  
  static let setTag = 963
  
  enum TapType {
    case alpha(_ value: CGFloat) // 0.5
    case layerGray(_ value: CGFloat = 0.1845) // 0.1845 add black shadow
    case pulsate(new: Bool = false)
    case shake(new: Bool = false)
    case flash
    case color(value: UIColor = .red)
    case androidClickable(dark: Bool = false)
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
    radius: CGFloat? = nil,
    type: TapType = .alpha(0.0),
    hideSpeed: Speed? = .ms100,
    callback: ((UIControl.Event) -> Void)? = nil
  ) {
    
    switch type {
    case .androidClickable(let dark): do {
      guard let mainView = views.last else { return }
      
      var tapAdded: Bool = false
      gestureRecognizers?.forEach {
        if $0 is UITapGestureRecognizer {
          tapAdded = true
        }
      }
      if !tapAdded {
          let tap = BindableGestureRecognizer { [weak self] sender in
            
            let touchPoint = sender.location(in: mainView)
            
            guard let dur: Speed = self?.defaultDuration(type: .androidClickable(dark: dark)) else { return }
            self?.androidPulseAnimation(duration: dur, dark: dark, position: touchPoint)
            
          }
          mainView.addGestureRecognizer(tap)
      }
    }
    default: break
    }
  
    
    //    if tag != UIButton.setTag { return }
    //       tag  = UIButton.setTag
    
    tap(for: .touchDown) { [weak self] in
      callback?(.touchDown)
      Logs.add(".touchDown")
      self?.hideAnimation(with: views, radius: radius, type: type, event: .touchDown, duration: hideSpeed)
    }
    tap(for: .touchUpInside) { [weak self] in
      callback?(.touchUpInside)
      Logs.add(".touchUpInside")
      self?.hideAnimation(with: views, radius: radius, visible: .visible, type: type, event: .touchUpInside)
    }
    tap(for: .touchUpOutside) { [weak self] in
      callback?(.touchUpOutside)
      Logs.add(".touchUpOutside")
      self?.hideAnimation(with: views, radius: radius, visible: .visible, type: type, event: .touchUpOutside)
    }
    tap(for: .touchCancel) { [weak self] in
      callback?(.touchCancel)
      Logs.add(".touchCancel")
      self?.hideAnimation(with: views, radius: radius, visible: .visible, type: type, event: .touchCancel)
    }
  }
  
  // MARK: - onClick
  
  func onClick(
    views: [UIView],
    radius: CGFloat? = nil,
    type: TapType = .alpha(0.0),
    hideSpeed: Speed? = .ms100,
    callback: ((UIControl.Event) -> Void)? = nil
  ) {
    main(delay: 0.1) { [weak self] in
      self?.hideAnimation(with: views, radius: radius, type: type, event: .touchDown, duration: hideSpeed)
      main(delay: 0.35) { [weak self] in
        self?.hideAnimation(with: views, radius: radius, visible: .visible, type: type, event: .touchUpInside)
      }
    }
    
  }
  
  
  @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
    guard let touchPoint = sender?.location(in: superview) else { return }
    
    let dur: Speed = defaultDuration(type: .androidClickable(dark: false))
    androidPulseAnimation(duration: dur, dark: false, position: touchPoint)
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
    case .pulsate(_), .flash:       return .ms200
    case .shake(_):                 return .ms50
    case .color(_):                 return .ms300
    case .androidClickable(_):      return .s1
    }
  }
  
  // MARK: - Animation Filter
  
  func hideAnimation(
    with views: [UIView],
    radius: CGFloat? = nil,
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
        updateLayerGray(with: views, cornRadius: radius, visible: .invisible, value: value, duration: nil)
      } else {
        updateLayerGray(with: views, cornRadius: radius, visible: .visible, value: value, duration: dur)
      }
    default: break
    }
    
    views.forEach {
      switch type {
      case .flash: $0.flash(duration: dur)
      case .color(let value):
        if event == .touchDown
        ,$0 is UIButton
//            ,!(($0 is UIButton) || ($0 is UILabel))
        {
          $0.animationColor(duration: dur, cornRadius: radius, value: value)
        }
      case .pulsate(let new):
        if new { $0.pulsateNew(visible: visible) }
        else { if event == .touchDown { $0.pulsate(duration: dur) } }
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
