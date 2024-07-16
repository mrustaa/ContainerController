//
//  ScrollView.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 07.04.2021.
//

import UIKit

extension UIScrollView {
  
  public func scrollingBottom(animated: Bool = true) {
    let deadline = DispatchTime.now() + 0.5
    DispatchQueue.main.asyncAfter(deadline: deadline) {
      let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.height + self.contentInset.bottom)
      self.setContentOffset(bottomOffset, animated: animated)
    }
  }
}

extension UITextView {
  
  func scrollTextToBottom() {
    if text.count != 0 {
      let a = (text.count - 1)
      let bottom: NSRange = NSRange(location: a, length: 1) // a..<1
      scrollRangeToVisible(bottom)
    }
  }
}
