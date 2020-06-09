//
//  CollectionAdapterView.swift
//  PatternsSwift
//
//  Created by Рустам Мотыгуллин on 01/05/2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

class CollectionAdapterView: UICollectionView {
    
    var countCallback: CollectionAdapterCountCallback?
    var cellIndexCallback: CollectionAdapterCellIndexCallback?
    var sizeIndexCallback: CollectionAdapterSizeIndexCallback?
    var selectIndexCallback: CollectionAdapterSelectIndexCallback?
    
    var items: [CollectionAdapterItem] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        update()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        update()
    }
    
    func update() {
        delegate = self
        dataSource = self
        backgroundColor = .clear
    }
    
    
    public func set(items: [CollectionAdapterItem]) {
        items.forEach {
            registerNibIfNeeded(for: $0)
        }
        self.items = items
        reloadData()
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

extension CollectionAdapterView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !items.isEmpty {
            return items.count
        }
        if let countCallback = countCallback {
            return countCallback()
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
