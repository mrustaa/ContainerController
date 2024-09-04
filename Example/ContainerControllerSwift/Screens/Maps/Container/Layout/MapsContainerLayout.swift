//
//  MapsContainerLayout.swift
//  PatternsSwift
//
//  Created by mrustaa on 22/05/2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit
import ContainerControllerSwift

class MapsContainerLayout: ContainerLayout {
    
    override init() {
        super.init()
        
        startPosition = .hide
        
        setBackgroundShadow()
        
        setIPadInsets()
        
        setLandscapePositions()
        setLandscapeInsets()
    }
    
    private func setBackgroundShadow() {

        backgroundShadowShow = ContainerDevice.isIpad ? false : true
        landscapeBackgroundShadowShow = false
    }
    
    private func setIPadInsets() {
        
        if ContainerDevice.isIpad {
            
            let width: CGFloat = 320
            
            let left: CGFloat = 8
            let right: CGFloat = (ContainerDevice.screenMin - width)
            
            insets = ContainerInsets(right: right, left: left)
        }
    }
    
    private func setLandscapePositions() {
        
        var top: CGFloat = 8
        if ContainerDevice.isIphoneX { top += 16 }
        else if ContainerDevice.isIpad { top += ContainerDevice.statusBarHeight }
        
        var bottom: CGFloat = 70
        if ContainerDevice.isIphoneX { bottom += ContainerDevice.isIphoneXTop }
        
        landscapePositions = ContainerPosition(top: top, bottom: bottom)
    }
    
    private func setLandscapeInsets() {
        
        let width: CGFloat = ContainerDevice.isIphoneX ? 320 : 290
        
        let left: CGFloat = (ContainerDevice.isIphoneX ? 44 : 8)
        let right: CGFloat = (ContainerDevice.screenMax - width)
        
        landscapeInsets = ContainerInsets(right: right, left: left)
    }
    
}

