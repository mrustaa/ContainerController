//
//  MapsMainContainerLayout.swift
//  PatternsSwift
//
//  Created by mrustaa on 23/05/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit
import ContainerControllerSwift

class MapsMainContainerLayout: MapsContainerLayout {
    
    override init() {
        super.init()
        
        var top: CGFloat = 44
        if ContainerDevice.isIphoneX { top += 12 }
        
        var bottom: CGFloat = 70
        if ContainerDevice.isIphoneX { bottom += ContainerDevice.isIphoneXBottom }
        
        var middle: CGFloat = 262
        if ContainerDevice.isIphoneX { middle = 325 }
        else if ContainerDevice.isIphone5 { middle = 192 }
        
        positions = ContainerPosition(top: top, middle: middle, bottom: bottom)
    }
}
