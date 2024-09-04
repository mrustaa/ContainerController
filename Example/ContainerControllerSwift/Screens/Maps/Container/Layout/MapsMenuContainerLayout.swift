//
//  MapsMenuContainerLayout.swift
//  PatternsSwift
//
//  Created by mrustaa on 23/05/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit
import ContainerControllerSwift

class MapsMenuContainerLayout: ContainerLayout {
    
    override init() {
        super.init()
        
        var paddingBottom: CGFloat = 410
        if ContainerDevice.isIphoneX {
            paddingBottom += 56
        }
        
        var top: CGFloat = 0
        if ContainerDevice.isPortrait, !ContainerDevice.isIpad {
            top = (ContainerDevice.height - paddingBottom)
        }
        
        movingEnabled = .disableAll
        
        positions = ContainerPosition(top: top, bottom: 0.0)
        
        backgroundShadowShow = true
        
        landscapeBackgroundShadowShow = true
        
    }
}
