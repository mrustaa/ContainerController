//
//  DesignViewExtentions.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 20.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

extension UIView {
    func add(shadow radius: CGFloat, offset: CGSize, color: UIColor) {
        layer.shadowOpacity = 1.0
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }
    
    func add(border width: CGFloat, color: UIColor) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    //MARK: - Blur
    
    func add(blur: CGFloat, rect: CGRect? = nil, clearCallback: (() -> Void)? = nil) {
        
        guard blur > 0 else { return }
        
        layer.shadowOpacity = 0.0
        var fr = bounds
        if let rect = rect {
            fr = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        }
        
        UIGraphicsBeginImageContext(fr.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        guard let imgC = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        
        self.blur(screen: imgC, blur: blur, clearCallback: clearCallback)
    }
    
    func blur(screen: UIImage, blur: CGFloat, clearCallback: (() -> Void)? = nil) {
        
        guard let ciscreen: CIImage  = CIImage(image: screen) else { return }
        
        guard let filter: CIFilter = CIFilter(name: "CIGaussianBlur") else { return }
                  filter.setDefaults()
                  filter.setValue(ciscreen, forKey: kCIInputImageKey)
                  filter.setValue(blur,     forKey: kCIInputRadiusKey)
        
        let bl2 = ((blur * 2) * -1)
        let bl4 =  (blur * 4)
        
        let ofW = (layer.shadowOffset.width  * 1) * -1
        let ofH = (layer.shadowOffset.height * 1) * -1
        
        let ofW2 = (layer.shadowOffset.width  * 2)
        let ofH2 = (layer.shadowOffset.height * 2)
        
        let contextFrame = CGRect(x: bl2 + ofW,
                                  y: bl2 + ofH,
                                  width:  frame.width  + bl4 + ofW2,
                                  height: frame.height + bl4 + ofH2)
        
        let ciContext = CIContext(options: nil)
        guard let r = filter.value(forKey: kCIOutputImageKey) as? CIImage else { return }
        guard let cImg = ciContext.createCGImage(r, from: contextFrame) else { return }
        
        let finalImage = UIImage(cgImage: cImg)
        
        let imageFrame = CGRect(x: bl2 + ofW,
                                y: bl2 + ofH,
                                width:  frame.width  + bl4 + ofW2,
                                height: frame.height + bl4 + ofH2)
        
        let blurImageView = UIImageView(frame: imageFrame)
        blurImageView.image = finalImage
        blurImageView.contentMode = .scaleAspectFit
        
        clearAllFills()
        
        clearCallback?()
        
        addSubview(blurImageView)
        
    }
    
    //MARK: - Blur Clear All
    
    func clearAllFills() {
        
        if let sublayers = layer.sublayers  {
            for layer in sublayers {
                
                layer.backgroundColor = UIColor.clear.cgColor
                if let gradientLayer = layer as? CAGradientLayer {
                    gradientLayer.removeFromSuperlayer()
                } else if layer.name == "InnerShadow" {
                    layer.removeFromSuperlayer()
                }
            }
        }
        
        layer.backgroundColor = UIColor.clear.cgColor
        
        func clearShadow() {
            layer.shadowOffset     = .zero
            layer.shadowOpacity    = 0.0
            layer.shadowRadius     = 0.0
            layer.shadowColor      = UIColor.clear.cgColor
        }
        
        func clearBorder() {
            layer.borderColor      = UIColor.clear.cgColor
            layer.borderWidth      = 0.0
        }
        
        clearBorder()
    }
    
    //MARK: - Inner Shadow
    
    func addInnerShadow(color: UIColor,
                        radius: CGFloat,
                        offset: CGSize,
                        cornerRadius: CGFloat,
                        alpha: Float = 1.0) {
        
        let cornerRadius = self.cornerRadius(cornerRadius)
        
        let innerShadow = CALayer()
        innerShadow.name = "InnerShadow"
        innerShadow.frame = bounds
        
        let path = UIBezierPath(roundedRect: innerShadow.bounds.insetBy(dx: -bounds.width, dy: -bounds.height), cornerRadius:cornerRadius)
        let cutout = UIBezierPath(roundedRect: innerShadow.bounds, cornerRadius:cornerRadius).reversing()
        
        path.append(cutout)
        innerShadow.shadowPath = path.cgPath
        innerShadow.masksToBounds = true
        
      innerShadow.shadowColor = color.cgColor
        innerShadow.shadowOffset = offset
        innerShadow.shadowRadius = radius
        innerShadow.cornerRadius = cornerRadius
        innerShadow.shadowOpacity = alpha
        layer.addSublayer(innerShadow)
    }
    
    func add(gradient
             color1: UIColor? = nil,
             color2: UIColor? = nil,
             color3: UIColor? = nil,
             color4: UIColor? = nil,
             color5: UIColor? = nil,
             color6: UIColor? = nil,
             pointStart: CGPoint,
             pointEnd: CGPoint,
             cornerRadius: CGFloat) -> CAGradientLayer? {
        
        if color1 != nil || color2 != nil || color3 != nil || color4 != nil || color5 != nil || color6 != nil {
            
            var colors: [CGColor] = []
            // colors.append(fillColor.cgColor)
            if let color1 = color1 { colors.append(color1.cgColor) }
            if let color2 = color2 { colors.append(color2.cgColor) }
            if let color3 = color3 { colors.append(color3.cgColor) }
            if let color4 = color4 { colors.append(color4.cgColor) }
            if let color5 = color5 { colors.append(color5.cgColor) }
            if let color6 = color6 { colors.append(color6.cgColor) }
            
            let glayer = CAGradientLayer()
            glayer.name = "Gradient"
            glayer.frame = bounds
            glayer.colors = colors
            glayer.startPoint = pointStart
            glayer.endPoint = pointEnd
            glayer.cornerRadius = self.cornerRadius(cornerRadius)
            layer.insertSublayer(glayer, at: 0)
            
            layer.backgroundColor = UIColor.clear.cgColor
            
            return glayer
        }
        return nil
    }
    
    
    //MARK: - Check CornerRadius
    
    func cornerRadius(_ cornerRadius: CGFloat) -> CGFloat {
        let minSize = min(frame.size.width, frame.size.height)
        let minSizeRadius = (minSize / 2)
        let radius = ((cornerRadius < 0) || (minSizeRadius < cornerRadius) ? minSizeRadius : cornerRadius)
        return radius
    }
    
}
