//
//  RouteContainerControllerDelegate.swift
//  PatternsSwift
//
//  Created by mrustaa on 26/05/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit
import ContainerControllerSwift

public protocol RouteContainerControllerDelegate  {
    
    func routeContainerController(close routeContainerController: RouteContainerController)
    
    func routeContainerController(closeComplection routeContainerController: RouteContainerController)
    
    func routeContainerController(move routeContainerController: RouteContainerController, position: CGFloat, type: ContainerMoveType, animation: Bool)
}
