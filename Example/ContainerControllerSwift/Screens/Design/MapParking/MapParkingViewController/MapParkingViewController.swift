import UIKit
import ContainerControllerSwift

import MapKit
import CoreLocation

class MapParkingViewController: StoryboardController {
    
    @IBOutlet weak var tableView: TableAdapterView!
    var containers: [ContainerController] = []

    var containerTableView: TableAdapterView?
    var container: ContainerController?
    var header: MapParkingHeaderView?
    var top: Bool = false
    @IBOutlet weak var mapView: MKMapView!
    var mapManager: MapViewManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        self.navBarHide = true
        view.backgroundColor = .white
        
        
        let mapBtn = TaxiMapButtonView()
        mapBtn.onClickAt = {
            self.back()
        }
        mapBtn.frame = CGRect(x: 12, y: 50, width: 44, height: 44)
        view.addSubview(mapBtn)
        
        
//        let color1 =  #colorLiteral(red: 0.1019607843, green: 0.168627451, blue: 0.4588235294, alpha: 1)
//        let img1  =   #imageLiteral(resourceName: "imgPlaylistMain")
        
        let items: [TableAdapterItem] = []
        // items.append( PlaylistTitleItem(state: .init() ) )
        tableView.set(items: items, animated: true)
        tableView.isHidden  = true
        
        let fr =  CGRect(x: 0, y: -12, width: ScreenSize.width, height: 12)
        let headerr = MapParkingHeaderView()
        headerr.frame = fr
        header = headerr
        
        let ccc = addContainer(position: .init(top: 110, /*middle: 458, */bottom: 258), radius: 52, items:  self.getItems(mini: true), addBackShadow: true)
        
        container = ccc.0
        
        self.container?.set(left: 28)
        self.container?.set(right: 28)
        self.container?.view.cornerRadius = 33
        self.container?.view.backgroundColor = .clear
        
        ccc.0.view.clipsToBounds = false
        ccc.0.scrollView?.clipsToBounds = false
        ccc.0.backView?.clipsToBounds = false
        headerr.clipsToBounds = false
//        ccc.0.backView?.addSubview( header)
        containerTableView = ccc.1
        
        
        
        containers.append(  ccc.0  )
        
        setMoveLocationMap()
        
        
        main(delay: 0.5) {
            self.container?.move(type: .top)
        }
    }
    
    
    func setMoveLocationMap() {
         
        
        let l: (Double, Double) = (-37.92104865902625 ,144.99516418028998 )
        let s: Double = 0.08
        
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
    
    override func containerControllerMove(_ containerController: ContainerController, position: CGFloat, type: ContainerMoveType, animation: Bool) {
        if  animation {
            if type ==  .top, !top {
                top = !top
                self.container?.set(left: 0)
                self.container?.set(right: 0)
                self.container?.view.cornerRadius = 52
                
                if let h = header, self.container?.headerView == nil  { self.container?.add(headerView: h) }
                
                self.containerTableView?.set(
                    items: self.getItems(mini: false),
                    animated: false
                )
                
            } else if top  {
                top = !top
                
                self.container?.set(left: 28)
                self.container?.set(right: 28)
                
                self.container?.view.cornerRadius = 33
                
                self.container?.removeHeaderView()
                
                
                self.containerTableView?.set(
                    items: self.getItems(mini: true),
                    animated: false
                )
            }
        }
    }
    
    
    
    
    func getItems(mini: Bool) ->  [TableAdapterItem] {
        
        let imgg10  =  #imageLiteral(resourceName: "imgMapParkingPic0")
        let imgg11  =  #imageLiteral(resourceName: "imgMapParkingPic1")
        let imgg12  =  #imageLiteral(resourceName: "imgMapParkingPic2")
        let imgg13  =  #imageLiteral(resourceName: "imgMapParkingPic3")
        
        var itemsC: [TableAdapterItem] = []
//        if mini { itemsC.append( MapParkingMiniItem(state: .init() ) ) }
        
        if mini {
            
            var itemsTT: [CollectionAdapterItem] = []
            itemsTT.append( MapParkingTgItem(state: .init(firstImage: imgg10)))
            itemsTT.append( MapParkingTgItem(state: .init(firstImage: imgg11)))
            itemsTT.append( MapParkingTgItem(state: .init(firstImage: imgg12)))
            itemsTT.append( MapParkingTgItem(state: .init(firstImage: imgg13)))
            
            itemsC.append( MapParkingMiniItem(state: .init(items: itemsTT, insets: .init(minSpacing: .init(cell: 12, line: 12), insets: .init(top: 0, left: 20, bottom: 0, right: 20))) ) )
            
        }
        
        if !mini {   itemsC.append( MapParkingDetailsItem(state: .init() ) ) }
         return itemsC
        
    }
    
}

extension MapParkingViewController: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        let c = mapView.centerCoordinate
        print(" 🙅‍♂️🙅‍♂️\( c.latitude) \( c.longitude) \(mapView.region.span.latitudeDelta)" )
    }
}
