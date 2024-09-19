//
//  DesignnGradientView.swift
//  ContainerControllerSwift_Example
//
//  Created by Рустам Мотыгуллин on 04.09.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

@IBDesignable
class DesignnGradientView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    @IBInspectable var fillColor: UIColor?
    
    @IBInspectable var brColor: UIColor = .clear
    @IBInspectable var brWidth: CGFloat = 0.0
    @IBInspectable var brDash: Int = 0
    
    @IBInspectable var grColor1: UIColor?
    @IBInspectable var grColor2: UIColor?
    @IBInspectable var grColor3: UIColor?
    @IBInspectable var grStartPoint: CGPoint = .zero
    @IBInspectable var grEndPoint: CGPoint = .zero
    @IBInspectable var grRadial:       Bool = false /// default: linear
    
    func setup() {
        
        if let foundView = viewWithTag(55) {
            foundView.removeFromSuperview()
        }
        
        let d = DesignFigure_(frame: bounds)
        d.backgroundColor = .clear
        d.tag = 55
        d.cornerRadius = cornerRadius
        //        d.blur = blur
        //        d.image = image
        //        d.imageMode = imageMode
        d.fillColor = fillColor
        d.brWidth = brWidth
        d.brColor = brColor
        d.brDash = brDash
        
        d.grColor1 = grColor1
        d.grColor2 = grColor2
        d.grColor3 = grColor3
        //        d.grColor4 = grColor4
        //        d.grColor5 = grColor5
        //        d.grColor6 = grColor6
        d.grStartPoint = grStartPoint
        d.grEndPoint = grEndPoint
        d.grRadial = grRadial
        //        d.grDrawsOptions = grDrawsOptions
        //        d.grDebug = grDebug
        //        d.grPointPercent = grPointPercent
        //        d.grBlendMode = grBlendMode
        
        insertSubview(d, at: 0)
        
    }
    
    override func layoutSubviews() { setup() }
    
}




