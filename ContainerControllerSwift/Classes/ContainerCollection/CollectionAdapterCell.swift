//
//  ColletionAdapterCell.swift
//  PatternsSwift
//
//  Created by Рустам Мотыгуллин on 01/05/2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

class CollectionAdapterCell: UICollectionViewCell {
    
    @IBInspectable var hideAnimation: Bool = false
    var selectedView: UIView?
    
    public var cellData: CollectionAdapterCellData?
    
    open func fill(data: Any?) {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCommonProperties()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCommonProperties()
    }
    
    private func setupCommonProperties() {
        
    }
    
//    public func notifyDidTap() {
//        guard let cellData = cellData else { return }
//        let cellDataIdentifier = cellData.cellIdentifier
//        
//        let action = CollectionViewAdapterCellAction(
//            cell: self,
//            cellIdentifier: cellDataIdentifier,
//            actionIdentifier: CollectionsActionCellsIdentifiers.cellDidTap.rawValue,
//            data: cellData)
//        
//        delegate?.handle(action: action)
//    }
    
    let selAlpha: CGFloat = 0.2 // 0.15
    
    
    override var isSelected: Bool {
        set {
            super.isSelected = newValue
            
            if hideAnimation {
                
                if newValue {
                    alpha = 0.5
                    UIView.animate(withDuration: 0.45) {
                        self.alpha = 1
                    }
                } else {
                    self.alpha = 1
                }
                
            } else {
                
                if let selectedView = selectedView {
                    if newValue {
                        selectedView.alpha = selAlpha
                        UIView.animate(withDuration: 0.45) {
                            selectedView.alpha = 0.0
                        }
                    } else {
                        selectedView.alpha = 0.0
                    }
                } else {
                    // super.setSelected(selected, animated: animated)
                }
            }
        }
        get {
            return super.isSelected
        }
    }
    
    override var isHighlighted: Bool {
        set {
            super.isHighlighted = newValue
            
            if hideAnimation {
                if newValue {
                    UIView.animate(withDuration: 0.1) {
                        self.alpha = 0.5
                    }
                } else {
                    UIView.animate(withDuration: 0.45) {
                        self.alpha = 1
                    }
                }
            } else {
                if let selectedView = selectedView {
                    if newValue {
                        UIView.animate(withDuration: 0.1) {
                            selectedView.alpha = self.selAlpha
                        }
                    } else {
                        UIView.animate(withDuration: 0.45) {
                            selectedView.alpha = 0.0
                        }
                    }
                } else {
//                    super.setHighlighted(highlighted, animated: animated)
                }
            }
            
        }
        get {
            return super.isHighlighted
        }
    }
    
}
