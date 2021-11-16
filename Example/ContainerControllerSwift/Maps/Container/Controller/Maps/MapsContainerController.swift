//
//  MapsContainerController.swift
//  PatternsSwift
//
//  Created by mrustaa on 04/05/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit
import ContainerControllerSwift

class MapsContainerController: ContainerController, ContainerControllerDelegate {
    
    // MARK: - Properties
    
    var mapsDelegate: MapsContainerControllerDelegate?
    
    var tableView: TableAdapterView!
    var items: [TableAdapterItem] = []
    
    var darkStyle: Bool = false
    var searchSelected: Bool = false
    
    var headerSearchBarView: HeaderSearchBarView!
    
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
        add(headerView: headerSearchBarView)
        
    }
    
    // MARK: - Delegate
    
    func containerControllerMove(_ controller: ContainerController, position: CGFloat, type: ContainerMoveType, animation: Bool) {

        mapsDelegate?.mapsContainerController(move: self, position: position, type: type, animation: animation)
        
        if animation, type != .top {
            headerSearchBarView.searchBar.setShowsCancelButton(false, animated: true)
            updateTableView(searchSelected: false)
        }
    }
    
    //MARK: - Update Container-View
    
    func updateContainerView() {
        
        view.addBlur(darkStyle: darkStyle)
        view.cornerRadius = 12
        view.addShadow()
    }
    
    //MARK: - Update Container-View
    
    func updateHeaderView() {
        
        headerSearchBarView = HeaderSearchBarView()
        headerSearchBarView.searchBarBeginEditingCallback = { [weak self] in
            guard let _self = self else { return }
            
            _self.updateTableView(searchSelected: true)
            _self.move(type: .top)
        }
        headerSearchBarView.searchBarCancelButtonClickedCallback = { [weak self] in
            guard let _self = self else { return }
            
            _self.controller?.view.endEditing(true)
            _self.updateTableView(searchSelected: false)
            _self.move(type: .middle)
        }
    }
    
    //MARK: - Update DarkStyle
    
    func update(darkStyle: Bool) {
        
        self.darkStyle = darkStyle
        
        headerSearchBarView.set(darkStyle: darkStyle)
        
        view.addBlur(darkStyle: darkStyle)
        
        
        loadItems()
        tableView.indicatorStyle = darkStyle ? .white : .default
        tableView.set(items: items, animated: true)
    }
    
    func updateTableView(searchSelected: Bool) {
        if self.searchSelected == searchSelected { return }
        
        self.searchSelected = searchSelected
        
        loadItems()
        tableView.indicatorStyle = darkStyle ? .white : .default
        tableView.set(items: items, animated: true)
    }
    
    //MARK: - Update TableView
    
    func updateTableView() {
        
        tableView = TableAdapterView()
        tableView.indicatorStyle = darkStyle ? .white : .default
        tableView.set(items: items, animated: true)
        tableView.selectIndexCallback = { [weak self] (index: Int) -> Void in
            guard let _self = self, _self.items[index] is MapsLocationCellItem else { return }
            
            _self.showLocationDetails()
        }
        tableView.didScrollCallback = { [weak self] in
            guard let _self = self else { return }
            
            _self.controller?.view.endEditing(true)
//            let state =  _self.tableView.panGestureRecognizer.state
//            print("\(state)")
//
//            switch _self.tableView.panGestureRecognizer.state {
//                case .began:
//                default: break
//            }
            
            _self.headerSearchBarView.separatorView?.alpha = (_self.tableView.contentOffset.y <= 0) ? 0.0 : 1.0
        }
        tableView.separatorColor = Colors.rgba(128, 128, 128, 0.6)
    }
    
    func loadItems() {
        
        items = []
        
        if searchSelected {
            
            let orange: UIColor = Colors.rgb(248, 149, 64)
            let yellow: UIColor = Colors.rgb(255, 179, 0)
            let blue: UIColor = Colors.rgb(29, 160, 255)
            let red: UIColor = Colors.rgb(255, 93, 90)
            
            
            items.append( MapsSectionCellItem(title: _L("LNG_MAPS_RECENT_SEARCH"), textButton: _L("LNG_MAPS_SECTION_SEE_ALL")) )
            
            items.append( MapsSearchCellItem(darkStyle: darkStyle, title: _L("LNG_MAPS_RECENT_CITY"), color: .clear, separator: false) )
            
            items.append( MapsSectionCellItem(title: _L("LNG_MAPS_NEARBY_SEARCH"), textButton: "") )
            
            items.append( MapsSearchCellItem(darkStyle: darkStyle, title: _L("LNG_MAPS_NEARBY_RESTAURANTS"), color: orange) )
            items.append( MapsSearchCellItem(darkStyle: darkStyle, title: _L("LNG_MAPS_NEARBY_FOOD_DELIVERY"), color: orange) )
            items.append( MapsSearchCellItem(darkStyle: darkStyle, title: _L("LNG_MAPS_NEARBY_GROCERIES"), color: yellow) )
            items.append( MapsSearchCellItem(darkStyle: darkStyle, title: _L("LNG_MAPS_NEARBY_GAS_STATION"), color: blue) )
            items.append( MapsSearchCellItem(darkStyle: darkStyle, title: _L("LNG_MAPS_NEARBY_PHARMACIES"), color: red) )
            items.append( MapsSearchCellItem(darkStyle: darkStyle, title: _L("LNG_MAPS_NEARBY_HOSPITALS"), color: red) )
            items.append( MapsSearchCellItem(darkStyle: darkStyle, title: _L("LNG_MAPS_NEARBY_URGENT_CARE"), color: red) )
            items.append( MapsSearchCellItem(darkStyle: darkStyle, title: _L("LNG_MAPS_NEARBY_SUBWAY"), color: blue) )
            items.append( MapsSearchCellItem(darkStyle: darkStyle, title: _L("LNG_MAPS_NEARBY_TRAIN_STATION"), color: blue) )
            items.append( MapsSearchCellItem(darkStyle: darkStyle, title: _L("LNG_MAPS_NEARBY_SHOPPING_CENTERS"), color: yellow) )
            
        } else {
            
            items.append( MapsSectionCellItem(title: _L("LNG_MAPS_SECTION_FAVORITES")) )
            items.append( MapsFavoritesCellItem(darkStyle: darkStyle, clickCallback: { [weak self] in
                 guard let _self = self else { return }
                
                _self.showLocationDetails()
            }) )
            
            items.append( MapsSectionCellItem(title: _L("LNG_MAPS_SECTION_COLLECTIONS")) )
            items.append( MapsCollectionsCellItem() )
            
            items.append( MapsSectionCellItem(title: _L("LNG_MAPS_SECTION_RECENTLY_VIEWED")) )
            
            for index in 1...7 {
                let title = String(format: "%@ %d", _L("LNG_MAPS_MARKED_LOCATION"), index)
                let subtitle = String(format: "%@, %d/2, %@", _L("LNG_MAPS_STREET"), index, _L("LNG_MAPS_CITY"))
                items.append( MapsLocationCellItem(title: title, subtitle: subtitle, colorType: .red, darkStyle: darkStyle) )
            }
            for index in 8...11 {
                let title = String(format: "%@ %d", _L("LNG_MAPS_MARKED_LOCATION"), index)
                let subtitle = _L("LNG_MAPS_DIRECTIONS_MY_LOCATION")
                items.append( MapsLocationCellItem(title: title, subtitle: subtitle, colorType: .black, darkStyle: darkStyle) )
            }
            
        }
    }
    
    //MARK: - Show Location-Details
    
    func showLocationDetails() {
        
        mapsDelegate?.mapsContainerController(showLocationDetails: self)
        
    }
}
