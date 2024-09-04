//
//  HeaderLocationDetailsView.swift
//  GTDriver
//
//  Created by mrustaa on 16/01/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit


class HeaderTabBarView: XibView {
    
    var buttonCloseClickCallback: (() -> Void)?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var blurView: UIVisualEffectView?
    @IBOutlet weak var tabbar: UITabBar!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var separatorViewHeight: NSLayoutConstraint?
    @IBOutlet weak var separatorViewY: NSLayoutConstraint?
    
    @IBOutlet weak var tabBarItem1: UITabBarItem!
    @IBOutlet weak var tabBarItem2: UITabBarItem!
    @IBOutlet weak var tabBarItem3: UITabBarItem!
    @IBOutlet weak var tabBarItem4: UITabBarItem!
    
    func addBlur(darkStyle: Bool) {
        let style: UIBlurEffect.Style = darkStyle ? .systemThinMaterialDark : .systemChromeMaterialLight
        blurView?.effect = UIBlurEffect(style: style)
    }
    
    override func loadedFromNib() {
        separatorViewY?.constant = 0.0
        separatorViewHeight?.constant = 0.5
        
        tabBarItem1.title = _L("LNG_MAPS_DRIVE")
        tabBarItem2.title = _L("LNG_MAPS_WALK")
        tabBarItem3.title = _L("LNG_MAPS_TRANSIT")
        tabBarItem4.title = _L("LNG_MAPS_RIDE")
        
        tabbar.selectedItem = tabbar.items![0]
        tabbar.barTintColor = UIColor.clear
        tabbar.backgroundImage = UIImage()
        tabbar.shadowImage = UIImage()
    }
    
    @IBAction func buttonCloseAction(_ sender: Any) {
        buttonCloseClickCallback?()
    }
    
}

