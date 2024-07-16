//
//  AutoresizingMask.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 30.05.2021.
//

import UIKit

extension UIView {
  
  func maskAll()  {
    self.autoresizingMask = [ .flexibleTopMargin,
                              .flexibleBottomMargin,
                              .flexibleLeftMargin,
                              .flexibleRightMargin,
                             .flexibleWidth,
                             .flexibleHeight,]
  }
}
