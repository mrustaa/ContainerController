//
//  LayoutConstraint.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 30.05.2021.
//

import Foundation
import UIKit


extension NSLayoutConstraint {
  /**
   Change multiplier constraint
   
   - parameter multiplier: CGFloat
   - returns: NSLayoutConstraint
   */
  func multiplier(_ value: CGFloat) -> NSLayoutConstraint {
    
    guard let firstItem = firstItem else { return self }
    
    NSLayoutConstraint.deactivate([self])
    
    let newConstraint = NSLayoutConstraint(
      item: firstItem,
      attribute: firstAttribute,
      relatedBy: relation,
      toItem: secondItem,
      attribute: secondAttribute,
      multiplier: value,
      constant: constant
    )
    
    newConstraint.priority = priority
    newConstraint.shouldBeArchived = self.shouldBeArchived
    newConstraint.identifier = self.identifier
    
    NSLayoutConstraint.activate([newConstraint])
    return newConstraint
  }
}
