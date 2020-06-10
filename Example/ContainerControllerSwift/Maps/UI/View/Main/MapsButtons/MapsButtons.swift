//
//  TripsDayEmptyView.swift
//  GTDriver
//
//  Created by mrustaa on 16/01/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

class MapsButtons: XibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var buttonMenu: UIButton!
    @IBOutlet weak var buttonLocation: UIButton!
    
    @IBOutlet weak var mainView: DesignView!
    var visualEffectView: UIVisualEffectView?
    
    var buttonsActionCallback: ((_ index: Int) -> Void)?
    
    override func loadedFromNib() {
        backgroundColor = .clear
    }
    
     // MARK: - IBAction
    
    public func changeButtonLocation(fill: Bool) {
        let sysName = fill ? "location.fill" : "location"
        buttonLocation.setImage(UIImage(systemName: sysName), for: .normal)
    }
    
    @IBAction func buttonInfoAction(_ sender: UIButton) {
        if let buttonsActionCallback = buttonsActionCallback {
            return buttonsActionCallback(0)
        }
    }
    
    @IBAction func buttonLocationAction(_ sender: UIButton) {
        if let buttonsActionCallback = buttonsActionCallback {
            return buttonsActionCallback(1)
        }
    }
    
    func addBlur(darkStyle: Bool) {
        let style: UIBlurEffect.Style = darkStyle ? .systemThinMaterialDark : .systemChromeMaterialLight
        
        buttonMenu.tintColor = darkStyle ? .white : .systemBlue
        buttonLocation.tintColor = darkStyle ? .white : .systemBlue
        
        mainView.fillColor = .clear
        
        if visualEffectView == nil {
            let blurView = UIVisualEffectView(effect: UIBlurEffect(style: style))
            mainView.insertSubview(blurView, at: 0)
            visualEffectView = blurView
        }
        
        visualEffectView?.effect = UIBlurEffect(style: style)
        visualEffectView?.bounds = bounds
        visualEffectView?.x = 0
        visualEffectView?.y = 0
        visualEffectView?.layer.cornerRadius = 8.0
        visualEffectView?.layer.masksToBounds = true
        visualEffectView?.autoresizingMask = [.flexibleLeftMargin, .flexibleWidth, .flexibleRightMargin, .flexibleTopMargin, .flexibleHeight, .flexibleBottomMargin]
    }
    
}
