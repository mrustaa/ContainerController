//
//  MapsMenuHeader.swift
//  GTDriver
//
//  Created by mrustaa on 16/01/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

class MapsMenuHeader: XibView {
    
    var buttonCloseClickCallback: (() -> Void)?
    
    // MARK: - IBOutlets
    
    var darkStyle: Bool = false
    
    @IBOutlet public weak var separatorView: UIView?
    @IBOutlet weak var separatorHeight: NSLayoutConstraint?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func set(darkStyle: Bool) {
        self.darkStyle = darkStyle
        titleLabel.textColor = darkStyle ? .white : .black
    }
    
//    required public init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
    func add(darkStyle: Bool) {
        titleLabel.textColor = darkStyle ? .white : .black
    }
    
    override func loadedFromNib() {
        titleLabel.text = _L("LNG_MAPS_MENU_MAPS_SETTINGS")
        
        separatorHeight?.constant = 0.5
        separatorView?.alpha = 0.0
        
    }
    @IBAction func buttonCloseAction(_ sender: Any) {
        buttonCloseClickCallback?()
    }
    
}

