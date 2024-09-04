//
//  MapsViewController.swift
//  PatternsSwift
//
//  Created by mrustaa on 02/05/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import ContainerControllerSwift

class MapsViewController: StoryboardController, MapsContainerControllerDelegate, LocationContainerControllerDelegate, RouteContainerControllerDelegate, MenuContainerControllerDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var mapWeatherView: MapsWeatherView!
    
    @IBOutlet weak var mapButtons: MapsButtons!
    @IBOutlet weak var mapButtonsPaddingTop: NSLayoutConstraint!
    @IBOutlet weak var mapButtonsPaddingRight: NSLayoutConstraint!
    
    @IBOutlet weak var statusBlur: UIVisualEffectView!
    @IBOutlet weak var statusBarBlurHeight: NSLayoutConstraint!
    
    // MARK: - Properties
    
    var mapManager: MapViewManager!
    
    var mapsContainer: MapsContainerController!
    var locationContainer: LocationContainerController?
    var routeContainer: RouteContainerController?
    var menuContainer: MenuContainerController!
    
    var darkStyle: Bool = false
    var selectedIndex: Int = 0
    var showOnce: Bool = false
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        updateMapManager()
        
        showMapsContainer()
        
        updateMapViewButtons()
        updateMapViewWeatherView()
        updateMapViewTopPadding()
        startAnimationMapElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isTranslucent = false
        
        setNeedsStatusBarAppearanceUpdate()
        
        navBar(hide: true)
        if !showOnce {
            mapsContainer.move(type: .hide, animation: false)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !showOnce {
            showOnce = true
            mapsContainer.move(type: .middle)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navBar(hide: false)
    }
    
//    func navBar(hide: Bool) {
//        self.navigationController?.setNavigationBarHidden(hide, animated: true)
//    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        mapsContainer.remove()
        mapsContainer = nil
        
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - StatusBar Style
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return darkStyle ? .lightContent : .default
    }
    
    // MARK: -  Rotation Callback
    
    @objc func rotated() {
        
        if !UIDevice.current.orientation.isRotateAllowed { return }
        
        updateMapViewTopPadding()
    }
    
    func updateMapViewTopPadding() {
        
        let padding: CGFloat = 8
        
        statusBarBlurHeight.constant = ContainerDevice.statusBarHeight
        
        let paddingX: CGFloat = (ContainerDevice.isIphoneX ? ContainerDevice.isIphoneXTop : padding)
        
        var paddingWeatherTop: CGFloat = 0.0
        var paddingTop: CGFloat = 0.0
        var paddingRight: CGFloat = 0.0
        
        let paddingStatusBar: CGFloat = (ContainerDevice.statusBarHeight + padding)
        
        switch ContainerDevice.orientation {
        case .portrait:
            paddingTop = paddingStatusBar
            paddingRight = padding
            paddingWeatherTop = padding
        case .landscapeLeft:
            paddingTop = ContainerDevice.isIpad ? paddingStatusBar : paddingX
            paddingRight = ContainerDevice.isIphoneX ? 44 : padding
            paddingWeatherTop = paddingX
        case .landscapeRight:
            paddingTop = ContainerDevice.isIpad ? paddingStatusBar : paddingX
            paddingRight = paddingX
            paddingWeatherTop = paddingX
        }
        
        var width: CGFloat = 0.0
        var height: CGFloat = 0.0


        switch ContainerDevice.orientation {
        case .portrait:
            width = ContainerDevice.screenMin
            height = ContainerDevice.screenMax
        case .landscapeLeft,
             .landscapeRight:
            width = ContainerDevice.screenMax
            height = ContainerDevice.screenMin
        }
        
        mapWeatherView.x = (width - mapWeatherView.width - paddingRight)
        
        
        if ContainerDevice.isPortrait, !ContainerDevice.isIpad {
            mapWeatherView.y = (mapsContainer.view.y - mapWeatherView.height - paddingWeatherTop)
        } else {
            mapWeatherView.y = (height - mapWeatherView.height - paddingWeatherTop)
        }

        mapButtonsPaddingTop.constant = paddingTop
        mapButtonsPaddingRight.constant = paddingRight
        
        mapManager.compass.x = (ContainerDevice.width - 47)
        mapManager.compass.y = (paddingTop + mapButtons.height + 12)
    }
    
    // MARK: - Map Manager
    
    func updateMapManager() {
    
        mapManager = MapViewManager(mapView: mapView)
        mapManager.compass.y = (mapButtons.bottom + 12)
        mapManager.selectPinCallback = { [weak self] in
            guard let _self = self else { return }
            _self.mapsContainer.showLocationDetails()
        }
        mapManager.changeRegionCallback = { [weak self] in
        guard let _self = self else { return }
            _self.mapButtons.changeButtonLocation(fill: false)
        }
    }
    
    // MARK: - Map Long-Press
    
    @IBAction func handleLong(_ recognizer: UILongPressGestureRecognizer) {
        if routeContainer != nil { return }
        
        switch recognizer.state {
        case .began:
            
            mapManager.addMapPinFrom(longPress: recognizer)
            mapsContainer.showLocationDetails()
            
        default: break
        }
    }
    
    
    // MARK: - Map Buttons Update
    
    func updateMapViewButtons() {
        
        mapButtons.addBlur(darkStyle: darkStyle)
        mapButtons.alpha = 0.0
        mapButtons.buttonsActionCallback = { [weak self] (_ index: Int) in
            guard let _self = self else { return }
            
            if (index == 0) {
                _self.showMenuContainer()
            } else {
                _self.mapButtons.changeButtonLocation(fill: true)
                
                if let coor = _self.mapView.userLocation.location?.coordinate {
                    _self.mapView.setCenter(coor, animated: true)
                }
            }
        }
        
    }
    
    func updateMapViewWeatherView() {
        
        mapWeatherView.addBlur(darkStyle: darkStyle)
        mapWeatherView.alpha = 0.0
    }
    
    func startAnimationMapElements() {
        
        UIView.animate(withDuration: 1.0, animations: { [weak self] in
            guard let _self = self else { return }
            _self.mapWeatherView.alpha = 1.0
            _self.mapButtons.alpha = 1.0
        })
    }
    
    // MARK: - Map Buttons Alpha
    
    func mapButtons(alpha: CGFloat, animation: Bool = true) {
        if ContainerDevice.isPortrait, !ContainerDevice.isIpad {
            if animation {
                UIView.animate(withDuration: 0.15, animations: { [weak self] in
                    guard let _self = self else { return }
                    _self.mapButtons.alpha = alpha
                    _self.mapWeatherView.alpha = alpha
                })
            } else {
                mapButtons.alpha = alpha
                mapWeatherView.alpha = alpha
            }
        } else {
            mapButtons.alpha = 1.0
            mapWeatherView.alpha = 1.0
        }
    }
    
    // MARK: - Change Position MapElements
    
    func changePositionMapsElements(container: ContainerController, position: CGFloat, type: ContainerMoveType, animation: Bool) {
        if type == .hide { return }
        
        let result = (container.positionMiddle - position)
        var alpha: CGFloat = (1.0 - (result / 20.0))
        
        if 20.0 < result {
            alpha = 0.0
        } else if result < 0.0 {
            alpha = 1.0
        }
        
        if animation {
            if type == .top {
                mapButtons(alpha: 0.0, animation: true)
            } else {
                mapButtons(alpha: 1.0, animation: true)
            }
            
            if type != .top {
                if ContainerDevice.isPortrait, !ContainerDevice.isIpad {
                    mapWeatherView.y = (position - mapWeatherView.height - 8)
                }
            }
            
        } else {
            mapButtons(alpha: alpha, animation: false)
            
            if ContainerDevice.isPortrait, !ContainerDevice.isIpad {
                if result < 0.0 {
                    mapWeatherView.y = (position - mapWeatherView.height - 8)
                } else {
                    mapWeatherView.y = (container.positionMiddle - mapWeatherView.height - 8)
                }
            }
        }
        
        if animation, type != .top {
            view.endEditing(true)
        }
    }
    
    // MARK: - Change Index Menu
    
    func menuChange(index: Int) {
        
        selectedIndex = index
        darkStyle = (index == 2)
        
        mapsContainer.update(darkStyle: darkStyle)
        locationContainer?.update(darkStyle: darkStyle)
        routeContainer?.update(darkStyle: darkStyle)
        
        mapButtons.addBlur(darkStyle: darkStyle)
        mapWeatherView.addBlur(darkStyle: darkStyle)
        
        switch selectedIndex {
        case 0: mapView.mapType = .standard
        case 1: mapView.mapType = .mutedStandard
        case 2: mapView.mapType = .hybrid
        default: break
        }
        
        let style: UIBlurEffect.Style = darkStyle ? .systemUltraThinMaterialDark : .regular
        statusBlur.effect = UIBlurEffect(style: style)
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    // MARK: - Show Maps-Container
    
    func showMapsContainer() {
        mapsContainer = MapsContainerController(addTo: self, darkStyle: darkStyle)
        mapsContainer.mapsDelegate = self
    }
    
    // MARK: Delegate
    
    func mapsContainerController(showLocationDetails mapsContainerController: MapsContainerController) {
        mapsContainer.move(type: .hide)
        showLocationDetailsContainer()
        mapManager.selectPinAnimation(show: true)
    }
    
    func mapsContainerController(move mapsContainerController: MapsContainerController, position: CGFloat, type: ContainerMoveType, animation: Bool) {
        changePositionMapsElements(container: mapsContainerController, position: position, type: type, animation: animation)
    }
    
    //MARK: - Show Location-Details
    
    func showLocationDetailsContainer() {
        if locationContainer != nil { return }
        
        locationContainer = LocationContainerController(addTo: self, darkStyle: darkStyle)
        locationContainer?.locationDelegate = self
        locationContainer?.move(type: ContainerDevice.isPortrait ? .middle : .top)
    }
    
    // MARK: Delegate
    
    func locationContainerController(showRoute locationContainerController: LocationContainerController) {
        locationContainer?.move(type: .hide)
        showRouteContainer()
        mapManager.showRouteOnMapMyLocation()
    }
    
    func locationContainerController(close locationContainerController: LocationContainerController) {
        mapManager.selectPinAnimation(show: false)
        
        let animation = locationContainerController.oldMoveType != .middle
        
        mapsContainer.move(type: .middle, animation: animation)
    }
    
    func locationContainerController(closeComplection locationContainerController: LocationContainerController) {
        locationContainer = nil
    }
    
    func locationContainerController(move locationContainerController: LocationContainerController, position: CGFloat, type: ContainerMoveType, animation: Bool) {
        changePositionMapsElements(container: locationContainerController, position: position, type: type, animation: animation)
    }
    
    //MARK: - Show Route
    
    func showRouteContainer() {
        if routeContainer != nil { return }
        
        routeContainer = RouteContainerController(addTo: self, darkStyle: darkStyle)
        routeContainer?.routeDelegate = self
        routeContainer?.move(type: ContainerDevice.isPortrait ? .middle : .top)
    }
    
    // MARK: Delegate
    
    func routeContainerController(close routeContainerController: RouteContainerController) {
        mapManager.closeRoute(showSelectPin: true)
        locationContainer?.move(type: .middle)
    }
    
    func routeContainerController(closeComplection routeContainerController: RouteContainerController) {
        routeContainer = nil
    }
    
    func routeContainerController(move routeContainerController: RouteContainerController, position: CGFloat, type: ContainerMoveType, animation: Bool) {
        changePositionMapsElements(container: routeContainerController, position: position, type: type, animation: animation)
    }
    
    // MARK: - Show Menu-Container
    
    func showMenuContainer() {
        if menuContainer != nil { return }
        
        menuContainer = MenuContainerController(addTo: self, darkStyle: darkStyle, selectedIndex: selectedIndex)
        menuContainer?.menuDelegate = self
        
        mapButtons(alpha: 0.0)
    }
    
    // MARK: Delegate
    
    func menuContainerControllerBack() {
        self.back()
    }
    
    func menuContainerController(close menuContainerController: MenuContainerController) {
        mapButtons(alpha: 1.0)
    }
    
    func menuContainerController(closeComplection menuContainerController: MenuContainerController) {
        menuContainer = nil
    }
    
    func menuContainerController(segment menuContainerController: MenuContainerController, selectedIndex: Int) {
        menuChange(index: selectedIndex)
    }
}



