//
//  UIView+Round.swift
//  PlusBank
//
//  Created by Valentin Titov on 07.02.2021.
//

import UIKit

//MARK: - Round
extension UIView {
  
  /**
   Rounds the given set of corners to the specified radius
   
   - parameter corners: Corners to round
   - parameter radius:  Radius to round to
   */
  func roundRadius(corners: UIRectCorner,
             radius: CGFloat) {
    _ = _roundRadius(corners: corners, radius: radius)
  }
  
  /**
   Rounds the given set of corners to the specified radius with a border
   - parameter corners:     Corners to round
   - parameter radius:      Radius to round to
   - parameter borderColor: The border color
   - parameter borderWidth: The border width
   */
  func roundRadius(corners: UIRectCorner,
             radius: CGFloat,
             borderColor: UIColor,
             borderWidth: CGFloat) {
    let mask = _roundRadius(corners: corners, radius: radius)
    addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
  }
  
  /**
   Fully rounds an autolayout view (e.g. one with no known frame) with the given diameter and border
   
   - parameter diameter:    The view's diameter
   - parameter borderColor: The border color
   - parameter borderWidth: The border width
   */
  func fullyRound(diameter: CGFloat,
                  borderColor: UIColor,
                  borderWidth: CGFloat) {
    layer.masksToBounds = true
    layer.cornerRadius = diameter / 2
    layer.borderWidth = borderWidth
    layer.borderColor = borderColor.cgColor;
  }
  
  @discardableResult func _roundRadius(corners: UIRectCorner,
                                 radius: CGFloat) -> CAShapeLayer {
    let path = UIBezierPath(roundedRect: bounds,
                            byRoundingCorners: corners,
                            cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
    return mask
  }
  
  func addBorder(mask: CAShapeLayer,
                 borderColor: UIColor,
                 borderWidth: CGFloat) {
    let borderLayer = CAShapeLayer()
    borderLayer.path = mask.path
    borderLayer.fillColor = UIColor.clear.cgColor
    borderLayer.strokeColor = borderColor.cgColor
    borderLayer.lineWidth = borderWidth
    borderLayer.frame = bounds
    layer.addSublayer(borderLayer)
  }
}
