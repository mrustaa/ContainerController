//
//  Screen.swift
//  Realme
//
//  Created by Valentin Titov on 04.01.2021.
//

import UIKit

// Common screen constants
var offset: CGFloat = 16

var lastNavBarHeight: CGFloat = 0

struct ScreenSize {
  static var size:CGSize { get { return UIScreen.main.bounds.size }}
  static var bounds:CGRect { get { return CGRect(origin: .zero, size: size) }}
  static var width:CGFloat { get { return size.width }}
  static var height:CGFloat { get { return size.height }}
  static var aspectRatio: CGFloat { get { return size.aspectRatio }}
  static var screenMax:CGFloat { get { max(width, height) } }
  static var screenMin:CGFloat { get { min(width, height) } }
  
  // MARK: - X Padding
  
  static var isIphoneXTop:    CGFloat { get { ( Device.isIphoneX ? 24.0 : 0.0) } }
  static var isIphoneXBottom: CGFloat { get { ( Device.isIphoneX ? 34.0 : 0.0) } }

}

extension UIViewController {
  
  func getStatusBarHeight() -> CGFloat {
    var statusBarHeight: CGFloat = 0
    if #available(iOS 13.0, *) {
      let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
      statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    } else {
      statusBarHeight = UIApplication.shared.statusBarFrame.height
    }
    return statusBarHeight
  }
    
  var topbarHeight: CGFloat {
    
    let statusHeight = getStatusBarHeight()
    let navHeight = self.navigationController?.navigationBar.frame.height ?? 0.0
    
    let height: CGFloat = statusHeight + navHeight
    lastNavBarHeight = height
    
    return height
  }
}

