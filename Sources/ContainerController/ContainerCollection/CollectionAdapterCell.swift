//
//  CollectionAdapterCell.swift
//  PatternsSwift
//
//  Created by mrustaa on 01/05/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

open class  CollectionAdapterInsets: NSObject {
    public var minSpacing: CollectionAdapterMinSpacing = CollectionAdapterMinSpacing(cell: 0, line: 0)
    public var insets: UIEdgeInsets = .zero
    public var scrollDirection: UICollectionView.ScrollDirection = .horizontal
    
    public init(minSpacing: CollectionAdapterMinSpacing, insets: UIEdgeInsets, scrollDirection: UICollectionView.ScrollDirection = .horizontal) {
        self.minSpacing = minSpacing
        self.insets = insets
        self.scrollDirection = scrollDirection
    }
    
}

open class CollectionAdapterMinSpacing: NSObject {
    public var cell: CGFloat = 0
    public var line: CGFloat = 0
    
    public init(cell: CGFloat, line: CGFloat) {
        self.cell = cell
        self.line = line
    }
}

open class CollectionAdapterCell: UICollectionViewCell {
    
    @IBInspectable var hideAnimation: Bool = false
    var selectedView: UIView?
    
    public var cellData: CollectionAdapterCellData?
    
    open func fill(data: Any?) {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCommonProperties()
    }
    
    required public init?(coder: NSCoder) {
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
    
    
    open override var isSelected: Bool {
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
    
    open override var isHighlighted: Bool {
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
