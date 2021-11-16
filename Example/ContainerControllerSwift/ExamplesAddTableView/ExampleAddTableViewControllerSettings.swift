//
//  ExampleAddTableViewControllerSettings.swift
//  ContainerControllerSwift
//
//  Created by mrustaa on 09.06.2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit
import ContainerControllerSwift

extension ExampleAddTableViewController {
    
    // MARK: - Settings
    
    func changeViewParametrs() {
        
        container.view.cornerRadius = 15 // Change cornerRadius global
        container.view.addShadow(opacity: 0.1) // Add layer shadow
        container.view.addBlur(style: .dark) // Add background blur UIVisualEffectView
    }
    
    func changeViewCustom() {
        
        // Add custom shadow
        let layer = container.view.layer
        layer.shadowOpacity = 0.5
        layer.shadowColor = UIColor.red.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 4)
        layer.shadowRadius = 5
        
        // Add view in container.view
        let viewRed = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        viewRed.backgroundColor = .systemRed
        container.view.addSubview(viewRed)
        
        // Add view under scrollView container.view
        let viewGreen = UIView(frame: CGRect(x: 25, y: 25, width: 50, height: 50))
        viewGreen.backgroundColor = .systemGreen
        container.view.insertSubview(viewGreen, at: 0)
    }
    
    func createLayout() {
        
        let layout = ContainerLayout()
        layout.startPosition = .hide
        layout.backgroundShadowShow = false
        layout.positions = ContainerPosition(top: 70, middle: 250, bottom: 70)
        
    }
    
    // MARK: - Change settings right away
    
    func changeRightAway() {
        
        // Properties
        container.set(movingEnabled: true)
        container.set(trackingPosition: false)
        container.set(footerPadding: 100)

        // Add ScrollInsets Top/Bottom
        container.set(scrollIndicatorTop: 5) // ↓
        container.set(scrollIndicatorBottom: 5) // ↑

        // Positions
        container.set(top: 70) // ↓
        container.set(middle: 250) // ↑
        container.set(bottom: 80) // ↑

        // Middle Enable/Disable
        container.set(middle: 250)
        container.set(middle: nil)

        // Background Shadow
        container.set(backgroundShadowShow: true)

        // Insets View
        container.set(left: 5) // →
        container.set(right: 5) // ←

        // Landscape params
        container.setLandscape(top: 30)
        container.setLandscape(middle: 150)
        container.setLandscape(bottom: 70)
        container.setLandscape(middle: nil)

        container.setLandscape(backgroundShadowShow: false)

        container.setLandscape(left:  10)
        container.setLandscape(right: 100)
    }
}
