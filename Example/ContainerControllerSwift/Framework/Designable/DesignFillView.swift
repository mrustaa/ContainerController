//
//  DesignTest.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 28.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
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





@IBDesignable
class DesignnShadowView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    @IBInspectable var fillColor: UIColor?
    
    
    @IBInspectable var brColor: UIColor = .clear
    @IBInspectable var brWidth: CGFloat = 0.0
    @IBInspectable var brDash: Int = 0
    
    @IBInspectable var shColor: UIColor = .clear
    @IBInspectable var shRadius: CGFloat = 0.0
    @IBInspectable var shOffset: CGSize = .zero
    
    
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
        
        
        d.shColor = shColor
        d.shRadius = shRadius
        d.shOffset = shOffset
        insertSubview(d, at: 0)
        
    }
    
    override func layoutSubviews() { setup() }
    
}


@IBDesignable
class DesignnView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    @IBInspectable var fillColor: UIColor?
    

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
//        d.blur = blur
//        d.image = image
//        d.imageMode = imageMode
        d.fillColor = fillColor
        d.brWidth = brWidth
        d.brColor = brColor
        d.brDash = brDash
        insertSubview(d, at: 0)
        
    }
    
    override func layoutSubviews() { setup() }
    
}


@IBDesignable
class DesignFillView_: UIView {
    
    
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    //MARK: Blur
      
    @IBInspectable var blur: CGFloat = 0.0
    
    //MARK: Image
    
    @IBInspectable var image: UIImage?
    @IBInspectable var imageMode: Int = 1 /// Scale to fill / Aspect fit / fill
    
    //MARK: Fill
    
    @IBInspectable var fillColor: UIColor?
    //MARK: Border
    
    @IBInspectable var brColor: UIColor = .clear
    @IBInspectable var brWidth: CGFloat = 0.0
    @IBInspectable var brDash: Int = 0
    
    
    
    @IBInspectable var shColor:  UIColor = .clear
    @IBInspectable var shRadius: CGFloat = 0.0
    @IBInspectable var shOffset: CGSize  = .zero
    
    //MARK: - Draw
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let bezier = figurePath(bounds) else { return }
        
