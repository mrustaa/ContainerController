//
//  ContainerControllerDelegate.swift
//  PatternsSwift
//
//  Created by mrustaa on 21/04/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
@objc public protocol ContainerControllerDelegate {
    
    /// Reports rotation and orientation changes
    @objc optional func containerControllerRotation(_ containerController: ContainerController)
    
    /// Reports a click on the background shadow
    @objc optional func containerControllerShadowClick(_ containerController: ContainerController)
    
    /// Reports the changes current position of the container, after its use
    @objc optional func containerControllerMove(_ containerController: ContainerController, position: CGFloat, type: ContainerMoveType, animation: Bool)
    
    
    @objc optional func containerControllerHandlePan(_ containerController: ContainerController, pan: UIPanGestureRecognizer)
    
}

