//
//  Cell.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 08.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    func separator(hide: Bool) {
        separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: hide ? CGFloat(Double.greatestFiniteMagnitude) : 0.0)
    }
    
}