        addFill(bezier: bezier)
        addImage(bezier: bezier)
        addBorder()
        addShadow()
        addBlur()
    }
    
    //MARK: - Figure Type
    
    private func figurePath(_ rect: CGRect) -> UIBezierPath? {
        return rectangle(rect: rect, radius: cornerRadius)
    }
    
    
    
    private func addImage(bezier: UIBezierPath) {
        
        guard let image = image else { return }
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        var f: CGRect = CGRect(x: 0, y: -bounds.height, width: bounds.width, height: bounds.height)
        
        if imageMode == 1 || imageMode == 2 {
            
            var w: CGFloat = 0
            var h: CGFloat = 0
            
            let percent = bounds.height / image.size.height
            w = image.size.width * percent
            h = bounds.height
            
            if (imageMode == 1) && (w > bounds.width) ||
               (imageMode == 2) && (bounds.width > w) {
                
                let percent = bounds.width / image.size.width
                h = image.size.height * percent
                w = bounds.width
            }
            
            let x =         (bounds.width  / 2) - (w / 2)
            let y = (-h + (((bounds.height / 2) - (h / 2)) * (-1)))
            
            f = CGRect(x: x, y: y, width: w, height: h)
        }
        
        context.saveGState()
        bezier.addClip()
        context.scaleBy(x: 1, y: -1)
        context.draw(image.cgImage!, in: f, byTiling: false)
        context.restoreGState()
        
    }
    
    //MARK: - Fill
    
    private func addFill(bezier: UIBezierPath) {
        
        guard let fillColor = fillColor else { return }
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        bezier.close()
        context.saveGState()
        fillColor.setFill()
        bezier.fill()
        context.restoreGState()
    }
    
    
    //MARK: - Shadow
    
    private func addShadow() {
        
        if shRadius < 0 { shRadius = 0 }
        
        layer.shadowOffset     = shOffset
        layer.shadowOpacity    = 1.0
        layer.shadowRadius     = shRadius
        layer.shadowColor      = shColor.cgColor
    }
    
    
    
    // MARK: - Border / Stroke
    
    private func addBorder() {
        
        if brWidth < 0 { brWidth = 0 }
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        //        brColor.setStroke()
        
        guard let bezier = figurePath(bounds) else { return }
        
        context.saveGState()
        
        if brDash > 0 {
            
            UIColor.clear.setFill()
            bezier.fill()
            
            brColor.setStroke()
            bezier.lineWidth = brWidth * 2
            
            let dashPattern : [CGFloat] = [ CGFloat(brDash), CGFloat(brDash)]
            bezier.setLineDash(dashPattern, count: 2, phase: 0)
            bezier.stroke()
            
        } else {
            
            brColor.setStroke()
            
            bezier.lineWidth = brWidth * 2
            bezier.stroke()
        }
        
        
        
        bezier.stroke()
        bezier.stroke()
        
        context.restoreGState()
        context.restoreGState()
    }
    
    
    
    // MARK: - Blur
    
    private func addBlur() {
        
        guard blur > 0 else { return }
        
        guard let image = screenShotContext() else { return }
        
        self.addblur(screen: image, blur: blur)
    }
    
    // MARK: Screen Shot Context
    
    private func screenShotContext() -> UIImage? {
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        guard let cgimage: CGImage = context.makeImage() else { return nil }
        let image = UIImage(cgImage: cgimage)
        
        return image
    }
    
    // MARK: Clear Context
    
    private func clearContext() {

        let f = CGRect(x: 0, y: 0,
                       width:  frame.width  * 2,
                       height: frame.height * 2)

        let context = UIGraphicsGetCurrentContext()
        context?.clear(f)
    }
    
    
    private func addblur(screen: UIImage, blur: CGFloat) {
        
        clearContext()

        func blurImage(image: UIImage) -> UIImage? {
            
            guard let ciscreen: CIImage = CIImage(image: screen) else { return nil }
            
            guard let filter: CIFilter = CIFilter(name: "CIGaussianBlur") else { return nil }
                      filter.setDefaults()
                      filter.setValue(ciscreen, forKey: kCIInputImageKey)
                      filter.setValue(blur, forKey: kCIInputRadiusKey)
          
          
          let bl2 = ((blur * 3) * -1)
          let bl4 = (blur * 6)
          
          let contextFrame = CGRect(
            x: bl2,
            y: bl2,
            width:  bl4 + image.size.width,
            height: bl4 + image.size.height
          )
          
//          let bl2 = ((blur * 2) * -1)
//          let bl4 = (blur * 4)
//            let contextFrame2 = CGRect(x: bl2,
//                                      y: bl2,
//                                      width: bl4 + (frame.width  * 2),
//                                      height: bl4 + (frame.height * 2))
            
            let ciContext = CIContext(options: nil)
            guard let ci: CIImage = filter.value(forKey: kCIOutputImageKey) as? CIImage else { return nil }
            guard let cImg = ciContext.createCGImage(ci, from: contextFrame) else { return nil }
            
            let finalImage = UIImage(cgImage: cImg)
            
            return finalImage
        }
        
        let p2: CGFloat = 1
        let p4: CGFloat = p2 * 2
        
        let bl2 = ((blur * p2) * -1)
        let bl4 = (blur * p4)
        
        let x: CGFloat = 0
        let ofW = (x * 1) * -1
        let ofH = (x * 1) * -1
        
        let ofW2 = (x * 2)
        let ofH2 = (x * 2)
        
        let contextFrame = CGRect(x: bl2 + ofW,
                                  y: bl2 + ofH,
                                  width: bl4 + ofW2 + frame.width,
                                  height: bl4 + ofH2 + frame.height)
        
        let blurImageView = UIImageView(frame: contextFrame)
        blurImageView.image = blurImage(image: screen)
        blurImageView.contentMode = .scaleAspectFill
        
        
        addSubview(blurImageView)
    }
    
    //MARK: - Rectangle Bezier
    
    func rectangle(rect: CGRect, radius: CGFloat) -> UIBezierPath {
        
        let r = self.cornerRadius(radius)
        let w = rect.width
        let h = rect.height
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: r, y: 0.0))
        
        path.addLine(to: CGPoint(x: w - r, y: 0.0))
        path.addArc(withCenter: CGPoint(x: w - r, y: r),
                    radius: r,
                    startAngle: 3.0 * .pi / 2.0,
                    endAngle: 2 * .pi,
                    clockwise: true)
        
        path.addLine(to: CGPoint(x: w, y: h - r))
        path.addArc(withCenter: CGPoint(x: w - r, y: h - r),
                    radius: r,
                    startAngle: 0.0,
                    endAngle: .pi / 2.0,
                    clockwise: true)
        
        path.addLine(to: CGPoint(x: r, y: h))
        path.addArc(withCenter: CGPoint(x: r, y: h - r),
                    radius: r,
                    startAngle: .pi / 2.0,
                    endAngle: .pi,
                    clockwise: true)
        
        path.addLine(to: CGPoint(x: 0.0, y: r))
        path.addArc(withCenter: CGPoint(x: r, y: r),
                    radius: r,
                    startAngle: .pi,
                    endAngle: 3.0 * .pi / 2.0,
                    clockwise: true)
        
        path.close()
        return path
    }
    
}
