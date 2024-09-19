//
//  DesignnImageView.swift
//  ContainerControllerSwift_Example
//
//  Created by Рустам Мотыгуллин on 04.09.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

@IBDesignable
class DesignnImageView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    @IBInspectable var fillColor: UIColor?
    @IBInspectable var image: UIImage?
    @IBInspectable var imageMode: Int = 1
    @IBInspectable var blur: CGFloat = 0.0
    
    
    @IBInspectable var brColor: UIColor = .clear
    @IBInspectable var brWidth: CGFloat = 0.0
    @IBInspectable var brDash: Int = 0
    
    func setup() {
        
        if let foundView = viewWithTag(55) {
            foundView.removeFromSuperview()
        }
        
        let d = DesignFigure_(frame: bounds)
        d.backgroundColor = .clear
        d.tag = 55
        d.cornerRadius = cornerRadius
        d.blur = blur
        d.image = image
        d.imageMode = imageMode
        d.fillColor = fillColor
        d.brWidth = brWidth
        d.brColor = brColor
        d.brDash = brDash
        insertSubview(d, at: 0)
        
    }
    
    override func layoutSubviews() { setup() }
    
}
