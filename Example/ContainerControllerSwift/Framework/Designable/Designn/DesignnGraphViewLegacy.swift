//
//  DesignnGraphViewLegacy.swift
//  ContainerControllerSwift_Example
//
//  Created by Рустам Мотыгуллин on 04.09.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

@IBDesignable
class DesignnGraphViewOld: UIView {
    
    @IBInspectable var maxValue: Int = 100
    @IBInspectable var minValue: Int = 0
    
    @IBInspectable var padding: Int = 10
    
    @IBInspectable var arrStr: String = ""
    
    var arrData: [Int] = [10,5,50,70,80,40,35,55,60,62,20,40,70,60,50,90,95]
    
    
    @IBInspectable var cornerRadius: CGFloat = 0.0
    @IBInspectable var fillColor: UIColor?
    @IBInspectable var brColor: UIColor = .clear
    @IBInspectable var brWidth: CGFloat = 0.0
    @IBInspectable var brDash: Int = 0
    
    
    func addFill(bezier: UIBezierPath) {
        
        guard let fillColor = fillColor else { return }
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        bezier.close()
        context.saveGState()
        fillColor.setFill()
        bezier.fill()
        context.restoreGState()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //        layer.backgroundColor = fillColor?.cgColor
        
        let context = UIGraphicsGetCurrentContext()!
        
        let oval = UIBezierPath(ovalIn: rect)
        addFill(bezier: oval)
        
        
        UIColor.green.setStroke()
        
        oval.lineWidth = 2 * 2
        oval.stroke()
        
        //// Color Declarations
        let gradientColor = UIColor(red: 0.039, green: 0.839, blue: 0.361, alpha: 0.140)
        let gradientColor2 = UIColor(red: 0.039, green: 0.841, blue: 0.362, alpha: 0.000)
        let gradientColor3 = UIColor.green
        let color = UIColor.red
        
        //// Gradient Declarations
        //        let gradient = CGGradient(colorsSpace: nil, colors: [ gradientColor.cgColor, gradientColor2.cgColor] as CFArray, locations: [0, 1])!
        //// Rectangle Drawing
        //        let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 70, height: 70))
        //        color.setFill()
        //        rectanglePath.fill()
        
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath ()
        
        UIColor.green.setStroke()
        bezierPath.lineWidth = 2 * 2
        
        
        //        let result = arrStr.components(separatedBy: ",")
        //
        //        let newResult = result.map {
        //            Int($0) ?? 0
        //        }
        
        
        arrData.enumerated().forEach { index, item in
            let widht = ( (rect.width) - ( CGFloat(padding) * 2))
            let height = ( (rect.height) - (CGFloat(padding) * 2))
            
            
            let y = ((( CGFloat(index) / CGFloat(arrData.count) ) * widht) + CGFloat(padding))
            
            let maxHeight = CGFloat(arrData.max() ?? 0)
            
            let x = ((( CGFloat(item) / maxHeight) * height) + CGFloat(padding))
            
            
            bezierPath.move(to: CGPoint(x: x, y: y))
        }
        
        
        //        bezierPath.move(to: CGPoint(x: 4, y: 34.64))
        //        bezierPath.addLine(to: CGPoint(x: 8.4, y: 34.64))
        //        bezierPath.addLine(to: CGPoint(x: 11.04, y: 32.04))
        //        bezierPath.addLine(to: CGPoint(x: 15.44, y: 32.04))
        //        bezierPath.addLine(to: CGPoint(x: 18.53, y: 29.01))
        //        bezierPath.addLine(to: CGPoint(x: 22.49, y: 29.01))
        //        bezierPath.addLine(to: CGPoint(x: 26.01, y: 34.64))
        //        bezierPath.addLine(to: CGPoint(x: 29.53, y: 37.89))
        //        bezierPath.addLine(to: CGPoint(x: 32.61, y: 37.89))
        //        bezierPath.addLine(to: CGPoint(x: 34.81, y: 34.64))
        //        bezierPath.addLine(to: CGPoint(x: 38.55, y: 34.64))
        //        bezierPath.addLine(to: CGPoint(x: 42.95, y: 25.55))
        //        bezierPath.addLine(to: CGPoint(x: 53.08, y: 25.55))
        //        bezierPath.addLine(to: CGPoint(x: 55.5, y: 21))
        //        bezierPath.addLine(to: CGPoint(x: 61, y: 21))
        //        bezierPath.addLine(to: CGPoint(x: 61, y: 42))
        //        bezierPath.addLine(to: CGPoint(x: 4, y: 42))
        //        bezierPath.addLine(to: CGPoint(x: 4, y: 34.64))
        
        bezierPath.stroke()
        //        bezierPath.stroke()
        
        context.restoreGState()
        //        context.restoreGState()
        
        
        //        bezierPath.close()
        //        context.saveGState()
        //        context.restoreGState()
        
        //        bezierPath.close ()
        //        context.saveGState ()
        //        bezierPath.addClip()
        //        context.drawLinearGradient(gradient, start: CGPoint(x: 362.5, y: 84), end: CGPoint(x: 362.5, y: 105), options: [])
        //        context.restoreGState()
        
        
    }
    
    
    func getPoints() {
        
        var arr: [CGPoint] = []
        
        print(" getPoints width: \(self.width) height: \(self.height)")
        arrData.enumerated().forEach { index, item in
            
            let widht = ( (self.width) - ( CGFloat(padding) * 2))
            let height = ( (self.height) - (CGFloat(padding) * 2))
            
            
            let y = ((( CGFloat(index) / CGFloat(arrData.count) ) * widht) + CGFloat(padding))
            
            let maxHeight = CGFloat(arrData.max() ?? 0)
            
            let x = ((( CGFloat(item) / maxHeight) * height) + CGFloat(padding))
            
            print(" getPoints  ( width: \(widht) height: \(height) maxHeight \(maxHeight))  index: \(index), x: \(x) y: \(y)")
            
            arr.append(CGPoint(x: x, y: y))
            //            bezierPath.move(to: CGPoint(x: x, y: y))
        }
    }
    
    
    //    func setup() {
    //
    //
    //
    //
    //        if let foundView = viewWithTag(55) {
    //            foundView.removeFromSuperview()
    //        }
    //
    //        let d = DesignFigure_(frame: bounds)
    //        d.backgroundColor = .clear
    //        d.tag = 55
    //        d.cornerRadius = cornerRadius
    //        //        d.blur = blur
    //        //        d.image = image
    //        //        d.imageMode = imageMode
    //        d.fillColor = fillColor
    //        d.brWidth = brWidth
    //        d.brColor = brColor
    //        d.brDash = brDash
    //        insertSubview(d, at: 0)
    //
    //    }
    
    //    override func layoutSubviews() { setup() }
}
