//
//  XibView.swift
//  PatternsSwift
//
//  Created by mrustaa on 19/04/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

class XibView: UIView {
    
    // MARK: - Properties
    
    public weak var contentView: UIView?
    
    // MARK: - Initialize
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = fromNib()
        loadedFromNib()
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        contentView = fromNib()
        frame = contentView?.frame ?? frame
        loadedFromNib()
    }
    
    // MARK: - Postflight
    
    open func loadedFromNib() {
        
    }
    
    // MARK: - Load Nib
    
    func fromNibWithoutConstraints() -> UIView? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView else {
            return nil
        }
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        
        return contentView
    }
    
    func fromNib() -> UIView? {
        guard let contentView = fromNibWithoutConstraints() else { return nil }
        
        let bottomConstraint = NSLayoutConstraint(
            item: contentView,
            attribute: NSLayoutConstraint.Attribute.bottom,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.bottom,
            multiplier: 1,
            constant: 0
        )
        
        let trailingConstraint = NSLayoutConstraint(
            item: contentView,
            attribute: NSLayoutConstraint.Attribute.trailing,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.trailing,
            multiplier: 1,
            constant: 0
        )
        
        let topConstraint = NSLayoutConstraint(
            item: contentView,
            attribute: NSLayoutConstraint.Attribute.top,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.top,
            multiplier: 1,
            constant: 0
        )
        
        let leadingConstraint = NSLayoutConstraint(
            item: contentView,
            attribute: NSLayoutConstraint.Attribute.leading,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.leading,
            multiplier: 1,
            constant: 0
        )
        
        addConstraints([bottomConstraint, trailingConstraint, topConstraint, leadingConstraint])
        
        return contentView
    }
    
}
