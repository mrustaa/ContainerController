//
//  Window+Get.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 25.05.2021.
//

import Foundation
import UIKit

extension UIWindow {
  
  static var current: UIWindow? {
    if #available(iOS 13.0, *) {
      return UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    } else {
      return UIApplication.shared.keyWindow
    }
  }
  
  static var root: UIViewController? {
    UIWindow.current?.rootViewController
  }
  
  static var nav: UINavigationController? {
    if let nav = root as? UINavigationController {
      return nav
    } else {
      return nil
    }
  }
  
  static var top: UIViewController? {
    if let nav = UIWindow.nav {
      if let vc = nav.topViewController {
        return vc
      }
    }
    return nil
  }
}
