//
//  DesignTest.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 28.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit


@IBDesignable
class DesignFigure: UIView {
    /// Rectange | Ellipse | Polygon | Star
    @IBInspectable var figureType: Int = 0
    @IBInspectable var starRadius: CGFloat = 0
    @IBInspectable var starCount: Int = 5
    @IBInspectable var cornerRadius: CGFloat = 0.0
    @IBInspectable var blur: CGFloat = 0.0
    @IBInspectable var image: UIImage?
    /// ScaleToFill | Fit | Fill
    @IBInspectable var imageMode: Int = 1
    @IBInspectable var fillColor: UIColor?
    @IBInspectable var grColor1: UIColor?
    @IBInspectable var grColor2: UIColor?
    @IBInspectable var grColor3: UIColor?
    @IBInspectable var grColor4: UIColor?
    @IBInspectable var grColor5: UIColor?
    @IBInspectable var grColor6: UIColor?
    @IBInspectable var grStartPoint: CGPoint = .zero
    @IBInspectable var grEndPoint: CGPoint = .zero
    /// Default: Linear
    @IBInspectable var grRadial: Bool = false
    @IBInspectable var grDrawsOptions: Bool = true
    @IBInspectable var grDebug: Bool = false
    @IBInspectable var grPointPercent: Bool = true
    @IBInspectable var grBlendMode: Int = 0
    @IBInspectable var brColor: UIColor = .clear
    @IBInspectable var brWidth: CGFloat = 0.0
    @IBInspectable var brDash: Int = 0
    @IBInspectable var inShColor: UIColor = .clear
    @IBInspectable var inShRadius: CGFloat = 0.0
    @IBInspectable var inShOffset: CGSize = .zero
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
        d.figureType = figureType
        d.starRadius = starRadius
        d.starCount = starCount
        d.cornerRadius = cornerRadius
        d.blur = blur
        d.image = image
        d.imageMode = imageMode
        d.fillColor = fillColor
        d.grColor1 = grColor1
        d.grColor2 = grColor2
        d.grColor3 = grColor3
        d.grColor4 = grColor4
        d.grColor5 = grColor5
        d.grColor6 = grColor6
        d.grStartPoint = grStartPoint
        d.grEndPoint = grEndPoint
        d.grRadial = grRadial
        d.grDrawsOptions = grDrawsOptions
        d.grDebug = grDebug
        d.grPointPercent = grPointPercent
        d.grBlendMode = grBlendMode
        d.brWidth = brWidth
        d.brColor = brColor
        d.brDash = brDash
        d.inShColor = inShColor
        d.inShRadius = inShRadius
        d.inShOffset = inShOffset
        d.shColor = shColor
        d.shRadius = shRadius
        d.shOffset = shOffset
        insertSubview(d, at: 0)
        
        if grDebug {
            if let foundView = viewWithTag(44) {
                foundView.removeFromSuperview()
            }
            
            let d = DesignFigureDebug(frame: bounds)
            d.backgroundColor = .clear
            d.tag = 44
            d.grStartPoint = grStartPoint
            d.grEndPoint = grEndPoint
            d.grPointPercent = grPointPercent
            
            insertSubview(d, at: 1)
        }
    }
    
    override func layoutSubviews() { setup() }
    
}

@IBDesignable
class DesignFigureDebug: UIView {
    
    @IBInspectable var grStartPoint: CGPoint = .zero
    @IBInspectable var grEndPoint:   CGPoint = .zero
    @IBInspectable var grPointPercent: Bool = true
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        addGradientDebugPoints()
    }
    
    func addGradientDebugPoints() {
        
        var start = grStartPoint
        var end   = grStartPoint
        
        if grPointPercent {
              end = CGPoint(x:   grEndPoint.x * frame.width, y:   grEndPoint.y * frame.height)
            start = CGPoint(x: grStartPoint.x * frame.width, y: grStartPoint.y * frame.height)
        }
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let radius: CGFloat = 5
        
        context.setBlendMode(CGBlendMode.normal)
        context.setLineWidth(3.0)
        
        
        context.setFillColor(UIColor.black.cgColor)
      
        context.setStrokeColor(UIColor.systemRed.cgColor)
        
        let circleRect = CGRect(x: start.x - radius,
                                y: start.y - radius,
                                width:  radius * 2,
                                height: radius * 2)
        
        context.fillEllipse(in: circleRect)
        context.strokeEllipse(in: circleRect)
      
        context.setStrokeColor(UIColor.green.cgColor)
        
        let circleRect2 = CGRect(x: end.x - radius,
                                 y: end.y - radius,
                                 width: radius * 2,
                                 height: radius * 2)
        
        context.fillEllipse(in: circleRect2)
        context.strokeEllipse(in: circleRect2)
        
        
    }
    
}

