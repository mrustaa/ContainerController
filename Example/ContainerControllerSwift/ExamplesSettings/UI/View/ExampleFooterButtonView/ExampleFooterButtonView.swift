//
//  ExampleHeaderGripView.swift
//  GTDriver
//
//  Created by mrustaa on 16/01/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

class ExampleFooterButtonView: XibView {
    
    var buttonClickCallback: (() -> Void)?
    
    // MARK: - IBOutlets
    
    @IBOutlet public weak var separatorView: UIView?
    @IBOutlet weak var separatorHeight: NSLayoutConstraint?
    
    override func loadedFromNib() {
        separatorHeight?.constant = 0.5
        separatorView?.alpha = 1.0
    }
    
    @IBAction func buttonClickAction(_ sender: Any) {
        buttonClickCallback?()
    }
}
