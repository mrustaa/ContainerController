//
//  ContainerTypes.swift
//  PatternsSwift
//
//  Created by Рустам Мотыгуллин on 21/04/2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

typealias TableAdapterCountCallback = () -> Int
typealias TableAdapterCellIndexCallback = (_ index: Int) -> UITableViewCell
typealias TableAdapterHeightIndexCallback = (_ index: Int) -> CGFloat
typealias TableAdapterSelectIndexCallback = (_ index: Int) -> ()
typealias TableAdapterDidScrollCallback = () -> ()
typealias TableAdapterDeleteIndexCallback = (_ index: Int) -> ()
