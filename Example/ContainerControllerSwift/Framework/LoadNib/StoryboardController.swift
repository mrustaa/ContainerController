//
//  StoryboardController.swift
//  PatternsSwift
//
//  Created by mrustaa on 20/04/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit
import ContainerControllerSwift

@IBDesignable
class StoryboardController: UIViewController {
    
    var navBarHide: Bool = false
    
    class func instantiate() -> UIViewController {
        return fromStoryboardController()
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if navBarHide {
            navigationController?.navigationBar.isTranslucent = false
            setNeedsStatusBarAppearanceUpdate()
            navBar(hide: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if navBarHide {
            navBar(hide: false)
        }
    }
    
    func navBar(hide: Bool) {
        self.navigationController?.setNavigationBarHidden(hide, animated: true)
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

extension UIViewController {
    
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension StoryboardController: ContainerControllerDelegate {
    
    
    func addContainer(position: ContainerPosition, radius: CGFloat, items: [TableAdapterItem]? = nil, delegate: ContainerControllerDelegate? = nil, addShadow: Bool = true, addBackShadow: Bool = false, header: UIView? = nil, footer: UIView? = nil, back: UIView? = nil) -> (ContainerController, TableAdapterView) {
        
        let layoutC = ContainerLayout()
        layoutC.positions =  position //
        layoutC.insets = .init(right: 0, left: 0)
        let container = ContainerController(addTo: self, layout: layoutC)
        container.view.cornerRadius = radius
        container.view.addShadow()
        container.view.tag = 13
        if let delegate = delegate {
            container.delegate = delegate
        } else {
            container.delegate = self
        }
        
        if addShadow {
//            let shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
            
            container.view.layer.shadowOpacity = Float(0.20)
            container.view.layer.shadowOffset = .init(width: 0, height: 13)
            container.view.layer.shadowRadius = 30.0
            container.view.layer.shadowColor = UIColor.black.cgColor
            
            
        }
        
        container.set(backgroundShadowShow: addBackShadow)
        
        container.view.backgroundColor = .white
        
        
        // container.view.backgroundColor = color
        
        if let headerV = header {
            container.add(headerView: headerV)
        }
        
        if let footerV = footer {
            container.add(footerView: footerV)
        }
        
        if let back = back {
            container.backView?.addSubview(back)
        }
        
       
            let table = TableAdapterView(frame: CGRect(x: 0, y: 0, width: ContainerDevice.width, height: 0), style: .plain)
            table.indicatorStyle =  .default
            // container.add(scrollView: addCollectionView())
            
        if let items = items {
            table.set(items: items )
            
            container.add(scrollView: table)
        }
        
        container.move(type: .hide, animation: false)
        
//        main(delay: 0.05) {
//            container.move(type: .top
//            )
//        }
        
        return (container, table)
    }
    
    
    func containerControllerMove(_ containerController: ContainerController, position: CGFloat, type: ContainerMoveType, animation: Bool) {
        if  animation {
            
        }
    }
    
    func containerControllerHandlePan(_ containerController: ContainerController, pan: UIPanGestureRecognizer) {
        
    }
}
