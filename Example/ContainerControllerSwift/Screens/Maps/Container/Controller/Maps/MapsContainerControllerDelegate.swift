//
//  MapsContainerControllerDelegate.swift
//  PatternsSwift
//
//  Created by mrustaa on 25/05/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit
import ContainerControllerSwift

protocol MapsContainerControllerDelegate  {
    
    func mapsContainerController(showLocationDetails mapsContainerController: MapsContainerController)
    
    func mapsContainerController(move mapsContainerController: MapsContainerController, position: CGFloat, type: ContainerMoveType, animation: Bool)
    
}
