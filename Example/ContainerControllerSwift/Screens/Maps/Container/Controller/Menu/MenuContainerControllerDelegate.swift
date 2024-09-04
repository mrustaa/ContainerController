//
//  MenuContainerControllerDelegate.swift
//  PatternsSwift
//
//  Created by mrustaa on 26/05/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit
import ContainerControllerSwift

protocol MenuContainerControllerDelegate  {
    
    func menuContainerController(close menuContainerController: MenuContainerController)
    
    func menuContainerController(closeComplection menuContainerController: MenuContainerController)
    
    func menuContainerController(segment menuContainerController: MenuContainerController, selectedIndex: Int)
    
    func menuContainerControllerBack()
}
