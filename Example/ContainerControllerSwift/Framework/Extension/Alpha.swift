//
//  Alpha.swift
//  PlusBank
//
//  Created by Valentin Titov on 05.02.2021.
//

import UIKit

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


