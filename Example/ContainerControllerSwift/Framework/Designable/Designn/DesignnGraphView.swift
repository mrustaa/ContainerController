//
//  DesignnGraphView.swift
//  ContainerControllerSwift_Example
//
//  Created by Рустам Мотыгуллин on 04.09.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit



@IBDesignable
class DesignnGraphView: UIView {
    
    
    @IBInspectable var gr2Color1: UIColor?
    @IBInspectable var gr2Color2: UIColor?
    @IBInspectable var gr2Color3: UIColor?
    @IBInspectable var gr2StartPoint: CGPoint = .zero
    @IBInspectable var gr2EndPoint: CGPoint = .zero
    @IBInspectable var gr2BlendMode: Int = 0
    
    @IBInspectable var grColor1: UIColor?
    @IBInspectable var grColor2: UIColor?
    @IBInspectable var grColor3: UIColor?
    @IBInspectable var grStartPoint: CGPoint = .zero
    @IBInspectable var grEndPoint: CGPoint = .zero
    @IBInspectable var grRadial:       Bool = false /// default: linear
    @IBInspectable var grBlendMode: Int = 0
    
    @IBInspectable var fillColor: UIColor?
    @IBInspectable var padding: CGFloat = 0
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    @IBInspectable var brColor: UIColor = .clear
    @IBInspectable var brWidth: CGFloat = 0.0
    
    @IBInspectable var addPoints: Bool  = true
    @IBInspectable var arrStr: String = ""
    
    var data: [CGFloat] {
        get {
            
            let result = arrStr.components(separatedBy: ",")
            
            let newResult = result.map {
                CGFloat(Int($0) ?? 0)
            }
            return newResult
        }
        set {
            setNeedsDisplay()
        }
    }
    
    override func layoutSubviews() { setup() }
    
    func setup() {
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius  = cornerRadius
//        self.cornerRadius = cornerRadius
        self.clipsToBounds = true
        
        
      let bezier = rectanglee(rect: bounds, radius: cornerRadius)
        
        addFill(bezier: bezier, fillColor: fillColor)
        
//        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let curve = quadCurvedPath()
        let path = curve.0
        let points = curve.1
        
        addGradient(
            bezier: path,
            grColor1: gr2Color1,
            grColor2: gr2Color2,
            grColor3: gr2Color3,
            grStartPoint: gr2StartPoint,
            grEndPoint: gr2EndPoint,
            grBlendMode: gr2BlendMode
        )
        
        
        
        
//        context.saveGState()
//        path.addClip()
//        context.drawLinearGradient(gradient,
//                                   start: grStartPointR,
//                                   end: grEndPointR,
//                                   options: options)
        
        
        
//        brColor.setStroke()
//        path.lineWidth = brWidth
//        path.stroke()
        
        
        gradientCurve(points: points)
        
        
        
//        addInfoLabels()
        
//        addGradient(bezier: bezier)
        
        
        
        
        
        
//        if let foundView = viewWithTag(55) {
//            foundView.removeFromSuperview()
//        }
//        
//        
//        let d = DesignnGradientView(frame: bounds)
//        d.backgroundColor = .clear
//        d.tag = 44
//        d.fillColor = .clear
//        d.brWidth = brWidth
//        d.brColor = brColor
//        d.grColor1 = grColor1
//        d.grColor2 = grColor2
//        d.grColor3 = grColor3
//        d.grStartPoint = grStartPoint
//        d.grEndPoint = grEndPoint
//        d.layoutSubviews()
//        
//        
//        let g = DesignnGraphOnlyView(frame: bounds)
//        g.backgroundColor = .clear
//        g.tag = 44
//        g.fillColor = .clear
//        g.brWidth = brWidth
//        g.brColor = brColor
//        g.arrStr = arrStr
//        g.layoutSubviews()
        
        
//        let path = quadCurvedPath()
//        brColor.setStroke()
//        path.lineWidth = brWidth
//        path.stroke()
        
//        var colors: [CGColor] = []
//        if let c = grColor1 { colors.append(c.cgColor) }
//        if let c = grColor2 { colors.append(c.cgColor) }
//        if let c = grColor3 { colors.append(c.cgColor) }
//        
//        let gradient = CAGradientLayer()
//        gradient.frame = path.bounds
//        gradient.colors = colors
//        
//        let shapeMask = CAShapeLayer()
//        shapeMask.path = path.cgPath
//        
//        gradient.mask =  shapeMask
//        self.layer.addSublayer(gradient)
        
        
//        let newPath = convert(path, from: self)
        
        
        
//        UIColor.orange.setFill()
//        newPath.fill()
        
        
        
    }
    
