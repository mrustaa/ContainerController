//
//  TableAdapterTypes.swift
//  PatternsSwift
//
//  Created by mrustaa on 21/04/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

public typealias TableAdapterCountCallback = () -> Int
public typealias TableAdapterCellIndexCallback = (_ index: Int) -> UITableViewCell
public typealias TableAdapterHeightIndexCallback = (_ index: Int) -> CGFloat
public typealias TableAdapterSelectIndexCallback = (_ index: Int) -> ()
public typealias TableAdapterDidScrollCallback = () -> ()
public typealias TableAdapterDeleteIndexCallback = (_ index: Int) -> ()
