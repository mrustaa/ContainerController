import UIKit
import ContainerControllerSwift

import MapKit
import CoreLocation

class TaxiViewController: StoryboardController {
    
    
    static public let blackFade = Colors.rgb(19, 19, 19)
    static public let blue = Colors.rgb(39, 110, 255) // 276EFF
    static public let gray = Colors.rgb(243, 244, 245)
    
    
    @IBOutlet weak var tableView: TableAdapterView!
    var containers: [ContainerController] = []
    
    var c1: ContainerController?
    var ct1: TableAdapterView?
    var c2: ContainerController?
    var ct2: TableAdapterView?
    
    @IBOutlet weak var mapView: MKMapView!
    var mapManager: MapViewManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        mapManager = MapViewManager(mapView: mapView)
        title = "Taxi"
        
        mkMapViewUpdate()
        
        self.navBarHide = true
        let color1 =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.backgroundColor = color1
        
//        var items: [TableAdapterItem] = []
//        // items.append( PlaylistTitleItem(state: .init() ) )
//        tableView.set(items: items, animated: true)
        
        
        
        let mapBtn = TaxiMapButtonView()
        mapBtn.onClickAt = {
            self.back()
        }
        mapBtn.frame = CGRect(x: 12, y: 50, width: 44, height: 44)
        view.addSubview(mapBtn)
        
        addOneContainer()
//        addTwoContainer()
        
    }
    
    
    func mkMapViewUpdate(location: (Double, Double) = (35.56255396895196, 139.97254723854845 ) ) {
        
        let t = -0.09463555015 /*-20.069076014*/
        let g = -0.21706715009 /* 102.37854865*/
        
        //        55.712223013994574 37.5456433495479 0.039942404078317395
        
        let l: (Double, Double) = (location.0 - t, location.1 - g)
        
        let s: Double = /*0.039942404078317395*/  0.19149685120904536
        
        self.mapView.delegate = self
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                
                latitude: l.0,
                longitude: l.1
                
            ), span:  MKCoordinateSpan(
                latitudeDelta: s,
                longitudeDelta: s
            )
        )
        
        DispatchQueue.main.async {
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    func mkMapViewAddRouteAB() {
        
        
        let t = -0.09463555015 /*-20.069076014*/
        let g = -0.21706715009 /* 102.37854865*/
        
        //        55.712223013994574 37.5456433495479 0.039942404078317395
        
//        let l: (Double, Double) = (35.56255396895196 - t, 139.97254723854845 - g)
//        let s: Double = /*0.039942404078317395*/  0.19149685120904536
        
//        self.mapView.delegate = self
//        let region = MKCoordinateRegion(
//            center: CLLocationCoordinate2D(
//                
//                latitude: l.0,
//                longitude: l.1
//                
//            ), span:  MKCoordinateSpan(
//                latitudeDelta: s,
//                longitudeDelta: s
//            )
//        )
        
        
        let route = [
            (35.643147, 139.924192),
            (35.643147, 139.924192),
            
            (35.661817, 139.899378),
            (35.662360, 139.898886),
            (35.662758, 139.899228),
            
            (35.689262, 139.931974),
            (35.689471, 139.932457),
            
            
            (35.699498, 139.966796),
            (35.699522, 139.967086),
            (35.699397, 139.967289),
            
            
            (35.693374, 139.979528 ),
            (35.685402, 140.001934 ),
            (35.678163, 139.997431 ),
            
            (35.658805, 140.01562),
            (35.658587, 140.015727),
            (35.658413, 140.015877),
            (35.658657, 140.015910),
            (35.658134, 140.020051)
        ]
        let newRoute = route.map { l1, l2 in
            CLLocation(latitude: l1 - t, longitude: l2 - g)
        }
        
        let runRoute = GradientPolyline(locations: newRoute)
        self.mapView.addOverlay(runRoute)

            self.setPinUsingMKAnnotation(
                location: CLLocationCoordinate2D(latitude: 35.674805  - t, longitude: 140.027623  - g),
                location2: CLLocationCoordinate2D(latitude: 35.643147 - t , longitude:  139.924192  - g))
        
        
    }
    
    func addOneContainer() {
        
        let header = TaxiContainerHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenSize.width, height: 26))
        //        header.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 26)
        
        
        let imgA  =   #imageLiteral(resourceName: "iconTaxiPin")
        let imgB  =   #imageLiteral(resourceName: "iconTaxiLocation")
        
        let imgCar1  =   #imageLiteral(resourceName: "imgTaxiCar1")
        let imgCar2  =   #imageLiteral(resourceName: "imgTaxiCar2")
        
        var itemsC: [TableAdapterItem] = []
        itemsC.append( TaxiAddressABItem(state: .init(titleText: "From", subtitleText: "Book Ave, New York", edit: "edit", image3: imgA) ) )
        itemsC.append( TaxiAddressABItem(state: .init(titleText: "To", subtitleText: "Dekawanna Ave, New York", edit: "edit", image3: imgB) ) )
        
        var tagC: [CollectionAdapterItem] = []
        tagC.append( TaxiCarTagItem(
            state: .init(
                first: true,
                index: 0,
                titleText: "Standard",
                subtitleText: "$27.2",
                text2: "8 min",
                image3: imgCar1 ,
                handlers: .init(onClickAt: { event in
                    self.updateTagCellIndex(0)
        })), clickCallback: {
            
        } ))
        
        tagC.append( TaxiCarTagItem(state: .init( index: 1, titleText: "Comfort", subtitleText: "$32.4", text2: "12 min", image3: imgCar2, handlers: .init(onClickAt: { event in
            self.updateTagCellIndex(1)
        }) ), clickCallback: {
            
        } ))
                    
        tagC.append( TaxiCarTagItem(state: .init( index: 2, titleText: "Business", subtitleText: "$49.9", text2: "5 min", image3: imgCar1, handlers: .init(onClickAt: { event in
            
            self.updateTagCellIndex(2)
        }) ), clickCallback: {
        } ))
                                 
        tagC.append( TaxiCarTagItem(state: .init( index: 3, titleText: "VIP", subtitleText: "$227.2", text2: "2 min", image3: imgCar2, handlers: .init(onClickAt: { event in
            self.updateTagCellIndex(3)
        }) ), clickCallback: {
            
        } ))
        
        let insets = CollectionAdapterInsets(minSpacing: CollectionAdapterMinSpacing(cell: 0, line: 0), insets: .init(top: 23, left: 8, bottom: 23, right: 8))
        
        itemsC.append( TaxiCollectionCarsItem( state: .init( items: tagC,
                                                           insets: insets) ))
        itemsC.append( TaxiVisaCardItem(state: .init() ) )
        itemsC.append( TaxiButtonBottomItem(state:  .init( titleText: "Book Taxi",  addIcon: true, handlers: .init(onClickAt: {
            main {
                if self.containers.count < 2 {
                    self.addTwoContainer()
                }
                self.c2?.move(type: .top)
                self.c1?.move(type: .hide)
                
                self.mkMapViewAddRouteAB()
                
                self.setMoveLocationMap(true)
            }
        })) ) )
        
        let ccc = addContainer(position: .init(top: 266 , bottom: 184 + ScreenSize.isIphoneXBottom), radius: 20, items: itemsC, addBackShadow: true, header: header)
        
        c1 = ccc.0
        ct1 = ccc.1
        
        if let c1 = c1 { containers.append( c1 ) }
        
