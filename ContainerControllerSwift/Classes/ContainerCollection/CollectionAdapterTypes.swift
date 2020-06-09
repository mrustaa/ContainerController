//
//  CollectionAdapterTypes.swift
//  PatternsSwift
//
//  Created by Рустам Мотыгуллин on 01/05/2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

typealias CollectionAdapterCountCallback = () -> Int
typealias CollectionAdapterCellIndexCallback = (_ index: Int) -> UICollectionViewCell
typealias CollectionAdapterSizeIndexCallback = (_ index: Int) -> CGSize
typealias CollectionAdapterSelectIndexCallback = (_ index: Int) -> ()
