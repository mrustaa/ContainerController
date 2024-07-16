//
//  Int.swift
//  PlusBank
//
//  Created by Valentin Titov on 03.03.2021.
//

import CoreGraphics

extension Int {
  static var zero: Int { get {return 0 }}
  mutating func next() { self += 1 }
  mutating func increase() { self += 1 }
  mutating func previous() { self -= 1 }
  mutating func decrease() { self -= 1 }
  
  func percentToCGFloat() -> CGFloat {
    return CGFloat(self)/CGFloat(100.0)
  }
}

extension UInt8 {
  public init(_ boolean: BooleanLiteralType) {
      self = boolean ? 1 : 0
  }
}
