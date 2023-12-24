//
//  ExamplesContainerController.swift
//  ContainerController
//
//  Created by mrustaa on 31/05/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit
import ContainerControllerSwift


class ExamplesContainerController: ContainerController, ExampleCellDelegate {
    
    // MARK: - Properties
    
    var items: [TableAdapterItem] = []
    
    // MARK: - Init
        
    public init(addTo controller: UIViewController, style: ExamplesContainerController.ScrollType) {
        
        let layout = ContainerLayout()
        layout.startPosition = .hide
        layout.backgroundShadowShow = false
        layout.positions = ContainerPosition(top: 70, middle: 250, bottom: 70)
        
        super.init(addTo: controller, layout: layout)
        
        loadContainerView()
        loadTableItems()
        
        var scrollIndex: CGFloat = 0
        switch style {
        case .tableAdapterView: scrollIndex = 1
        case .collectionAdapterView: scrollIndex = 2
        case .collectionAdapterView2: scrollIndex = 3
        case .textView: scrollIndex = 4
        default: break
        }
        
        exampleCell( TableAdapterCell(), type: .scroll, value: scrollIndex, endEditing: true)
    }
    
    //MARK: - Load Container-View
    
    func loadContainerView() {
        
        view.backgroundColor = .white
        view.cornerRadius = 15
        view.addShadow()
    }
    
    //MARK: - Load Items

    func loadTableItems() {
            
        items = []
        
        let h: CGFloat = 45
        
        items = [
            ExampleSegmentCellItem(height: h, delegate: self, type: .moveType,              segmentItems: ["Top", "Middle", "Bottom", "Hide"]),
            ExampleSegmentCellItem(height: h, delegate: self, type: .headerView,            segmentItems: ["-", "Grip", "Label", "Details", "Search"]),
            ExampleSegmentCellItem(height: h, delegate: self, type: .footerView,            segmentItems: ["-", "Button", "TabBar"]),
            ExampleSegmentCellItem(height: h, delegate: self, type: .color,                 segmentItems: ["-", ".white", ".red", ".green", ".blue"], index: 1),
            ExampleSegmentCellItem(height: h, delegate: self, type: .blur,                  segmentItems: ["-", "Light", "ExtraLight", "Dark"]),
            ExampleSegmentCellItem(height: h, delegate: self, type: .scroll,                segmentItems: ["-", "Table", "Coll", "Coll2", "Text"]),
            
             ExampleSwitchCellItem(height: h, delegate: self, type: .shadowBackground,      value: false),
             ExampleSliderCellItem(height: h, delegate: self, type: .shadowContainer,       value: 0.2, maximumValue: 1.0),
             ExampleSliderCellItem(height: h, delegate: self, type: .cornerRadius,          value: 15,  maximumValue: 140),
            
             ExampleSwitchCellItem(height: h, delegate: self, type: .navbarTranslucent,     value: false),
            
             ExampleSwitchCellItem(height: h, delegate: self, type: .movingEnabled,         value: true),
             ExampleSwitchCellItem(height: h, delegate: self, type: .trackingPosition,      value: false),
             ExampleSliderCellItem(height: h, delegate: self, type: .footerPadding,         value: 0,   maximumValue: Float(ContainerDevice.screenMax)),
             
             ExampleSliderCellItem(height: h, delegate: self, type: .top,                   value: 70,  maximumValue: 250),
             ExampleSliderCellItem(height: h, delegate: self, type: .middle,                value: 250, maximumValue: 500, minimumValue: 140),
             ExampleSliderCellItem(height: h, delegate: self, type: .bottom,                value: 70,  maximumValue: 300),
             ExampleSwitchCellItem(height: h, delegate: self, type: .middleEnable,          value: true),
             ExampleSliderCellItem(height: h, delegate: self, type: .insetsLeft,            value: 0,   maximumValue: Float(ContainerDevice.screenMin)),
             ExampleSliderCellItem(height: h, delegate: self, type: .insetsRight,           value: 0,   maximumValue: Float(ContainerDevice.screenMin)),
             
             ExampleSliderCellItem(height: h, delegate: self, type: .landscapeTop,          value: 20,  maximumValue: 250),
             ExampleSliderCellItem(height: h, delegate: self, type: .landscapeMiddle,       value: 150, maximumValue: 300, minimumValue: 70),
             ExampleSliderCellItem(height: h, delegate: self, type: .landscapeBottom,       value: 70,  maximumValue: 300),
             ExampleSwitchCellItem(height: h, delegate: self, type: .landscapeMiddleEnable, value: false),
             ExampleSliderCellItem(height: h, delegate: self, type: .landscapeInsetsLeft,   value: 0,   maximumValue: Float(ContainerDevice.screenMax)),
             ExampleSliderCellItem(height: h, delegate: self, type: .landscapeInsetsRight,  value: 0,   maximumValue: Float(ContainerDevice.screenMax)),
             
             ExampleSliderCellItem(height: h, delegate: self, type: .scrollIndicatorInsetsTop,    value: 0,   maximumValue: 300),
             ExampleSliderCellItem(height: h, delegate: self, type: .scrollIndicatorInsetsBottom, value: 0,   maximumValue: 300),
             
        ]
    }
        
    // MARK: - Cell Delegate
        
