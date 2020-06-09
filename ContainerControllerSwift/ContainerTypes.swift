//
//  ContainerTypes.swift
//  PatternsSwift
//
//  Created by mrustaa on 21/04/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

typealias ContainerCompletion = () -> Void

public enum ContainerMoveType {
    case top
    case middle
    case bottom
    case hide
    case custom
}

public enum ContainerFromType {
    case pan
    case scroll
    case scrollBorder
    case rotation
    case tracking
    case custom
}

