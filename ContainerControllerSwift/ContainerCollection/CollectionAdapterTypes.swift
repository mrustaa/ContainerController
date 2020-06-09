//
//  CollectionAdapterTypes.swift
//  PatternsSwift
//
//  Created by Рустам Мотыгуллин on 01/05/2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

public typealias CollectionAdapterCountCallback = () -> Int
public typealias CollectionAdapterCellIndexCallback = (_ index: Int) -> UICollectionViewCell
public typealias CollectionAdapterSizeIndexCallback = (_ index: Int) -> CGSize
public typealias CollectionAdapterSelectIndexCallback = (_ index: Int) -> ()
