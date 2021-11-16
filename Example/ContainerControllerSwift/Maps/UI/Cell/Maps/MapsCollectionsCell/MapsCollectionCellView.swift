//
//  MapsCollectionCellView.swift
//  PatternsSwift
//
//  Created by mrustaa on 13/05/2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

@IBDesignable
class MapsCollectionCellView: UIView {

    override func draw(_ rect: CGRect) {
        
        //// Color Declarations
        let color10 = Colors.rgba(185, 185, 185, 0.37)

        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 4, y: 51))
        bezierPath.addCurve(to: CGPoint(x: 4, y: 16), controlPoint1: CGPoint(x: 3.9, y: 44.69), controlPoint2: CGPoint(x: 4, y: 24.46))
        bezierPath.addCurve(to: CGPoint(x: 16, y: 4), controlPoint1: CGPoint(x: 4, y: 6), controlPoint2: CGPoint(x: 6, y: 4))
        bezierPath.addCurve(to: CGPoint(x: 51, y: 4), controlPoint1: CGPoint(x: 26, y: 4), controlPoint2: CGPoint(x: 51, y: 4))
        bezierPath.addCurve(to: CGPoint(x: 44, y: -0), controlPoint1: CGPoint(x: 51, y: 4), controlPoint2: CGPoint(x: 50, y: -0))
        bezierPath.addCurve(to: CGPoint(x: 7, y: -0), controlPoint1: CGPoint(x: 38, y: -0), controlPoint2: CGPoint(x: 11, y: -0))
        bezierPath.addCurve(to: CGPoint(x: 0, y: 7), controlPoint1: CGPoint(x: 3, y: -0), controlPoint2: CGPoint(x: 0, y: 2))
        bezierPath.addCurve(to: CGPoint(x: 0, y: 44), controlPoint1: CGPoint(x: 0, y: 12), controlPoint2: CGPoint(x: 0, y: 34.5))
        bezierPath.addCurve(to: CGPoint(x: 4, y: 51), controlPoint1: CGPoint(x: 0, y: 50), controlPoint2: CGPoint(x: 4, y: 51))
        bezierPath.close()
        color10.setFill()
        bezierPath.fill()
    }
    

}
