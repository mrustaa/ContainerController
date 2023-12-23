//
//  MapViewController.swift
//  PatternsSwift
//
//  Created by mrustaa on 19/05/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import ContainerControllerSwift

class MapViewManager: NSObject {
    
    // MARK: Map Properties
    
    var mapView: MKMapView?
    var compass: MKCompassButton!
    
    var locationManager: CLLocationManager?
    
    var selectAnnotation: MKPointAnnotation?
    var routeOverlay: MKOverlay?
    var setMoveMyLocationOnce: Bool = false
    
    // MARK: - Callbacks
    
    var changeRegionCallback: (() -> ())?
    var selectPinCallback: (() -> ())?
    
    // MARK: - Init
    
    public init(mapView: MKMapView) {
        super.init()
        
        mapView.delegate = self
        self.mapView = mapView
        
        loadLocation()
        updateCompass()
    }
    
    // MARK: - Location Manager
    
    func loadLocation() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async {
                    self.locationManager = CLLocationManager()
                    self.locationManager?.delegate = self
                    self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
                    self.locationManager?.requestAlwaysAuthorization()
                    self.locationManager?.startUpdatingLocation()
                }
            }
        }
    }
    
    // MARK: - Map Compass
    
    func updateCompass() {
        
        mapView?.showsCompass = false
        
        compass = MKCompassButton(mapView:mapView)
        compass.x = (ContainerDevice.width - 47)
        compass.compassVisibility = .adaptive
        
        mapView?.addSubview(compass)
    }
    
    public func closeRoute(showSelectPin: Bool) {
        
        if let route = routeOverlay {
            mapView?.removeOverlay(route)
        }
        selectPinAnimation(show: showSelectPin)
    }
    
    public func selectPinAnimation(show: Bool) {
        
        if let selectPin = selectAnnotation {
            if show {
                mapView?.selectAnnotation(selectPin, animated: true)
            } else {
                mapView?.deselectAnnotation(selectPin, animated: true)
            }
        }
    }
    
    public func addMapPinFrom(longPress: UILongPressGestureRecognizer) {
        
        guard let mapView = mapView else { return }
        
        if let anotationMap = selectAnnotation {
            mapView.removeAnnotations([anotationMap]);
        }
        
        let point: CGPoint = longPress.location(in: mapView)
        let coordinate: CLLocationCoordinate2D = mapView.convert(point, toCoordinateFrom: mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        
        selectAnnotation = annotation
        
        mapView.selectAnnotation(annotation, animated: true)
    }
    
    
    // MARK: - Map Show Route
    
    public func showRouteOnMapMyLocation() {
        if let pickupCoord = mapView?.userLocation.location?.coordinate,
            let destinationCoord = selectAnnotation {
            
            showRouteOnMap(pickupCoordinate: pickupCoord, destinationCoordinate: destinationCoord.coordinate)
        }
    }
    
    public func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
     
        closeRoute(showSelectPin: false)
        
        let sourcePlacemark = MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil)
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        
        let directions = MKDirections(request: directionRequest)
     
        directions.calculate { [weak self] (response, error) -> Void in
            guard let _self = self else { return }
         
            guard let response = response else { return }
         
            let route = response.routes[0]
            
            _self.routeOverlay = route.polyline
            
            _self.mapView?.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
         
            let rect: MKMapRect = route.polyline.boundingMapRect
            
            let coordReg: MKCoordinateRegion = MKCoordinateRegion(rect)
            
            let mapButtonWidth: CGFloat = 45
            
            let padding: CGFloat = 35
            let bottom: CGFloat = ContainerDevice.isPortrait ? (261 + padding) : padding
            let left: CGFloat = ContainerDevice.isPortrait ? padding : (261 + padding * 2)
            let right: CGFloat = (mapButtonWidth + 8 + padding)
            
            let insets = UIEdgeInsets(top: padding, left: left, bottom: bottom, right: right)
            
            _self.mapView?.setVisibleRegion(mapRegion: coordReg, edgePadding: insets, animated: true)
            
        }
    }
}

// MARK: - Map-Delegate

extension MapViewManager: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if !animated {
            changeRegionCallback?()
        }
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        if !animated {
            changeRegionCallback?()
        }
    }
    
    // MARK: - Map Select-Pin
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let region = MKCoordinateRegion(center: view.annotation!.coordinate, span: mapView.region.span)
        mapView.setRegion(region, animated: true)
        
        selectPinCallback?()
        
        if let route = routeOverlay {
            mapView.removeOverlay(route)
        }
    }
    
    // MARK: - Map Route-Color
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        let renderer = MKPolylineRenderer(overlay: overlay)
        
        renderer.strokeColor = Colors.rgb(17, 147, 255)
        renderer.lineWidth = 8.0

        return renderer
    }
    
}

// MARK: - Update Location Delegate

extension MapViewManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if setMoveMyLocationOnce { return }
        
        if let location = locations.last {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            
            let radius: CLLocationDistance = 3200
            let region = MKCoordinateRegion(center: center, latitudinalMeters: radius, longitudinalMeters: radius)
            
            mapView?.setRegion(region, animated: false)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude + 0.01, longitude: location.coordinate.longitude + 0.01)
            mapView?.addAnnotation(annotation)
            selectAnnotation = annotation
            
            setMoveMyLocationOnce = true
        }
    }
    
}

// MARK: - Map Extension

extension MKCoordinateRegion {
    var mapRect: MKMapRect {
        get {
            let a = MKMapPoint( CLLocationCoordinate2DMake(
                   self.center.latitude + self.span.latitudeDelta / 2,
                   self.center.longitude - self.span.longitudeDelta / 2))

            let b = MKMapPoint( CLLocationCoordinate2DMake(
                    self.center.latitude - self.span.latitudeDelta / 2,
                    self.center.longitude + self.span.longitudeDelta / 2))

            return MKMapRect(x: min(a.x,b.x), y: min(a.y,b.y), width: abs(a.x-b.x), height: abs(a.y-b.y))
        }
    }
}

extension MKMapView {
    func setVisibleRegion(mapRegion: MKCoordinateRegion, edgePadding insets: UIEdgeInsets, animated animate: Bool) {
        self.setVisibleMapRect(mapRegion.mapRect, edgePadding: insets , animated: animate)
    }
}
