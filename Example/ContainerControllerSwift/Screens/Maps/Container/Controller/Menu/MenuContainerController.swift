//
//  LocationContainerController.swift
//  PatternsSwift
//
//  Created by mrustaa on 04/05/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit
import ContainerControllerSwift

class MenuContainerController: ContainerController, ContainerControllerDelegate {
    
    // MARK: - Properties
    
    var menuDelegate: MenuContainerControllerDelegate?
    
    var tableView: TableAdapterView!
    var items: [TableAdapterItem] = []
    var header: MapsMenuHeader!
    
    var selectedIndex: Int = 0
    var darkStyle: Bool = false
    
    // MARK: - Init
    
    public init(addTo controller: UIViewController, darkStyle: Bool, selectedIndex: Int) {
        super.init(addTo: controller,
                   layout: MapsMenuContainerLayout())
        
        self.darkStyle = darkStyle
        self.selectedIndex = selectedIndex
        
        self.delegate = self
        
        loadItems()
        updateTableView()
        updateContainerView()
        updateHeaderView()
        
        add(scrollView: tableView)
        add(headerView: header)
        
        move(type: .top)
    }
    
    // MARK: - Delegate
    
    func containerControllerShadowClick(_ containerController: ContainerController) {
        closeContainer()
    }
    
    func closeContainer() {
        remove(completion: { [weak self] in
            guard let _self = self else { return }
            _self.menuDelegate?.menuContainerController(closeComplection: _self)
        })
        menuDelegate?.menuContainerController(close: self)
    }
    
    //MARK: - Update Container-View
    
    func updateContainerView() {
        
        view.addBlur(darkStyle: darkStyle)
        view.cornerRadius = 12
        view.addShadow()
    }
    
    //MARK: - Update Container-View
    
    func updateHeaderView() {
        
        header = MapsMenuHeader()
        
        header.set(darkStyle: darkStyle)
        header.buttonCloseClickCallback = { [weak self] in
            guard let _self = self else { return }
            _self.closeContainer()
        }
    }
    
    //MARK: - Update TableView
    
    func updateTableView() {
        
        tableView = TableAdapterView(frame: CGRect(x: 0, y: 0, width: ContainerDevice.width, height: 0), style: .plain)
        tableView.set(items: items, animated: true)
        tableView.separatorColor = Colors.rgba(128, 128, 128, 0.6)
        
        tableView.selectIndexCallback = { index in
            if index == 6 {
                self.menuDelegate?.menuContainerControllerBack()
            }
        }
    }
    
    
    func loadItems() {
        
        items = []
        
        items.append( MapsMenuSegmentCellItem(selected: selectedIndex, darkStyle: darkStyle, selectIndexCallback: { [weak self] (_ index: Int) in
            guard let _self = self else { return }
            
            _self.selectedIndex = index
            
            _self.menuDelegate?.menuContainerController(segment: _self, selectedIndex: index)
            
            _self.darkStyle = (index == 2)
            
            _self.view.addBlur(darkStyle: _self.darkStyle)
            _self.header.set(darkStyle: _self.darkStyle)
            
            _self.loadItems()
            _self.tableView.set(items: _self.items, animated: true)
        }) )
        
        items.append( MapsMenuTextCellItem(title: _L("LNG_MAPS_MENU_TRAFFIC"), switchShow: true, darkStyle: darkStyle, separator: false) )
        
        items.append( MapsMenuSpaceCellItem() )
        
        items.append( MapsMenuTextCellItem(title: _L("LNG_MAPS_SECTION_MARK_MY_LOCATION")) )
        items.append( MapsMenuTextCellItem(title: _L("LNG_MAPS_LOCATION_ADD_A_MISSING_PLACE")) )
        items.append( MapsMenuTextCellItem(title: _L("LNG_MAPS_SECTION_REPORT_AN_ISSUE")) )
        items.append( MapsMenuTextCellItem(title: _L("< Back"), separator: false) )
        
        items.append( MapsMenuSpaceCellItem() )
        // items.append( MapsMenuSpaceCellItem(cellHeight: 100) )
        
    }
    
}
