//
//  LocationContainerControllerDelegate.swift
//  PatternsSwift
//
//  Created by mrustaa on 26/05/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit
import ContainerControllerSwift

protocol LocationContainerControllerDelegate  {
    
    func locationContainerController(showRoute locationContainerController: LocationContainerController)
    
    func locationContainerController(close locationContainerController: LocationContainerController)
    
    func locationContainerController(closeComplection locationContainerController: LocationContainerController)
    
    func locationContainerController(move locationContainerController: LocationContainerController, position: CGFloat, type: ContainerMoveType, animation: Bool)
}
