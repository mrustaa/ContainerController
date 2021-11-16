//
//  TripsDayEmptyView.swift
//  GTDriver
//
//  Created by mrustaa on 16/01/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

class TableHeaderSpinerView: XibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    @IBOutlet weak var textLabel: UILabel!
    
    override func loadedFromNib() {
        textLabel.text = _L("LNG_MAPS_LOADING")
    }
    
    
}