    func gradientCurve(points: [CGPoint]) {
        // Gradient for the chart colors
        let gradient = CAGradientLayer()
        
        var colors: [CGColor] = []
        if let c = grColor1 { colors.append(c.cgColor) }
        if let c = grColor2 { colors.append(c.cgColor) }
        if let c = grColor3 { colors.append(c.cgColor) }
        gradient.colors = colors
        
        
        gradient.startPoint = grEndPoint
        gradient.endPoint = grStartPoint
        
        gradient.frame = bounds
        layer.addSublayer(gradient)
        
        // Random points
        let graph = CAShapeLayer()
        let path = CGMutablePath()
//        var y: CGFloat = 150
//        let points: [CGPoint] = stride(from: CGFloat.zero, to: 300, by: 2).map {
//            let change = CGFloat.random(in: -20...20)
//            var newY = y + change
//            newY = max(10, newY)
//            newY = min(newY, 300)
//            y = newY
//            return CGPoint(x: $0, y: y)
//        }
        path.addLines(between: points)
        graph.path = path
        graph.fillColor = nil
        graph.strokeColor = UIColor.black.cgColor
        graph.lineWidth = brWidth
        graph.lineJoin = .round
        graph.lineCap = .round
        graph.frame = bounds
        
        // Only show the gradient where the line is
        gradient.mask = graph
    }
    
    func convert(_ path: UIBezierPath, from view: UIView) -> UIBezierPath {
        path.apply(view.transform)
        // we now have a path in view's superview's coordinates. Let's adjust by the origin.
        let viewTransform = CGAffineTransform(translationX: view.frame.origin.x, y: view.frame.origin.y)
        path.apply(viewTransform)
        
        // now the path is adjusted by view's origin. Next we need to subtract self's origin
        let selfTranslationTransform = CGAffineTransform(translationX: -self.frame.origin.x, y: -self.frame.origin.y)
        path.apply(selfTranslationTransform)
        
        // now adjust by self's transform
        path.apply(self.transform.inverted())
        return path
    }
    
    override func draw(_ rect: CGRect) {
        
        setup()
//        self.layer.cornerRadius  = cornerRadius
//        self.layer.backgroundColor = fillColor?.cgColor
//        self.clipsToBounds = true
//        
//        
//        let bezier = rectangle(rect: bounds, radius: cornerRadius)
//        
////        addFill(bezier: bezier)
////        
////        addGradient(bezier: bezier)
//        
//        
//        let path = quadCurvedPath()
//        
//        
//        var colors: [CGColor] = []
//        if let c = grColor1 { colors.append(c.cgColor) }
//        if let c = grColor2 { colors.append(c.cgColor) }
//        if let c = grColor3 { colors.append(c.cgColor) }
//        
//        let gradient = CAGradientLayer()
//        gradient.frame = path.bounds
//        gradient.colors = colors
//        
//        let shapeMask = CAShapeLayer()
//        shapeMask.path = path.cgPath
//        
//        gradient.mask = shapeMask
//        self.layer.addSublayer(gradient)
        
//        brColor.setStroke()
//        path.lineWidth = brWidth
//        path.stroke()
        
        
        
    }

    
    
    func getText(_ text: String, size: CGFloat = 12,  position: CGPoint) -> CATextLayer {
        let textlayer = CATextLayer()
        textlayer.frame = CGRect(x: position.x, y: position.y, width: 30, height: 18)
        textlayer.fontSize = size
        textlayer.alignmentMode = .center
        textlayer.string = text
        textlayer.isWrapped = true
        textlayer.truncationMode = .end
        textlayer.backgroundColor = UIColor.clear.cgColor
        textlayer.foregroundColor = UIColor.black.cgColor
        return  textlayer
    }
    
    func getRect() -> CGSize {
        .init(width: bounds.width - (padding * 2), height: bounds.height - (padding * 2))
    }
    