enum DesignFigureType: Int {
    case rectange = 0
    case ellipse = 1
    case polygon = 2
    case star = 3
}

@IBDesignable
class DesignFigure_: UIView {
    
    @IBInspectable var figureType: Int = 0  /// Rectange Ellipse Polygon Star
    
    @IBInspectable var starRadius: CGFloat = 0
    @IBInspectable var starCount: Int = 5
    //MARK: Radius
    
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    //MARK: Blur
      
    @IBInspectable var blur: CGFloat = 0.0
    
    //MARK: Image
    
    @IBInspectable var image: UIImage?
    @IBInspectable var imageMode: Int = 1 /// Scale to fill / Aspect fit / fill
    
    //MARK: Fill
    
    @IBInspectable var fillColor: UIColor?
    
    //MARK: Gradient
    
    @IBInspectable var grColor1: UIColor?
    @IBInspectable var grColor2: UIColor?
    @IBInspectable var grColor3: UIColor?
    @IBInspectable var grColor4: UIColor?
    @IBInspectable var grColor5: UIColor?
    @IBInspectable var grColor6: UIColor?
    
    @IBInspectable var grStartPoint: CGPoint = .zero
    @IBInspectable var grEndPoint:   CGPoint = .zero
    
    @IBInspectable var grRadial:       Bool = false /// default: linear
    @IBInspectable var grDrawsOptions: Bool = true
    @IBInspectable var grDebug:        Bool = false
    @IBInspectable var grPointPercent: Bool = true
    @IBInspectable var grBlendMode:    Int  = 0
    
    //MARK: Border
    
    @IBInspectable var brColor: UIColor = .clear
    @IBInspectable var brWidth: CGFloat = 0.0
    @IBInspectable var brDash: Int = 0
    
    //MARK: Inner Shadow
    
    @IBInspectable var inShColor:  UIColor = .clear
    @IBInspectable var inShRadius: CGFloat = 0.0
    @IBInspectable var inShOffset: CGSize = .zero
    
    //MARK: Shadow
        
    @IBInspectable var shColor:  UIColor = .clear
    @IBInspectable var shRadius: CGFloat = 0.0
    @IBInspectable var shOffset: CGSize  = .zero
    
    
    
    //MARK: - Draw
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let bezier = figurePath(bounds) else { return }
        
        addFill(bezier: bezier)
        
        addImage(bezier: bezier)
        
        addGradient(bezier: bezier)
        
        addInnerShadow(bezier: bezier)
        addBorder()
        addShadow()
        
