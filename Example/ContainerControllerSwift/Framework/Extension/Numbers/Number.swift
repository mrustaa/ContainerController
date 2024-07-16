//
//  Number.swift
//  PlusBank
//
//  Created by Valentin Titov on 03.02.2021.
//

import CoreGraphics

extension CGFloat {
  static var zero: CGFloat { get {return 0.0 }}
  var half:CGFloat { get { return self/2 } }
  var double:CGFloat  { get { return self*2 } }
  var toPercent: CGFloat { get { return self*100.0 } }
  var syncSize: CGFloat { get { return self * sizeAspect.rawValue }}
  var syncFont: CGFloat { get { return self * fontAspect.rawValue }}
  
  //Pi Constants
  static let π = CGFloat(Double.pi)
  static let π2 = CGFloat(2 * Double.pi)
  static let π_2 = CGFloat(Double.pi/2)
  
  var radians: CGFloat {
    return (self*CGFloat.pi)/180.0
  }
}