    func quadCurvedPath() -> (UIBezierPath, [CGPoint]) {
        
        var arrPoints: [CGPoint] = []
        
        let path = UIBezierPath()
        let step = (getRect().width) / CGFloat(data.count - 1)
        
        var p1 = CGPoint(x: 0 + padding, y: coordYFor(index: 0) + padding)
        arrPoints.append(p1)
        path.move(to: p1)
        
        if addPoints { drawPoint(point: p1, color: UIColor.red, radius: 3) }
        
        if (data.count == 2) {
            let pp =  CGPoint(x: step  + padding, y: coordYFor(index: 1)  + padding)
            arrPoints.append(pp)
            path.addLine(to: pp)
            return (path, arrPoints)
        }
        
        var oldControlP: CGPoint?
        
        for i in 1..<data.count {
            let p2 = CGPoint(x: (step * CGFloat(i)) + padding, y: coordYFor(index: i)  + padding)
            if addPoints { drawPoint(point: p2, color: UIColor.red, radius: 3) }
            var p3: CGPoint?
            if i < data.count - 1 {
                p3 = CGPoint(x: (step * CGFloat(i + 1)) + padding, y: (coordYFor(index: i + 1))  + padding)
            }
            
            let newControlP = controlPointForPoints(p1: p1, p2: p2, next: p3)
            
            
            arrPoints.append(p2)
            path.addCurve(to: p2, controlPoint1: oldControlP ?? p1, controlPoint2: newControlP ?? p2)
            
            p1 = p2
            oldControlP = antipodalFor(point: newControlP, center: p2)
        }
        
        
        path.addLine(to: .init(x: getRect().width, y: getRect().height))
        path.addLine(to: .init(x: 0, y: getRect().height))
        
        if arrPoints.count > 0 {
            path.addLine(to: arrPoints[0])
        }
//        path.close()
       
//        arrPoints.reverse()
//        
//        var old: CGPoint = oldControlP ?? p1
//        arrPoints.forEach {
//            let new: CGPoint = .init(x: $0.x + 0.5, y: $0.y + 0.5)
//            path.addCurve(to: new, controlPoint1: old, controlPoint2: new)
//            old = new
//        }
        
        
        
        return  (path, arrPoints);
    }
    
    /// located on the opposite side from the center point
    func antipodalFor(point: CGPoint?, center: CGPoint?) -> CGPoint? {
        guard let p1 = point, let center = center else {
            return nil
        }
        let newX = 2 * center.x - p1.x
        let diffY = abs(p1.y - center.y)
        let newY = center.y + diffY * (p1.y < center.y ? 1 : -1)
        
        return CGPoint(x: newX, y: newY)
    }
    
    /// halfway of two points
    func midPointForPoints(p1: CGPoint, p2: CGPoint) -> CGPoint {
        return CGPoint(x: (p1.x + p2.x) / 2, y: (p1.y + p2.y) / 2);
    }
    
    /// Find controlPoint2 for addCurve
    /// - Parameters:
    ///   - p1: first point of curve
    ///   - p2: second point of curve whose control point we are looking for
    ///   - next: predicted next point which will use antipodal control point for finded
    func controlPointForPoints(p1: CGPoint, p2: CGPoint, next p3: CGPoint?) -> CGPoint? {
        guard let p3 = p3 else {
            return nil
        }
        
        let leftMidPoint  = midPointForPoints(p1: p1, p2: p2)
        let rightMidPoint = midPointForPoints(p1: p2, p2: p3)
        
        var controlPoint = midPointForPoints(p1: leftMidPoint, p2: antipodalFor(point: rightMidPoint, center: p2)!)
        
        if p1.y.between(a: p2.y, b: controlPoint.y) {
            controlPoint.y = p1.y
        } else if p2.y.between(a: p1.y, b: controlPoint.y) {
            controlPoint.y = p2.y
        }
        
        
        let imaginContol = antipodalFor(point: controlPoint, center: p2)!
        if p2.y.between(a: p3.y, b: imaginContol.y) {
            controlPoint.y = p2.y
        }
        if p3.y.between(a: p2.y, b: imaginContol.y) {
            let diffY = abs(p2.y - p3.y)
            controlPoint.y = p2.y + diffY * (p3.y < p2.y ? 1 : -1)
        }
        
        // make lines easier
        controlPoint.x += (p2.x - p1.x) * 0.1
        
        return controlPoint
    }
    
    func coordYFor(index: Int) -> CGFloat {
        return getRect().height - getRect().height * data[index] / (data.max() ?? 0)
    }
    
    func drawPoint(point: CGPoint, color: UIColor, radius: CGFloat) {
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: point.x - radius, y: point.y - radius, width: radius * 2, height: radius * 2))
        color.setFill()
        ovalPath.fill()
    }
    
}

extension CGFloat {
    func between(a: CGFloat, b: CGFloat) -> Bool {
        return self >= Swift.min(a, b) && self <= Swift.max(a, b)
    }
}

extension UIView {
    
    func rectanglee(rect: CGRect, radius: CGFloat) -> UIBezierPath {
        
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
    
    
    func drawLinearGradient(inside path:UIBezierPath, start:CGPoint, end:CGPoint, colors:[UIColor])
    {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        ctx.saveGState()
        defer { ctx.restoreGState() } // clean up graphics state changes when the method returns
        
        path.addClip() // use the path as the clipping region
        
        let cgColors = colors.map({ $0.cgColor })
        guard let gradient = CGGradient(colorsSpace: nil, colors: cgColors as CFArray, locations: nil)
        else { return }
        
        ctx.drawLinearGradient(gradient, start: start, end: end, options: [])
    }
}

extension DesignnGraphView {
    
