//
//  ContainerLayout.swift
//  PatternsSwift
//
//  Created by mrustaa on 21/04/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

// MARK: - Position

open class ContainerPosition {
    
    public var top: CGFloat
    
    public var middle: CGFloat?
    
    public var bottom: CGFloat?
    
    static let zero = ContainerPosition(top: 0)
    
    public init(top: CGFloat, middle: CGFloat? = nil, bottom: CGFloat? = nil) {
        self.top = top
        self.middle = middle
        self.bottom = bottom
    }
}


// MARK: - Insets

public struct ContainerInsets {
    
    public var right: CGFloat

    public var left: CGFloat

    static let zero = ContainerInsets(right: 0, left: 0)
    
    public init(right: CGFloat, left: CGFloat) {
        self.right = right
        self.left = left
    }
}

// MARK: - Layout

open class ContainerLayout {
    
    /**
     Initialization start position.
    */
    public var startPosition: ContainerMoveType = .hide
    
    /**
     Disables any moving with gestures.
    */
    
    public var movingEnabled: ContainerMovingType = .enable
    
    /**
     This is parameters for control footerView.
     Padding-top from containerView, if headerView is added, then its + height is summed.
    */
    public var footerPadding: CGFloat = 0.0
    
    /**
     This is parameters for control FooterView.
     Tracking position ContainerView during animated movement.
    */
    public var trackingPosition: Bool = false
    
    /**
     This is parameter contentInsets for transmission scrollView added containerView.
    */
    public var scrollInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    /**
     This is parameter scrollIndicatorInsets for transmission scrollView added containerView.
    */
    public var scrollIndicatorInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    /**
     This parameter for portrait orientation.
     Sets the background shadow under container.
    */
    public var backgroundShadowShow: Bool = false
    
    /**
     This parameter for Portrait orientation
     Sets the new value for positions of animated movement (top, middle, bottom).
     */
    public var positions: ContainerPosition = ContainerPosition.zero
    
    /**
     This parameter for Portrait orientation.
     Insets for containerView (left, right).
    */
    public var insets: ContainerInsets = ContainerInsets.zero
    
    /**
     This parameter for Landscape orientation.
     Sets the background shadow under container. (Default: portrait backgroundShadowShow).
    */
    public var landscapeBackgroundShadowShow: Bool?
    
    /**
     This parameter for Landscape orientation.
     Sets the new value for positions of animated movement (top, middle, bottom). (Default: portrait positions).
    */
    public var landscapePositions: ContainerPosition?
    
    /**
     This parameter for Landscape orientation.
     Insets for containerView (left, right). (Default: portrait insets).
    */
    public var landscapeInsets: ContainerInsets?
    
    public init() {
        
    }
    
}