//        c1?.move(type: .hide, animation: false)
        main(delay: 0.25) {
            self.c1?.move(type: .top)
        }
        c1?.move(type: .top)
        
    }
    
    func updateTagCellIndex(_ index: Int) {
        main {
            if let tablee = self.c1?.scrollView as? TableAdapterView {
                
                // SportSizeItem
                // SportColorItem
                tablee.visibleCells.forEach { visCell in
                    if let collCell = visCell as? TaxiCollectionCarsCell {
                        
                        
                        collCell.collectionView.items.enumerated().forEach { i, tagItm  in
                            
                            if let tagItem = collCell.collectionView.items[i] as? TaxiCarTagItem,
                               let tagCellData = tagItem.cellData as? TaxiCarTagCellData {
                                tagCellData.state.first = i == index ? true : nil
                            }
                            
                        }
                        collCell.collectionView.visibleCells.forEach { visTagCell in
                            
                            
                            if let tagCell = visTagCell as? TaxiCarTagCell {
                                tagCell.updateColor()
                            }
                                
                        }
//                        collCell.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    
    func updateTwoContainer(rate: Bool) -> [TableAdapterItem] {
        
        
        
        var itemsC: [TableAdapterItem] = []
        
        
        if let _  = ct2 {
            
            if rate {
                
                
                let imgA  =   #imageLiteral(resourceName: "iconTaxiPin")
                let imgB  =   #imageLiteral(resourceName: "iconTaxiLocation")
                
                itemsC.append( TaxiRateAvatarItem(state: .init() ) )
                
                itemsC.append( TaxiAddressABItem(state: .init(titleText: "From", subtitleText: "Book Ave, New York", time: "9:42PM", image3: imgA) ) )
                itemsC.append( TaxiAddressABItem(state: .init(titleText: "To", subtitleText: "Dekawanna Ave, New York", time: "10:21PM", image3: imgB) ) )
                
                itemsC.append( TaxiRateTitleItem(state: .init()))
                
                var tagC: [CollectionAdapterItem] = []
                
                tagC.append( TaxiRateEmojiItem(state: .init(blue: true, titleText: "$1", subtitleText: "Good", text2: "👍")))
                
                tagC.append( TaxiRateEmojiItem(state: .init(blue: false, titleText: "$3", subtitleText: "Cool", text2: "🤌")))
                
                tagC.append( TaxiRateEmojiItem(state: .init(blue: false, titleText: "$5", subtitleText: "Wow", text2: "👀")))
                tagC.append( TaxiRateEmojiItem(state: .init(blue: false, titleText: "$11", subtitleText: "AAA", text2: "👄")))
                
                let insets = CollectionAdapterInsets(minSpacing: CollectionAdapterMinSpacing(cell: 11, line: 11), insets: .init(top: 15, left: 16, bottom: 15, right: 16))
                
                itemsC.append( TaxiRateTgItem(state: .init(items: tagC, insets: insets) ) )
                
                itemsC.append( TaxiButtonBottomItem(state: .init(titleText: "Done",  addIcon: false, handlers: .init(onClickAt: {
                    main {
//                        self.c1?.move(type: .top)
//                        self.c2?.move(type: .hide)
                        
                        self.c2?.move(type: .hide)
                        
                        self.ct2?.set(items: self.updateTwoContainer(rate: false))
                        
                        
                        self.c2?.set(top: 429 )
                        
                        main(delay: 0.5) {
                            self.c2?.move(type: .top)
                        }
                    }
                })) ) )
                
            } else {
                 
                itemsC.append( TaxiDetailsItem(state: .init(handlers: .init(onClickAt: { index in
                    
                    if index == 1 {
                        //                    self.c1?.move(type: .top)
                        self.c2?.move(type: .hide)
                        
                        self.ct2?.set(items: self.updateTwoContainer(rate: true))
                        self.c2?.set(top: 166  )
                        
                        
                        main(delay: 0.5) {
                            self.c2?.move(type: .top)
                        }
                    } else {
                        
                        self.c1?.move(type: .top)
                        self.c2?.move(type: .hide)
                    }
                        
                })) ) )
            }
        }
        return itemsC
        
    }
    
    func addTwoContainer() {
        
        let header = TaxiContainerHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenSize.width, height: 23))
//        header.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 23)
        
        let itemsC: [TableAdapterItem] = self.updateTwoContainer(rate: false)
//        itemsC.append( TaxiDetailsItem(state: .init(handlers: .init(onClickAt: {
//            
//            self.c1?.move(type: .top)
//            self.c2?.move(type: .hide)
//        })) ) )
        
        let ccc = addContainer(position: .init(top: 429 , bottom: 20 + ScreenSize.isIphoneXBottom), radius: 20, items: itemsC, addBackShadow: true, header: header) // 380
        
        c2 = ccc.0
        ct2 = ccc.1
        
        ct2?.set(items: self.updateTwoContainer(rate: false))
        
        if let c2 = c2 { containers.append( c2 ) }
        
//        main(delay: 0.05) {
//            self.c2?.move(type: .hide, animation: false)
//        }
//        c2?.move(type: .hide, animation: false)
    }
    
    override func containerControllerMove(_ containerController: ContainerController, position: CGFloat, type: ContainerMoveType, animation: Bool) {
        if  animation,
            containerController == c2,
            type == .bottom {
            
            
            self.c1?.move(type: .top)
            self.c2?.move(type: .hide)
            
        }
    }
}

extension TaxiViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is GradientPolyline {
            let polyLineRender = GradidentPolylineRenderer(overlay: overlay)
            polyLineRender.lineWidth = 7
            return polyLineRender
        }
        return MKOverlayRenderer()
    }
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        let c = mapView.centerCoordinate
        print(" 🙅‍♂️🙅‍♂️\( c.latitude) \( c.longitude) \(mapView.region.span.latitudeDelta)" )
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let Identifier = "Pin"
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Identifier) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: Identifier)
        
        annotationView.canShowCallout = true
        if annotation is MKUserLocation {
            return nil
        } else if let ann = annotation as? MapPin {
            if ann.title == "Here2" {
                annotationView.image =  UIImage(named: "iconTaxiMapCar")
            } else {
                annotationView.image =  UIImage(named: "iconTaxiMapPin")
            }
            
            return annotationView
        } else {
            return nil
        }
    }

    func setPinUsingMKAnnotation( location: CLLocationCoordinate2D, location2: CLLocationCoordinate2D) {
        let pin1 = MapPin(title: "Here", locationName: "Device Location", coordinate: location)
//        let coordinateRegion = MKCoordinateRegion(center: pin1.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        let pin2 = MapPin(title: "Here2", locationName: "Device Location2", coordinate: location2)
//        mapView.setRegion(coordinateRegion, animated: true)
        
        
//        let t = -0.09463555015 - 0.00354623798 /*-20.069076014*/
//        let g = -0.21706715009 /* 102.37854865*/
        
        //        55.712223013994574 37.5456433495479 0.039942404078317395
        
        setMoveLocationMap(false)
        
        mapView.addAnnotations([pin1, pin2])
    }
    
    func setMoveLocationMap(_ addPadding: Bool = false) {
        
        let t = -0.09463555015 /*-20.069076014*/
        let g = -0.21706715009 /* 102.37854865*/
        
        let l: (Double, Double) = (35.56255396895196 - t + (addPadding ? 0.0274214921 : 0.0), 139.97254723854845 - g)
        let s: Double = /*0.039942404078317395*/  0.19149685120904536
        
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                
                latitude: l.0,
                longitude: l.1
                
            ), span:  MKCoordinateSpan(
                latitudeDelta: s,
                longitudeDelta: s
            )
        )
        
        DispatchQueue.main.async {
            self.mapView.setRegion(region, animated: true)
        }
    }
}


