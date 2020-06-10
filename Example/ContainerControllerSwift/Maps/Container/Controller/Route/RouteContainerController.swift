//
//  LocationContainerController.swift
//  PatternsSwift
//
//  Created by mrustaa on 04/05/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit
import ContainerControllerSwift

open class RouteContainerController: ContainerController, ContainerControllerDelegate {
    
    // MARK: - Properties
    
    var routeDelegate: RouteContainerControllerDelegate?
    
    var tableView: TableAdapterView!
    var items: [TableAdapterItem] = []
    
    var darkStyle: Bool = false
    
    var tabbar: HeaderTabBarView!
    var header: HeaderDetailsView!
    var tableHeader: TableHeaderSpinerView?
    var routeLayout: MapsRouteContainerLayout
    
    // MARK: - Init
    
    public init(addTo controller: UIViewController, darkStyle: Bool) {
        
        routeLayout = MapsRouteContainerLayout()
        
        super.init(addTo: controller,
                   layout: routeLayout)
        
        self.darkStyle = darkStyle
        
        self.delegate = self
        
        loadTableItems()
        loadTableView()
        
        loadContainerView()
        loadHeaderView()
        loadTabBarBottom()
        
        add(scrollView: tableView)
        add(headerView: header)
        add(footerView: tabbar)
    }
    
    // MARK: - Delegate
    
    public func containerControllerMove(_ controller: ContainerController, position: CGFloat, type: ContainerMoveType, animation: Bool) {
        routeDelegate?.routeContainerController(move: self, position: position, type: type, animation: animation)
        
        if let tableHeader = tableHeader {
            
            if animation {
                UIView.animate(withDuration: 0.55, animations: { [weak self] in
                    guard let _self = self else { return }

                    switch type {
                    case .top:    tableHeader.height = (ContainerDevice.height - (_self.layout.positions.top + _self.header.height + _self.tabbar.height))
                    case .middle: tableHeader.height = MapsRouteCellData.height()
                    case .bottom: tableHeader.height = 0.0
                    default: break
                    }
                })
                
            } else {
                tableHeader.height = tableView.height
            }
        }
    }
    
    //MARK: - Update Container-View
    
    func loadContainerView() {
        
        view.addBlur(darkStyle: darkStyle)
        view.cornerRadius = 12
        view.addShadow()
    }
    
    //MARK: - Update Container-View
    
    func loadTabBarBottom() {
        
        tabbar = HeaderTabBarView()
        tabbar.height = (49.0 + ContainerDevice.isIphoneXBottom)
        tabbar.addBlur(darkStyle: darkStyle)
        
    }
    
    func loadHeaderView() {
        
        header = HeaderDetailsView()
        header.height = 78
        header.separatorView?.alpha = 1.0
        header.titleLabel.text = "\(_L("LNG_MAPS_WHERE")) \(_L("LNG_MAPS_MARKED_LOCATION"))"
        header.subtitle.text = _L("LNG_MAPS_FROM")
        header.textButton.setTitle(_L("LNG_MAPS_MY_LOCATION"), for: .normal)
        header.add(darkStyle: darkStyle)
        header.buttonCloseClickCallback = { [weak self] in
            guard let _self = self else { return }
            
            if let tab = _self.tabbar {
                tab.removeFromSuperview()
            }
            _self.remove(completion: { [weak self] in
                guard let __self = self else { return }
                _self.routeDelegate?.routeContainerController(closeComplection: __self)
            })
            _self.routeDelegate?.routeContainerController(close: _self)
        }
    }
    
    //MARK: - Update DarkStyle
    
    func update(darkStyle: Bool) {
        
        self.darkStyle = darkStyle
        view.addBlur(darkStyle: darkStyle)
        header.add(darkStyle: darkStyle)
        tabbar?.addBlur(darkStyle: darkStyle)
        
        loadTableItems()
        tableView.indicatorStyle = darkStyle ? .white : .default
        tableView.set(items: items, animated: true)
    }
    
    
    //MARK: - Update TableView
    
    func loadTableView() {
        
        tableView = TableAdapterView(frame: CGRect(x: 0, y: 0, width: ContainerDevice.width, height: 0), style: .plain)
        tableView.indicatorStyle = darkStyle ? .white : .default
        tableView.separatorColor = Colors.rgba(128, 128, 128, 0.6)
        
        tableHeader = TableHeaderSpinerView()
        tableHeader?.width = ContainerDevice.width
        tableHeader?.backgroundColor = .clear
        tableView.tableHeaderView = tableHeader
        
        main(delay: 2.5) { [weak self] in
            guard let _self = self else { return }

            _self.tableView.tableHeaderView = nil
            _self.tableHeader?.removeFromSuperview()
            _self.tableHeader = nil
            
            _self.routeLayout.footerPadding = MapsRouteCellData.height()
            
            _self.tableView.set(items: _self.items, animated: true)
        }
    }
    
    public func main(delay: Double, work: @escaping () -> Void) {
        let deadline = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            work()
        }
    }
    
    func loadTableItems() {
        
        items = []
        
        items.append( MapsRouteCellItem(darkStyle: darkStyle, title: "15 \(_L("LNG_MAPS_MIN"))", subtitle: "24 \(_L("LNG_MAPS_KM")) · \(_L("LNG_MAPS_STREET")) 1234541\n\(_L("LNG_ROUTE_FASTEST"))", selected: true) )
        items.append( MapsRouteCellItem(darkStyle: darkStyle, title: "40 \(_L("LNG_MAPS_MIN"))", subtitle: "31 \(_L("LNG_MAPS_KM")) · \(_L("LNG_MAPS_STREET")) \(_L("LNG_ROUTE_UNKNOWN"))...\n№ 7029") )
        items.append( MapsRouteCellItem(darkStyle: darkStyle, title: "45 \(_L("LNG_MAPS_MIN"))", subtitle: "29 \(_L("LNG_MAPS_KM")) · \(_L("LNG_MAPS_STREET")) \(_L("LNG_ROUTE_UNKNOWN"))\n\(_L("LNG_ROUTE_SIMPLEST"))") )
        items.append( MapsRouteCellItem(darkStyle: darkStyle, title: "45 \(_L("LNG_MAPS_MIN"))", subtitle: "29 \(_L("LNG_MAPS_KM")) · \(_L("LNG_MAPS_STREET")) \(_L("LNG_ROUTE_UNKNOWN"))\n\(_L("LNG_ROUTE_SIMPLEST"))") )
        
        items.append( MapsSectionCellItem(title: _L("LNG_MAPS_SECTION_DRIVING_OPTIONS"), textButton: "") )
        items.append( MapsSectionCellItem(title: _L("LNG_MAPS_SECTION_REPORT_AN_ISSUE"), textButton: "") )
    }
    
}
