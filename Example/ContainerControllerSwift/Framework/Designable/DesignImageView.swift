//
//  DesignImageView.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 21.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

@IBDesignable
class DesignImage: UIImageView {
  
  @IBInspectable var cornerRadius: CGFloat = 0.0
  
    /// Shadow
    @IBInspectable var shColor: UIColor = .clear
    @IBInspectable var shRadius: CGFloat = 0.0
    @IBInspectable var shOffset: CGSize = .zero
    
    /// Border
    @IBInspectable var brColor: UIColor = .clear
    @IBInspectable var brWidth: CGFloat = 0.0
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        layer.backgroundColor = UIColor.black.cgColor
        
        let l = CALayer()
        l.frame = rect
        l.borderColor = brColor.cgColor
        l.borderWidth = brWidth
      l.cornerRadius = cornerRadius
        layer.addSublayer(l)
      
        add(shadow: shRadius, offset: shOffset, color: shColor)
        add(border: brWidth, color: brColor)
        
    }
}

@IBDesignable
class DesignImageView: UIView {
    
    //MARK: Properties
    
    @IBInspectable var image: UIImage?
    @IBInspectable var contModeFill: Bool = false
    
    /// Radius
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    /// Blur
    @IBInspectable var blur: CGFloat = 0.0
    
    /// Fill
    @IBInspectable var fillColor: UIColor = .clear
    
    /// Gradient
    @IBInspectable var grColor2: UIColor?
    @IBInspectable var grColor3: UIColor?
    @IBInspectable var grColor4: UIColor?
    @IBInspectable var grColor5: UIColor?
    @IBInspectable var grColor6: UIColor?
    
    @IBInspectable var grStartPoint: CGPoint = .zero
    @IBInspectable var grEndPoint:   CGPoint = .zero
    
    /// Inner Shadow
    @IBInspectable var inShColor: UIColor = .clear
    @IBInspectable var inShRadius: CGFloat = 0.0
    @IBInspectable var inShOffset: CGSize = .zero
    
    /// Shadow
    @IBInspectable var shColor: UIColor = .clear
    @IBInspectable var shRadius: CGFloat = 0.0
    @IBInspectable var shOffset: CGSize = .zero
    
    /// Border
    @IBInspectable var brColor: UIColor = .clear
    @IBInspectable var brWidth: CGFloat = 0.0
    
    var imageView: UIImageView!
    
    
    //MARK: - Draw
    
    override func draw(_ rect: CGRect) {
        
        let radius = self.cornerRadius(cornerRadius)
        
        layer.cornerRadius = radius
        
        layer.backgroundColor = fillColor.cgColor
        
        addShadow()
        addBorder()
        
        addImage()
        
        addGradient()
        addInnerShadow()
        
        add(blur: blur) { [weak self] in
            
            guard let _self = self else { return }
            _self.imageView.setAlpha(.invisible)
        }
        
    }
    
    private func addGradient() {
        
        guard let glayer = add(gradient: fillColor,
                               color2: grColor2,
                               color3: grColor3,
                               color4: grColor4,
                               color5: grColor5,
                               color6: grColor6,
                               pointStart: grStartPoint,
                               pointEnd:   grEndPoint,
                               cornerRadius: cornerRadius) else { return }
        
        imageView.layer.insertSublayer(glayer, at: 0)
        
    }
    
    private func addInnerShadow() {
        
        addInnerShadow(color:  inShColor,
                       radius: inShRadius,
                       offset: inShOffset,
                       cornerRadius: cornerRadius)
        
    }
    
    private func addShadow() {
        layer.shadowOffset     = shOffset
        layer.shadowOpacity    = 1.0
        layer.shadowRadius     = shRadius
        layer.shadowColor      = shColor.cgColor
    }
    
    private func addBorder() {
        layer.borderColor      = brColor.cgColor
        layer.borderWidth      = brWidth
    }
    
    private func addImage() {
        let f = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        imageView = UIImageView(frame: f)
        imageView.image = image
        imageView.contentMode = contModeFill ? .scaleAspectFill : .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = self.cornerRadius(cornerRadius)
        insertSubview(imageView, at: 0)
    }
    
            
    
    
}
