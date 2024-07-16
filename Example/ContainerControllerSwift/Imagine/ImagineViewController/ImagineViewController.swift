import UIKit
import ContainerControllerSwift

class ImagineViewController: StoryboardController {
    
    @IBOutlet weak var tableView: TableAdapterView?
    
    
//    func navBar(hide: Bool) {
//        self.navigationController?.setNavigationBarHidden(hide, animated: true)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navBarHide = true
        
        title = "Imagine"
        
        var items: [TableAdapterItem] = []
        items.append( ImagineHeaderSwitchItem(state: .init() ) )
        items.append( ImagineTitleItem(state: .init(titleText: "Imagine", subtitleText: "anything!") ) )
        items.append( ImagineTagItem(state: .init()) )
        items.append( ImagineCollectionItem(state: .init()) )
        items.append( ImagineButtonItem(state: .init(titleText: "Create New Image")) )
        
        tableView?.set(items: items)// (items: items, animated: true)
    }
}
