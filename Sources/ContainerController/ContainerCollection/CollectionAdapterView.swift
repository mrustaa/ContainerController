//
//  CollectionAdapterView.swift
//  PatternsSwift
//
//  Created by mrustaa on 01/05/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

open class CollectionAdapterView: UICollectionView {
    
    public var countCallback: CollectionAdapterCountCallback?
    public var cellIndexCallback: CollectionAdapterCellIndexCallback?
    public var sizeIndexCallback: CollectionAdapterSizeIndexCallback?
    public var selectIndexCallback: CollectionAdapterSelectIndexCallback?
    
    public var saveOffset: CGPoint = .zero
    public var items: [CollectionAdapterItem] = []
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        update()
    }
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        update()
    }
    
    public func update() {
        delegate = self
        dataSource = self
        backgroundColor = .clear
    }
    
    
    public func set(items: [CollectionAdapterItem], section: Bool = false) {
        items.forEach {
            registerNibIfNeeded(for: $0)
        }
        self.items = items
        
        if section { reloadSections(.init(integer: 0)) }
        else { reloadData()  }
        
        self.setContentOffset(self.saveOffset, animated: false)
        
    }
    
    public func registerNibIfNeeded(for item: CollectionAdapterItem) {
        let nib = UINib(nibName: item.cellReuseIdentifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: item.cellReuseIdentifier)
    }
    
    public func clear() {
        items = []
        reloadData()
    }
    
    private func cellAt(_ indexPath: IndexPath) -> CollectionAdapterCell? {
        let item = items[indexPath.row]
        let cellIdentifier = item.cellReuseIdentifier
        let cell = dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CollectionAdapterCell
        cell?.cellData = item.cellData
        return cell
    }
    
}


extension CollectionAdapterView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        saveOffset = scrollView.contentOffset
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        saveOffset = scrollView.contentOffset
    }
     
}

extension CollectionAdapterView: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !items.isEmpty {
            let item = items[indexPath.row]
            item.cellData?.selectCallback?()
        }
        if let selectIndexCallback = selectIndexCallback {
            selectIndexCallback(indexPath.row)
        }
        
    }
}

extension CollectionAdapterView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !items.isEmpty {
            return items.count
        }
        if let countCallback = countCallback {
            return countCallback()
        }
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if !items.isEmpty {
            let item = items[indexPath.row]
            let cell = cellAt(indexPath)
            cell?.fill(data: item.cellData)
            return cell ?? UICollectionViewCell()
        }
        if let cellIndexCallback = cellIndexCallback {
            return cellIndexCallback(indexPath.row)
        }
        return UICollectionViewCell()
    }
}

extension CollectionAdapterView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if !items.isEmpty {
            let item = items[indexPath.row]
            return item.size()
        }
        if let sizeIndexCallback = sizeIndexCallback {
            return sizeIndexCallback(indexPath.row)
        }
        return CGSize.zero
    }
}

extension CollectionAdapterView {
    
     func scrollingMove(toEnd: CollectionAdapterToEndTypes, animated: Bool = true) {
        let deadline = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            
            
            
            var y: CGFloat = 0
            var x: CGFloat = 0
            
            switch toEnd {
            case .bottom: y = self.contentSize.height - self.bounds.height + self.contentInset.bottom
            case .right:  x = self.contentSize.width  - self.bounds.width  + self.contentInset.right
            default: break
            }
            
            let bottomOffset = CGPoint(x: x, y: y)
            self.setContentOffset(bottomOffset, animated: animated)
        }
    }
}