    //MARK: - Gradient
    
    private func addGradient(
        bezier: UIBezierPath,
        grColor1: UIColor?,
        grColor2: UIColor?,
        grColor3: UIColor?,
        grStartPoint: CGPoint,
        grEndPoint: CGPoint,
        grBlendMode: Int = 0
    ) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        var colors: [CGColor] = []
        
        if let c = grColor1 { colors.append(c.cgColor) }
        if let c = grColor2 { colors.append(c.cgColor) }
        if let c = grColor3 { colors.append(c.cgColor) }
//        if let c = grColor4 { colors.append(c.cgColor) }
//        if let c = grColor5 { colors.append(c.cgColor) }
//        if let c = grColor6 { colors.append(c.cgColor) }
        
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
        let grDrawsOptions: Bool = true
        let grPointPercent: Bool = true
        
        let bMode = CGBlendMode(rawValue: CGBlendMode.RawValue(grBlendMode)) ?? CGBlendMode.sourceAtop
        
//        bMode = CGBlendMode.screen
        
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
}

extension DesignnGraphView {
    
    func addInfoLabels() {
        
        let mmaax = Int(data.max() ?? 0)
        
        self.layer.addSublayer(getText("0"                ,size: 13,     position: .init(x: 0, y: bounds.height - 18 )))
        self.layer.addSublayer(getText("\(mmaax)"         ,size: 13,    position: .init(x: 0, y: 0 )))
        self.layer.addSublayer(getText("\(data.count)"    ,size: 13,       position: .init(x: bounds.width - 30, y: bounds.height - 18 )))
        
        var start = false
        var half = false
        var end = false
        
        for i in 0..<mmaax {
            
            
            let y = (( CGFloat(i) / CGFloat(mmaax) ) * (bounds.height - 18))
            
            let percent = Int((y / bounds.height) * 100)
            
            var str = "\(100 - percent )%"
            str = "--"
            
            if percent  >= 25 && !start {
                start = true
                self.layer.addSublayer(getText( str ,size: 10, position: .init(x: 0 , y: y - 9 )))
                self.layer.addSublayer(getText( str ,size: 10, position: .init(x: bounds.width - 30 , y: y - 9 )))
            }
            
            if percent >= 50 && !half {
                half = true
                str = "=--"
                
                self.layer.addSublayer(getText(str,size: 10, position: .init(x: 0 , y: y - 9 )))
                str = "--="
                self.layer.addSublayer(getText( str ,size: 10, position: .init(x: bounds.width - 30 , y: y - 9 )))
            }
            
            
            if percent >= 75 && !end {
                end = true
                self.layer.addSublayer(getText(str,size: 10, position: .init(x:0, y:y - 9)))
                self.layer.addSublayer(getText( str ,size: 10, position: .init(x: bounds.width - 30 , y: y - 9 )))
            }
        }
        
        
        start = false
        half = false
        end = false
        
        for i in 0..<data.count {
            
            let x = (( CGFloat(i) / CGFloat(data.count) ) * (bounds.width - 30))
            
            let percent = Int((x / bounds.width) * 100)
            
            var str = "\(percent)%"
            str = "!"
            
            if percent  >= 25 && !start {
                start = true
                self.layer.addSublayer(getText(str,size: 10, position: .init(x: x - 15 , y: bounds.height - 18 )))
                self.layer.addSublayer(getText(str,size: 10, position: .init(x: x - 15 , y: 5 )))
            }
            
            if percent >= 50 && !half {
                half = true
                str = ".|."
                self.layer.addSublayer(getText(str,size: 10, position: .init(x: x - 15 , y: bounds.height - 18 )))
                str = "'|'"
                self.layer.addSublayer(getText(str,size: 10, position: .init(x: x - 15 , y: 5 )))
            }
            
            
            if percent >= 75 && !end {
                end = true
                self.layer.addSublayer(getText(str,size: 10, position: .init(x: x - 15, y: bounds.height - 18 )))
                self.layer.addSublayer(getText(str,size: 10, position: .init(x: x - 15 , y: 5 )))
            }
        }
    }
}

extension UIView {
    
    func addFill(bezier: UIBezierPath, fillColor: UIColor?) {
        
        guard let fillColor = fillColor else { return }
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        bezier.close()
        context.saveGState()
        fillColor.setFill()
        bezier.fill()
        context.restoreGState()
    }
    
}
