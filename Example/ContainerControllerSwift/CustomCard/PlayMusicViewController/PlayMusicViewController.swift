import UIKit
import ContainerControllerSwift

class PlayMusicViewController: StoryboardController {
    
    @IBOutlet weak var tableView: TableAdapterView!
    var containers: [ContainerController] = []

    var containerTableView: TableAdapterView?
    var container: ContainerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.navBarHide = true
        view.backgroundColor = .white
        let color1 =  #colorLiteral(red: 0.1019607843, green: 0.168627451, blue: 0.4588235294, alpha: 1)
        let img1  =   #imageLiteral(resourceName: "imgPlaylistMain")
        
        var items: [TableAdapterItem] = []
        // items.append( PlaylistTitleItem(state: .init() ) )
        tableView.set(items: items, animated: true)
        
        let fr =  CGRect(x: 0, y: 0, width: ScreenSize.width, height: 26)
        let header = TaxiContainerHeaderView(frame: fr)
        
        var itemsC: [TableAdapterItem] = []
        // itemsC.append( TaxiAddressABItem(state: .init() ) )
        // itemsC.append( TaxiAddressABItem(state: .init() ) )
        // itemsC.append( TaxiCollectionCarsItem(state: .init() ) )
        // itemsC.append( TaxiVisaCardItem(state: .init() ) )
        // itemsC.append( TaxiButtonBottomItem(state: .init() ) )
        
        let ccc = addContainer(position: .init(top: 266, bottom: 380), radius: 20, items: itemsC, header: header)
        container = ccc.0
        containerTableView = ccc.1
        
        containers.append( ccc.0 )
    }

}
