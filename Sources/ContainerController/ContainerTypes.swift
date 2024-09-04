//
//  ContainerTypes.swift
//  PatternsSwift
//
//  Created by mrustaa on 21/04/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

typealias ContainerCompletion = () -> Void

@objc public enum ContainerMoveType: Int, CaseIterable {
    case top
    case middle
    case bottom
    case hide
    case custom
    
    public func string() -> String {
        switch self {
            
        case .top: return ".top"
        case .middle: return ".middle"
        case .bottom: return ".bottom"
        case .hide: return ".hide"
        case .custom: return ".custom"
            
        }
    }
}

public enum ContainerFromType {
    case pan
    case scroll
    case scrollBorder
    case rotation
    case tracking
    case custom
}



public enum ContainerMovingType: Int {
    case enable
    case disableScroll
    case disableContainer
    case disableAll
    
    var isScrollEnabled: Bool {
            switch self {
            case .enable, .disableContainer:  return true
            case .disableScroll, .disableAll: return false
            }
    }
    
    var isContainerEnabled: Bool {
            switch self {
            case .enable, .disableScroll:        return true
            case .disableContainer, .disableAll: return false
            }
    }

}

