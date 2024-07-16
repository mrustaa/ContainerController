//
//  Sequances.swift
//  PB Dev
//
//  Created by Valentin on 04.03.2020.
//  Copyright © 2020 Plus Bank. All rights reserved.
//

import Foundation

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}

extension Sequence where Element: Numeric {
    /// Returns the sum of all elements in the collection
    func sum() -> Element { return reduce(0, +) }
}
