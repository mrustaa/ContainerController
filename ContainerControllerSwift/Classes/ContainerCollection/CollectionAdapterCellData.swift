//
//  ColletionAdapterCellData.swift
//  PatternsSwift
//
//  Created by Рустам Мотыгуллин on 01/05/2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

class CollectionAdapterCellData: NSObject {
    
    public var selectCallback: (() -> Void)?
    
    open func size() -> CGSize {
        return CGSize.zero
    }
    
}
