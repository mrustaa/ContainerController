//
//  ContainerView.swift
//  PatternsSwift
//
//  Created by mrustaa on 21/04/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

// MARK: - Position

open class ContainerPosition {
    
    var top: CGFloat
    
    var middle: CGFloat?
    
    var bottom: CGFloat
    
    static let zero = ContainerPosition(top: 0, bottom: 0)
    
    init(top: CGFloat, middle: CGFloat? = nil, bottom: CGFloat) {
        self.top = top
        self.middle = middle
        self.bottom = bottom
    }
}


// MARK: - Insets

public struct ContainerInsets {
    
    var right: CGFloat

    var left: CGFloat

    static let zero = ContainerInsets(right: 0, left: 0)
    
    init(right: CGFloat, left: CGFloat) {
        self.right = right
        self.left = left
    }
}

// MARK: - Layout

open class ContainerLayout {
    
    /**
     Initialization start position.
    */
    var startPosition: ContainerMoveType = .hide
    
    /**
     Disables any moving with gestures.
    */
    var movingEnabled: Bool = true
    
    /**
     This is parameters for control footerView.
     Padding-top from containerView, if headerView is added, then its + height is summed.
    */
    var footerPadding: CGFloat = 0.0
    
    /**
     This is parameters for control FooterView.
     Tracking position ContainerView during animated movement.
    */
    var trackingPosition: Bool = false
    
    /**
     This is parameter contentInsets for transmission scrollView added containerView.
    */
    var scrollInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    /**
     This is parameter scrollIndicatorInsets for transmission scrollView added containerView.
    */
    var scrollIndicatorInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    /**
     This parameter for portrait orientation.
     Sets the background shadow under container.
    */
    var backgroundShadowShow: Bool = false
    
    /**
     This parameter for Portrait orientation
     Sets the new value for positions of animated movement (top, middle, bottom).
     */
    var positions: ContainerPosition = ContainerPosition.zero
    
    /**
     This parameter for Portrait orientation.
     Insets for containerView (left, right).
    */
    var insets: ContainerInsets = ContainerInsets.zero
    
    /**
     This parameter for Landscape orientation.
     Sets the background shadow under container. (Default: portrait backgroundShadowShow).
    */
    var landscapeBackgroundShadowShow: Bool?
    
    /**
     This parameter for Landscape orientation.
     Sets the new value for positions of animated movement (top, middle, bottom). (Default: portrait positions).
    */
    var landscapePositions: ContainerPosition?
    
    /**
     This parameter for Landscape orientation.
     Insets for containerView (left, right). (Default: portrait insets).
    */
    var landscapeInsets: ContainerInsets?
    
}

