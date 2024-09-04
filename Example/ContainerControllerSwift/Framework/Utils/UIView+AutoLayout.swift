//
//  UIView+AutoLayout.swift
//  ContainerControllerSwift_Example
//
//  Created by Рустам Мотыгуллин on 12.08.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

//MARK: - Round
extension UIView {
    
    
    
    func addConstraintsZerro(view: UIView?, superView: UIView?, padding: CGFloat) {
        
        
        //                    let padding: CGFloat = 0
        
        if let mainCardView = superView, let view3 = view {
            
            
            view3.translatesAutoresizingMaskIntoConstraints = false
            
            
            let bottomConstraint = NSLayoutConstraint(
                item: mainCardView,
                attribute: NSLayoutConstraint.Attribute.bottom,
                relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: view3,
                attribute: NSLayoutConstraint.Attribute.bottom,
                multiplier: 1,
                constant: (padding * -1)
            )
            
            let trailingConstraint = NSLayoutConstraint(
                item: mainCardView,
                attribute: NSLayoutConstraint.Attribute.trailing,
                relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: view3,
                attribute: NSLayoutConstraint.Attribute.trailing,
                multiplier: 1,
                constant: (padding * -1)
            )
            
            let topConstraint = NSLayoutConstraint(
                item: mainCardView,
                attribute: NSLayoutConstraint.Attribute.top,
                relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: view3,
                attribute: NSLayoutConstraint.Attribute.top,
                multiplier: 1,
                constant: padding
            )
            
            let leadingConstraint = NSLayoutConstraint(
                item: mainCardView,
                attribute: NSLayoutConstraint.Attribute.leading,
                relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: view3,
                attribute: NSLayoutConstraint.Attribute.leading,
                multiplier: 1,
                constant: padding
            )
            
            addConstraints([bottomConstraint, trailingConstraint, topConstraint, leadingConstraint])
            
        }
    }
    
    
}