    func exampleCell(_ cell: TableAdapterCell, type: ExampleCell.Style, value: CGFloat, endEditing: Bool) {
            
        // print("\(type) \(value) ")
        let boolValue = (value == 1)
        
        switch type {
            case .top
                , .middle
                , .bottom
                , .landscapeTop
                , .landscapeMiddle
                , .landscapeBottom
                , .insetsLeft
                , .insetsRight
                , .landscapeInsetsLeft
                , .landscapeInsetsRight:
            if !endEditing { return }
            default: break
        }
        
        switch type {
            
            case .cornerRadius:                 self.view.cornerRadius = value
            
            case .shadowContainer:              self.view.addShadow(opacity: value)
            
            case .navbarTranslucent:            self.controller?.navigationController?.navigationBar.isTranslucent = boolValue; move(type: moveType)
            
            case .movingEnabled:                set(movingEnabled: boolValue)
            
            case .trackingPosition:             set(trackingPosition: boolValue)
                
            case .footerPadding:                set(footerPadding: value)
            
            // MARK: ScrollInsets
                
            case .scrollIndicatorInsetsTop:     set(scrollIndicatorTop: value)
            case .scrollIndicatorInsetsBottom:  set(scrollIndicatorBottom: value)
            
            // MARK: Positions
                
            case .top:             set(top: value);             if  ContainerDevice.isPortrait { move(type: .top) }
            case .middle:          set(middle: value);          if  ContainerDevice.isPortrait { move(type: .middle) }
            case .bottom:          set(bottom: value);          if  ContainerDevice.isPortrait { move(type: .bottom) }
                
            case .landscapeTop:    setLandscape(top: value);    if !ContainerDevice.isPortrait { move(type: .top) }
            case .landscapeMiddle: setLandscape(middle: value); if !ContainerDevice.isPortrait { move(type: .middle) }
            case .landscapeBottom: setLandscape(bottom: value); if !ContainerDevice.isPortrait { move(type: .bottom) }
            
            // MARK: MiddleEnable
            
            case .middleEnable:                 set(middle: (boolValue ? 250 : nil))
            
            case .landscapeMiddleEnable:        setLandscape(middle: (boolValue ? 150 : nil))
                
                
            // MARK: Background Shadow

            case .shadowBackground:             set(backgroundShadowShow: boolValue)
            
            case .landscapeShadowBackground:    setLandscape(backgroundShadowShow: boolValue)
                
            // MARK: Insets
                
            case .insetsLeft:                   set(left:  value)
            case .insetsRight:                  set(right: value)
                    
            case .landscapeInsetsLeft:          setLandscape(left:  value)
            case .landscapeInsetsRight:         setLandscape(right: value)
            
            // MARK: MoveType
                
            case .moveType:
                
                switch value {
                case 0:  move(type: .top)
                case 1:  move(type: .middle)
                case 2:  move(type: .bottom)
                default: move(type: .hide)
                }
                
           // MARK: ScrollViews
                
            case .scroll:
                
                switch value {
                case 1:  add(scrollView: createTableAdapterView(items: items, view: view))
                case 2:  add(scrollView: createMapsCollectionAdapterView())
                case 3:  add(scrollView: createCollectionAdapterView(width: view.width))
                case 4:  add(scrollView: createTextView())
                default: removeScrollView()
                }
                
                
            // MARK: HeaderView
                
            case .headerView:
                switch value {
                case 1:
                    let header = ExampleHeaderGripView()
                    header.height = 20
                    self.add(headerView: header)
                case 2:
                    let header = MapsMenuHeader()
                    header.titleLabel.text = "Settings"
                    header.separatorView?.alpha = 1.0
                    self.add(headerView: header)
                case 3:
                    let header = HeaderDetailsView()
                    header.titleLabel.text = "Title Header"
                    header.subtitle.text = "Subtitle"
                    header.textButton.setTitle("Button Text", for: .normal)
                    header.separatorView?.alpha = 1.0
                    self.add(headerView: header)
                case 4:
                    let header = HeaderSearchBarView()
                    header.separatorView?.alpha = 1.0
                    self.add(headerView: header)
                default:
                    self.removeHeaderView()
                }
                
            // MARK: FooterView
                
            case .footerView:
                switch value {
                case 1:
                    let footer = ExampleFooterButtonView()
                    self.add(footerView: footer)
                case 2:
                    let tabbar = HeaderTabBarView()
                    tabbar.height = (49.0 + ContainerDevice.isIphoneXBottom)
                    self.add(footerView: tabbar)
                default:
                    self.removeFooterView()
                }
                
            // MARK: BackgroundColor
                
            case .color:
                self.view.removeBlur()
                
                switch value {
                case 0: view.backgroundColor = .clear
                case 1: view.backgroundColor = .white
                case 2: view.backgroundColor = .systemRed
                case 3: view.backgroundColor = .systemGreen
                case 4: view.backgroundColor = .systemBlue
                default: break
                }
                
                
            // MARK: Blur
                
            case .blur:
                view.backgroundColor = .clear
                
                switch value {
                case 0: self.view.removeBlur()
                case 1: self.view.addBlur(style: .light)
                case 2: self.view.addBlur(style: .extraLight)
                case 3: self.view.addBlur(style: .dark)
                default: break
                }
            
            default: break
        }
            
        
        
    }
    
}


    

