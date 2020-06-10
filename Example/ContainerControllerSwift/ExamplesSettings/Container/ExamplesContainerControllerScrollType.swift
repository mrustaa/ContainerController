//
//  ExamplesContainerControllerScrollType.swift
//  ContainerController
//
//  Created by mrustaa on 03/06/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

extension ExamplesContainerController {
    
    public enum ScrollType: String, CaseIterable {
        case empty = "-"
        case tableAdapterView = "TableAdapterView (⚙️ Settings)"
        case collectionAdapterView = "CollectionAdapterView"
        case collectionAdapterView2 = "CollectionAdapterView 2"
        case textView = "TextView"
        case mapsContainer = "Main (Maps.app)"
        case locationContainer = "Location (Maps.app)"
        case routeContainer = "Route (Maps.app)"
        case menuContainer = "Menu (Maps.app)"
    }
}

