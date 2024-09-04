//
//  Font.swift
//  ContainerControllerSwift_Example
//
//  Created by Рустам Мотыгуллин on 08.08.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

extension UIFont {
    class func mediumSystemFont(ofSize pointSize: CGFloat) -> UIFont {
        return self.systemFont(ofSize: pointSize, weight: .medium)
    }
}
