//
//  StoryboardController.swift
//  PatternsSwift
//
//  Created by Рустам Мотыгуллин on 20/04/2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

@IBDesignable
class StoryboardController: UIViewController {    
    
    class func instantiate() -> UIViewController {
        return fromStoryboardController()
    }

    class func fromStoryboardController() -> UIViewController {
        let className = String(describing: self)
        
        let storyboard = UIStoryboard.init(name: className, bundle: nil)
        
//        if let initialViewController = storyboard.instantiateInitialViewController() {
//            return initialViewController
//        } else {
//            fatalError("Can't initialize view controller \(self)")
//        }
        
        return storyboard.instantiateViewController(withIdentifier: className)
    }
}
