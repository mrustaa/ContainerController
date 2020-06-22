//
//  CollectionAdapterCellData.swift
//  PatternsSwift
//
//  Created by mrustaa on 01/05/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

open class CollectionAdapterCellData: NSObject {
    
    public var selectCallback: (() -> Void)?
    
    open func size() -> CGSize {
        return CGSize.zero
    }
    
}