        addBlur()
    }
    
    //MARK: - Figure Type
    
    private func figurePath(_ rect: CGRect) -> UIBezierPath? {
        
        let starR = starRadius / 50
        if starCount < 1 { starCount = 1 }
        
        switch figureType {
        case 1: return UIBezierPath(ovalIn: rect)
        case 2: return star(polygon: true, rect: rect, radius: starR, pointsOnStar: starCount)
        case 3: return star(rect: rect, radius: starR, pointsOnStar: starCount)
        default: return rectangle(rect: rect, radius: cornerRadius)
        }
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
    
    //MARK: - Gradient
    
    private func addGradient(bezier: UIBezierPath) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        var colors: [CGColor] = []
        
        if let c = grColor1 { colors.append(c.cgColor) }
        if let c = grColor2 { colors.append(c.cgColor) }
        if let c = grColor3 { colors.append(c.cgColor) }
        if let c = grColor4 { colors.append(c.cgColor) }
        if let c = grColor5 { colors.append(c.cgColor) }
        if let c = grColor6 { colors.append(c.cgColor) }
        
        if colors.count < 2 {
            colors.append(UIColor.clear.cgColor)
            colors.append(UIColor.clear.cgColor)
        } else if colors.count < 1 {
            if grColor1 != nil {
                colors.append(UIColor.clear.cgColor)
            } else {
                colors.insert(UIColor.clear.cgColor, at: 0)
            }
        }
        
        guard let gradient = CGGradient(colorsSpace: nil,
                                        colors: colors as CFArray,
                                        locations: nil) else { return }
        
        let bMode = CGBlendMode(rawValue: CGBlendMode.RawValue(grBlendMode)) ?? CGBlendMode.sourceAtop
        context.setBlendMode(bMode)
        
        let options: CGGradientDrawingOptions =
        grDrawsOptions ? [ .drawsBeforeStartLocation, .drawsAfterEndLocation ] : [ ]
        
        var grEndPointR:   CGPoint = grEndPoint
        var grStartPointR: CGPoint = grStartPoint
        if grPointPercent {
            grEndPointR = CGPoint(x: (grEndPoint.x * frame.width), y: (grEndPoint.y * frame.height))
            grStartPointR = CGPoint(x: (grStartPoint.x * frame.width), y: (grStartPoint.y * frame.height))
        }
        
        bezier.close()
        context.saveGState()
        bezier.addClip()
        
        if grRadial {
            
            let x: CGFloat = (grEndPointR.x - grStartPointR.x)
            let y: CGFloat = (grEndPointR.y - grStartPointR.y)
            let distance: CGFloat = sqrt((x * x) + (y * y))
            
            context.drawRadialGradient(gradient,
                                       startCenter: grStartPointR,
                                       startRadius: 0,
                                       endCenter: grStartPointR,
                                       endRadius: distance,
                                       options: options)
        } else {
            
            context.drawLinearGradient(gradient,
                                       start: grStartPointR,
                                       end: grEndPointR,
                                       options: options)
        }
    }
    
    //MARK: - Shadow
    
    private func addShadow() {
        
        if shRadius < 0 { shRadius = 0 }
        
        layer.shadowOffset     = shOffset
        layer.shadowOpacity    = 1.0
        layer.shadowRadius     = shRadius
        layer.shadowColor      = shColor.cgColor
    }
    
    private func addShadowContext(bezier: UIBezierPath) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        bezier.close()

        //// Shadow Declarations
        let shadow = NSShadow()
            shadow.shadowColor = shColor
            shadow.shadowOffset = shOffset
            shadow.shadowBlurRadius = shRadius * 2

        context.saveGState()
        
        context.setShadow(offset: shadow.shadowOffset,
                          blur:   shadow.shadowBlurRadius,
                          color: (shadow.shadowColor as! UIColor).cgColor)

        context.restoreGState()
    }
    
    //MARK: - Inner Shadow
    
    private func addInnerShadow(bezier: UIBezierPath) {
        
        if inShRadius < 0 { inShRadius = 0 }
        
        let innerShadow = NSShadow()
        innerShadow.shadowColor = inShColor
        innerShadow.shadowOffset = inShOffset
        innerShadow.shadowBlurRadius = inShRadius * 2
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        ////// Star Inner Shadow
        context.saveGState()
        context.clip(to: bezier.bounds)
        context.setShadow(offset: .zero, blur: 0)
        context.setAlpha((innerShadow.shadowColor as! UIColor).cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        let starOpaqueShadow = (innerShadow.shadowColor as! UIColor).withAlphaComponent(1)
        context.setShadow(offset: innerShadow.shadowOffset,
                          blur: innerShadow.shadowBlurRadius,
                          color: starOpaqueShadow.cgColor)
        
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)

        starOpaqueShadow.setFill()
        
        bezier.fill()

        context.endTransparencyLayer()
        context.endTransparencyLayer()
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
    
    //MARK: - Star Bezier
    
    func star(polygon: Bool = false, rect: CGRect, radius: CGFloat, pointsOnStar: Int) -> UIBezierPath {
        
        let path = UIBezierPath()
        
        let minSize = max(rect.width, rect.height)
        var starExtrusion: CGFloat = minSize * 0.18695652173
        if radius != 0 {
            starExtrusion = minSize * radius
        }

        let center: CGPoint = .zero
        
        var angle: CGFloat = -CGFloat(.pi / 2.0)
        let angleIncrement =  CGFloat(.pi * 2.0 / Double(pointsOnStar))
        let radius = minSize / 2.0

        var firstPoint = true

        func pointFrom(angle: CGFloat, radius: CGFloat, offset: CGPoint) -> CGPoint {
            return CGPoint(x: radius * cos(angle) + offset.x,
                           y: radius * sin(angle) + offset.y)
        }
        
        for _ in 1...pointsOnStar {

            let     point: CGPoint = pointFrom(angle: angle, radius: radius, offset: center)
            let nextPoint: CGPoint = pointFrom(angle: angle + angleIncrement, radius: radius, offset: center)
            let  midPoint: CGPoint = pointFrom(angle: angle + angleIncrement / 2.0, radius: starExtrusion, offset: center)
            
            var perY: CGFloat = 1.0
            var perX: CGFloat = 1.0
            
            if rect.height < rect.width {
                perY = (rect.height / minSize)
            } else {
                perX = (rect.width / minSize)
            }
            
            let p = CGPoint(x: (point.x * perX) + (rect.width / 2.0),
                            y: (point.y * perY) + (rect.height / 2.0))
            
            let n = CGPoint(x: (nextPoint.x * perX) + (rect.width / 2.0),
                            y: (nextPoint.y * perY) + (rect.height / 2.0))
            
            let m = CGPoint(x: (midPoint.x * perX) + (rect.width / 2.0),
                            y: (midPoint.y * perY) + (rect.height / 2.0))
            
            if firstPoint {
                firstPoint = false
                path.move(to: p)
            }
            
            if !polygon {
                path.addLine(to: m)
            }
            path.addLine(to: n)

            angle += angleIncrement
        }
        
        path.close()

        return path
    }
}
