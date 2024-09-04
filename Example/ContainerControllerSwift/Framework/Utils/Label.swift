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


func sizeToFitLabel(text: String?, font: UIFont? = nil, lines: Int = 99, padding: CGFloat = 0.0) -> CGSize {
    
    let label = UILabel(frame: .init(x: 0, y: 0, width: 60, height: 15))
    label.font = font
    label.numberOfLines = lines
    label.text = text ?? ""
    label.sizeToFit()
    return .init(width: label.frame.size.width + (padding * 2), height: label.frame.size.height)
    
}
