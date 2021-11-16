//
//  LocationContainerController.swift
//  PatternsSwift
//
//  Created by mrustaa on 04/05/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit
import ContainerControllerSwift

class LocationContainerController: ContainerController, ContainerControllerDelegate {
    
    // MARK: - Properties
    
    var locationDelegate: LocationContainerControllerDelegate?
    
    var tableView: TableAdapterView!
    var items: [TableAdapterItem] = []
    
    var darkStyle: Bool = false
    
    var header: HeaderDetailsView!
    
    // MARK: - Init
    
    public init(addTo controller: UIViewController, darkStyle: Bool) {
        super.init(addTo: controller,
                   layout: MapsMainContainerLayout())
        
        self.darkStyle = darkStyle

        self.delegate = self
        
        loadItems()
        updateTableView()
        updateContainerView()
        updateHeaderView()
        
        add(scrollView: tableView)
        add(headerView: header)
    }
    
    // MARK: - Delegate
    
    func containerControllerMove(_ controller: ContainerController, position: CGFloat, type: ContainerMoveType, animation: Bool) {
        locationDelegate?.locationContainerController(move: self, position: position, type: type, animation: animation)
    }
    
    //MARK: - Update Container-View
    
    func updateContainerView() {
        
        view.addBlur(darkStyle: darkStyle)
        view.cornerRadius = 12
        view.addShadow()
    }
    
    //MARK: - Update Container-View
    
    func updateHeaderView() {
        
        header = HeaderDetailsView()
        header.height = 60
        header.titleLabel.text = _L("LNG_MAPS_MARKED_LOCATION")
        header.subtitle.text = "27 \(_L("LNG_MAPS_KM"))"
        header.add(darkStyle: darkStyle)
        header.buttonCloseClickCallback = { [weak self] in
            guard let _self = self else { return }
            
            _self.remove(completion: { [weak self] in
                guard let __self = self else { return }
                
                _self.locationDelegate?.locationContainerController(closeComplection: __self)
            })
            _self.locationDelegate?.locationContainerController(close: _self)
        }
    }
    
    //MARK: - Update DarkStyle
    
    func update(darkStyle: Bool) {
        
        self.darkStyle = darkStyle
        view.addBlur(darkStyle: darkStyle)
        header.add(darkStyle: darkStyle)
        
        loadItems()
        tableView.indicatorStyle = darkStyle ? .white : .default
        tableView.set(items: items, animated: true)
    }
    
    //MARK: - Update TableView
    
    func updateTableView() {
        
        tableView = TableAdapterView(frame: CGRect(x: 0, y: 0, width: ContainerDevice.width, height: 0), style: .plain)
        tableView.indicatorStyle = darkStyle ? .white : .default
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: ContainerDevice.width, height: 18))
        tableView.set(items: items, animated: true)
        
        tableView.didScrollCallback = { [weak self] in
            guard let _self = self else { return }
            
            _self.header.separatorView?.alpha = (_self.tableView.contentOffset.y <= 0) ? 0.0 : 1.0
        }
        tableView.separatorColor = Colors.rgba(128, 128, 128, 0.6)
    }
    
    func loadItems() {
        
        items = []
        
       
        
        items.append( LocationButtonCellItem(title: _L("LNG_MAPS_LOCATION_DIRECTIONS"),
                                             subtitle: "25 \(_L("LNG_MAPS_MIN")) drive",
                                             type: .blue, clickCallback: { [weak self] in
            guard let _self = self else { return }
            
            _self.presentRoute()
        }) )
        items.append( LocationButtonCellItem(title: _L("LNG_MAPS_LOCATION_EDIT"), type: .gray) )
        
        items.append( LocationAddressCellItem(darkStyle: darkStyle) )
        items.append( LocationCollectionsButtonCellItem() )
        items.append( LocationCoordinateCellItem(darkStyle: darkStyle) )
        
        items.append( LocationTextCellItem(title: _L("LNG_MAPS_LOCATION_ADD_TO_FAVORITES"), image: UIImage(systemName: "star.fill")) )
        items.append( LocationTextCellItem(title: _L("LNG_MAPS_LOCATION_CREATE_NEW_CONTACT"), image: UIImage(systemName: "person.crop.circle")) )
        items.append( LocationTextCellItem(title: _L("LNG_MAPS_LOCATION_ADD_TO_EXISTING_CONTACT"), image: UIImage(systemName: "person.crop.circle.badge.plus")) )
        items.append( LocationTextCellItem(title: _L("LNG_MAPS_LOCATION_ADD_A_MISSING_PLACE"), image: UIImage(systemName: "plus")) )
        
    }
    
    //MARK: - Show Route
    
    func presentRoute() {
        locationDelegate?.locationContainerController(showRoute: self)
    }
}
