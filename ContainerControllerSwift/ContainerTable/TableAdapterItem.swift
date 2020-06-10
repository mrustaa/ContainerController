//
//  TableAdapterItem.swift
//  PatternsSwift
//
//  Created by mrustaa on 17/04/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

open class TableAdapterItem: NSObject {
    
    public let cellClass: AnyClass
    
    public let cellData: TableAdapterCellData?
    
    public var cellReuseIdentifier: String {
        return String(describing: cellClass)
    }
    
    public init(cellClass: AnyClass, cellData: TableAdapterCellData? = nil) {
        self.cellClass = cellClass
        self.cellData = cellData
    }
    
    public func height() -> CGFloat {
        return cellData?.cellHeight() ?? UITableView.automaticDimension
    }
    
    public func canEditing() -> Bool {
        return cellData?.canEditing() ?? false
    }

}
