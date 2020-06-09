//
//  ColletionAdapterItem.swift
//  PatternsSwift
//
//  Created by Рустам Мотыгуллин on 01/05/2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

open class CollectionAdapterItem: NSObject {
    
    public let cellClass: AnyClass
    public let cellData: CollectionAdapterCellData?
    
    public var cellReuseIdentifier: String {
        return String(describing: cellClass)
    }
    
    init(cellClass: AnyClass, cellData: CollectionAdapterCellData? = nil) {
        self.cellClass = cellClass
        self.cellData = cellData
    }
    
    public func size() -> CGSize {
        return cellData?.size() ?? CGSize.zero
    }
    
}
