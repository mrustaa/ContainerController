//
//  ExampleCellStyle.swift
//  ContainerController
//
//  Created by mrustaa on 02/06/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit
import ContainerControllerSwift

// MARK: - Cell Style

class ExampleCell: TableAdapterCell {
    
}

extension ExampleCell {
    
    public enum Style: String {
        case `default` = ""
        case shadowContainer = "ShadowContainer"
        case navbarTranslucent = "NavbarTranslucent"
        case movingEnabled = "MovingEnabled"
        case cornerRadius = "CornerRadius"
        case footerPadding = "FooterView.Padding"
        case headerView = "HeaderView"
        case footerView = "FooterView"
        case color = "BackgroundColor"
        case blur = "Blur"
        case scroll = "ScrollView"
        case trackingPosition = "TrackingPosition"
        case scrollIndicatorInsetsTop = "↓ .Scroll.Indicator.Insets.Top"
        case scrollIndicatorInsetsBottom = "↑ .Scroll.Indicator.Insets.Bottom"
        case moveType = "MoveType"
        case top = "↓ .Top"
        case middle = "↑ .Middle"
        case bottom = "↑ .Bottom "
        case middleEnable = "MiddleEnable"
        case insetsRight = "Insets.Right"
        case insetsLeft = "Insets.Left"
        case shadowBackground = "ShadowBackground"
        case landscapeTop = "↓ Landscape.Top"
        case landscapeMiddle = "↑ Landscape.Middle"
        case landscapeBottom = "↑ Landscape.Bottom "
        case landscapeMiddleEnable = "Landscape.MiddleEnable"
        case landscapeInsetsRight = "Landscape.Insets.Right"
        case landscapeInsetsLeft = "Landscape.Insets.Left"
        case landscapeShadowBackground = "Landscape.ShadowBackground"
    }
    
}
