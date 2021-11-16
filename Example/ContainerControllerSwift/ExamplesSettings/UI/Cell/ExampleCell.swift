//
//  ExampleCell.swift
//  ContainerController
//
//  Created by mrustaa on 28/05/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit
import ContainerControllerSwift

// MARK: - Cell Delegate

protocol ExampleCellDelegate {
    func exampleCell(_ cell: TableAdapterCell, type: ExampleCell.Style, value: CGFloat, endEditing: Bool)
}

// MARK: - Cell Data

class ExampleCellData: TableAdapterCellData {
    
    var delegate: ExampleCellDelegate?
    var callback: ((Int) -> Void)?
    
    var type: ExampleCell.Style
    var title: String

    var cellSizeHeight: CGFloat?
    
    init(_ type: ExampleCell.Style,
         _ title: String?,
         _ cellHeight: CGFloat?,
         _ delegate: ExampleCellDelegate?,
         _ callback: ((Int) -> Void)?) {

        self.type = type
        
        if type != .default {
            self.title = type.rawValue
        } else {
            self.title = title ?? ""
        }
        
        self.delegate = delegate
        self.callback = callback
        
        self.cellSizeHeight = cellHeight
        
        super.init()
    }
    
    override public func cellHeight() -> CGFloat {
        return cellSizeHeight ?? 51.0
    }
}


