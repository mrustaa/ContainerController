//
//  TripsDayEmptyView.swift
//  GTDriver
//
//  Created by mrustaa on 16/01/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

class MapsWeatherView: XibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var mainView: DesignView!
    var visualEffectView: UIVisualEffectView?
    @IBOutlet weak var textLabel: UILabel!
    
    override func loadedFromNib() {
        backgroundColor = .clear
        mainView.fillColor = .clear
    }
    
    public func addBlur(darkStyle: Bool) {
        let style: UIBlurEffect.Style = darkStyle ? .systemThinMaterialDark : .systemChromeMaterialLight
        
        textLabel.textColor = darkStyle ? .white : .black
        
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
        visualEffectView?.layer.cornerRadius = 6.0
        visualEffectView?.layer.masksToBounds = true
        visualEffectView?.autoresizingMask = [.flexibleLeftMargin, .flexibleWidth, .flexibleRightMargin, .flexibleTopMargin, .flexibleHeight, .flexibleBottomMargin]
    }
    
}
