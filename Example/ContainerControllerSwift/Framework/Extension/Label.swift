//
//  Label.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 25.02.2021.
//

import UIKit

extension UILabel {
  
  func addUnderline(size: Int = 1) {
    
    let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.text ?? "")
    attributeString.addAttribute(.underlineStyle, value: size, range: NSMakeRange(0, attributeString.length))
    
    self.attributedText = attributeString
  }
}

func sizeToFitLabel(text: String?, font: UIFont? = nil, lines: Int = 99, x: CGFloat = 16.0) -> CGFloat {
  return TableAdapterCellData.classCalculateLabel(text: text, font: font, lines: lines, x: x).height
}
