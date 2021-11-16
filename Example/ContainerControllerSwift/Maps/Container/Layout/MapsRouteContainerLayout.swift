//
//  MapsRouteContainerLayout.swift
//  PatternsSwift
//
//  Created by mrustaa on 23/05/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit
import ContainerControllerSwift

class MapsRouteContainerLayout: MapsContainerLayout {
    
    override init() {
        super.init()
        
        var top: CGFloat = 44
        if ContainerDevice.isIphoneX { top += 12 }
        
        var bottom: CGFloat = 77
        if ContainerDevice.isIphoneX { bottom += ContainerDevice.isIphoneXBottom }
        
        let tabbarHeight: CGFloat = 49.0 + ContainerDevice.isIphoneXBottom
        let headerHeight: CGFloat = 78.0
        let middle: CGFloat = (headerHeight + tabbarHeight + MapsRouteCellData.height())
        
        positions = ContainerPosition(top: top, middle: middle, bottom: bottom)
    }
}