class GradientPolyline: MKPolyline {
    var hues: [CGFloat]?
    public func getHue(from index: Int) -> CGColor {
        return UIColor(hue: (hues?[index])!, saturation: 1, brightness: 1, alpha: 1).cgColor
    }
}

extension GradientPolyline {
    convenience init(locations: [CLLocation]) {
        let coordinates = locations.map( { $0.coordinate } )
        self.init(coordinates: coordinates, count: coordinates.count)
        
        let V_MAX: Double = 5.0, V_MIN = 2.0, H_MAX = 0.3, H_MIN = 0.03
        
        hues = locations.map({
            let velocity: Double = $0.speed
            
            if velocity > V_MAX {
                return CGFloat(H_MAX)
            }
            
            if V_MIN <= velocity || velocity <= V_MAX {
                return CGFloat((H_MAX + ((velocity - V_MIN) * (H_MAX - H_MIN)) / (V_MAX - V_MIN)))
            }
            
            if velocity < V_MIN {
                return CGFloat(H_MIN)
            }
            
            return CGFloat(velocity)
        })
    }
}

class GradidentPolylineRenderer: MKPolylineRenderer {
    
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        let boundingBox = self.path.boundingBox
        let mapRectCG = rect(for: mapRect)
        
        if(!mapRectCG.intersects(boundingBox)) { return }
        
        
//        var prevColor: CGColor?
        var currentColor: CGColor?
//         currentColor1: CGColor?
        var currentColor2: CGColor?
        
        guard self.polyline is GradientPolyline else { return }
        
        for index in 0...self.polyline.pointCount - 1{
            let point = self.point(for: self.polyline.points()[index])
            let path = CGMutablePath()
            
            
           
            
            
            currentColor = Colors.hexStr("B46DEE").cgColor // polyLine.getHue(from: index)
//            currentColor1 =  Colors.hexStr("996FFF").cgColor
            currentColor2 = Colors.hexStr("2263FF").cgColor
            
            
            if index == 0 {
                path.move(to: point)
            } else {
                let prevPoint = self.point(for: self.polyline.points()[index - 1])
                path.move(to: prevPoint)
                path.addLine(to: point)
                
                let colors = [currentColor!, currentColor2!] as CFArray
                let baseWidth = self.lineWidth / zoomScale
                
                context.saveGState()
                context.addPath(path)
                
                let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: [0, 1])
                
                context.setLineWidth(baseWidth)
                context.replacePathWithStrokedPath()
                context.clip()
                context.drawLinearGradient(gradient!, start: prevPoint, end: point, options: [])
                context.restoreGState()
            }
            currentColor = currentColor2
        }
    }
}

class MapPin: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
    }
}
