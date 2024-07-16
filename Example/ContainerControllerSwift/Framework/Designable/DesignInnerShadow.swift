//
//  DesignInnerShadow.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 12.02.2021.
//  Copyright © 2021 mrusta. All rights reserved.
//

import UIKit

@IBDesignable
class DesignInnerShadow: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0
    @IBInspectable var inShColor:    UIColor = .clear
    @IBInspectable var inShRadius:   CGFloat = 0.0
    @IBInspectable var inShOffset:    CGSize = .zero
    
    @IBInspectable var fillColor:    UIColor?
    
    //MARK: - Draw
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        addInnerShadow(rect)
        
        layer.backgroundColor = fillColor?.cgColor
        layer.cornerRadius = cornerRadius
    }
    
    //MARK: - Add Shadow
    
    func addInnerShadow(_ rect: CGRect) {
        /// General Declarations
        
        let context = UIGraphicsGetCurrentContext()!
        let  path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        
        UIColor(white: 1.0, alpha: 0.00001).setFill()
        
        path.fill()
        context.saveGState()
        context.clip(to: path.bounds)
        context.setAlpha(CGFloat(1.0))
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        
        let innerShadow = NSShadow()
        innerShadow.shadowColor = inShColor
        innerShadow.shadowOffset = inShOffset
        innerShadow.shadowBlurRadius = inShRadius * 2
        
        context.setShadow(offset: inShOffset,
                          blur: inShRadius,
                          color: inShColor.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let ovalOpaqueShadow = UIColor.init(cgColor: inShColor.cgColor)
        ovalOpaqueShadow.setFill()
        path.fill()
        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()
    }
    
}
    
