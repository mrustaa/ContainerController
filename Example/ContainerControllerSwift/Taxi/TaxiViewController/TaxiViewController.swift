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

    @IBOutlet weak var mapView: MKMapView!
    var mapManager: MapViewManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        mapManager = MapViewManager(mapView: mapView)
        title = "Taxi"
        
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(35.737988 ), longitude: Double(139.808308)), span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
        DispatchQueue.main.async {
            self.mapView.setRegion(region, animated: true)
        }
        
        self.navBarHide = true
        view.backgroundColor = .white
        let color1 =  #colorLiteral(red: 0.1019607843, green: 0.168627451, blue: 0.4588235294, alpha: 1)
        let imgCar1  =   #imageLiteral(resourceName: "imgTaxiCar1")
        let imgCar2  =   #imageLiteral(resourceName: "imgTaxiCar2")
        
        var items: [TableAdapterItem] = []
        // items.append( PlaylistTitleItem(state: .init() ) )
        tableView.set(items: items, animated: true)
        
        
        
        let mapBtn = TaxiMapButtonView()
        mapBtn.frame = CGRect(x: 12, y: 50, width: 44, height: 44)
        view.addSubview(mapBtn)
        
        let header = TaxiContainerHeaderView()
        header.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 26)
        
        
        let imgA  =   #imageLiteral(resourceName: "iconTaxiPin")
        let imgB  =   #imageLiteral(resourceName: "iconTaxiLocation")
        
        var itemsC: [TableAdapterItem] = []
         itemsC.append( TaxiAddressABItem(state: .init(titleText: "From", subtitleText: "Book Ave, New York", text2: "edit", image3: imgA) ) )
        itemsC.append( TaxiAddressABItem(state: .init(titleText: "To", subtitleText: "Dekawanna Ave, New York", text2: "edit", image3: imgB) ) )
        
        var tagC: [CollectionAdapterItem] = []
        tagC.append( TaxiCarTagItem(state: .init(first: true, titleText: "Standard", subtitleText: "$27.2", text2: "8 min", image3: imgCar1 ) ))
        tagC.append( TaxiCarTagItem(state: .init( titleText: "Comfort", subtitleText: "$32.4", text2: "12 min", image3: imgCar2 ) ))
        tagC.append( TaxiCarTagItem(state: .init( titleText: "Business", subtitleText: "$49.9", text2: "5 min", image3: imgCar1 ) ))
        tagC.append( TaxiCarTagItem(state: .init( titleText: "VIP", subtitleText: "$227.2", text2: "2 min", image3: imgCar2 ) ))
        
        let insets = CollectionAdapterInsets(minSpacing: CollectionAdapterMinSpacing(cell: 0, line: 0), insets: .init(top: 23, left: 8, bottom: 23, right: 8))
        
        itemsC.append( TaxiCollectionCarsItem(state: .init(items: tagC,
                                                           insets: insets) ))
         itemsC.append( TaxiVisaCardItem(state: .init() ) )
         itemsC.append( TaxiButtonBottomItem(state: .init() ) )
        
        containers.append( addContainer(position: .init(top: 266, bottom: 380), radius: 20, items: itemsC, header: header) )
    }
    
}


