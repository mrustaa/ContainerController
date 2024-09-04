//
//  HeaderLocationDetailsView.swift
//  GTDriver
//
//  Created by mrustaa on 16/01/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit


class HeaderDetailsView: XibView {
    
    var buttonCloseClickCallback: (() -> Void)?
    
    // MARK: - IBOutlets
    
    @IBOutlet public weak var separatorView: UIView?
    @IBOutlet weak var separatorHeight: NSLayoutConstraint?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var textButton: UIButton!
    
    override func loadedFromNib() {
        separatorHeight?.constant = 0.5
        separatorView?.alpha = 0.0
        
        titleLabel.text = ""
        subtitle.text = ""
        textButton.setTitle("", for: .normal)
    }
    
    func add(darkStyle: Bool) {
        titleLabel.textColor = darkStyle ? .white : .black
        subtitle.textColor = darkStyle ? .white : .black
    }
    
    @IBAction func buttonCloseAction(_ sender: Any) {
        buttonCloseClickCallback?()
    }
    
}

