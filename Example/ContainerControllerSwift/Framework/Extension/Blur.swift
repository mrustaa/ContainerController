//
//  Blur.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 21.05.2021.
//

import Foundation
import UIKit
import Blurberry

protocol AppSceneProtocol {
  var window: UIWindow? { get set }
}

private let overBlurTag: Int = 9036164

//MARK: - OverBlurView
extension AppSceneProtocol {
  
  public func appearOverBlurView() {
    
    let effect = UIBlurEffect(style: .light)
    let view = UIVisualEffectView(effect: nil)
    view.blur.radius = 5.0
    view.blur.tintColor = .clear
    view.frame = window!.frame
    view.tag = overBlurTag
    
    UIView.animate(withDuration: Speed.ms100.rawValue) {
      view.effect = effect
    }
    
    self.window?.addSubview(view)
  }
  
  public func dissappearOverBlurView() {
   
    mainAsync(delay: Speed.ms100.rawValue) {
      
      guard let view = self.window?.viewWithTag(overBlurTag) as? UIVisualEffectView else { return }
      
      UIView.animate(withDuration: Speed.ms100.rawValue,
                     animations: {
                      view.effect = nil
                     }, completion: { _ in
                      view.removeFromSuperview()
                     })
    }
  }
}
