import UIKit
import ContainerControllerSwift

class CryptoViewController: StoryboardController {
    
    @IBOutlet weak var tableView: TableAdapterView!
    
    var containers: [ContainerController] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navBarHide = true
        
        title = "Crypto"
        let color1 =  #colorLiteral(red: 0.1019607843, green: 0.168627451, blue: 0.4588235294, alpha: 1)
         
        view.backgroundColor = color1
        
        
        var items: [TableAdapterItem] = []
        items.append( CryptoTitleItem(state: .init(handlers: .init(onClickAt: {
            self.back()
        })) ) )
        tableView.set(items: items, animated: true)
        
        
        addContainerr(position: .init(top: 50, middle: 456, bottom: 100))
    }
    
    func addContainerr(position: ContainerPosition) {
        
        let layoutC = ContainerLayout()
        layoutC.positions =  position //
        layoutC.insets = .init(right: 0, left: 0)
        let container = ContainerController(addTo: self, layout: layoutC)
        container.view.cornerRadius = 36
        container.view.addShadow()
        container.view.tag = 16
        container.delegate = self
//        let shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        
        container.view.layer.shadowOpacity = Float(0.20)
        container.view.layer.shadowOffset = .init(width: 0, height: 13)
        container.view.layer.shadowRadius = 30.0
        container.view.layer.shadowColor = UIColor.black.cgColor
        
        let fr =  CGRect(x: 0, y: 0, width: ScreenSize.width, height: 173)
        let header = CryptoHeaderView()
        header.frame = fr
        container.add(headerView: header)
        
        
//        let fr2 =  CGRect(x: 0, y: 0, width: ScreenSize.width, height: 98)
//        let footer = PlaylistFooterPlayView()
//        footer.frame = fr2
//        container.add(footerView: footer)
        
        //        var imgHeader = UIImage(named: "imgWalletsHeader2")?.withTintColor(color, renderingMode: .alwaysTemplate)
        
//        let color1 =  #colorLiteral(red: 0.1019607843, green: 0.168627451, blue: 0.4588235294, alpha: 1)
        
        //        var header = UIImageView(frame: CGRect(x: 0, y: 0, width: ScreenSize.width  - 23 - 23 , height: 680)) //
        //        header.image = imgHeader
        //        header.tintColor = color
        //
        //        //        container.view.addSubview(header) //
        //        container.view.insertSubview(header, at: 0)
        container.view.backgroundColor = .white
        //        container.view.mask = header
        
        //        container.add(headerView: header)
        //        container.view.backgroundColor = color
        
        let table = TableAdapterView(frame: CGRect(x: 0, y: 0, width: ContainerDevice.width, height: 0), style: .plain)
        table.indicatorStyle =  .default
        //        container.add(scrollView: addCollectionView())
        
        
        
        let img1  =   #imageLiteral(resourceName: "imgCryptoBitcoin")
        let img2  =   #imageLiteral(resourceName: "imgCryptoEuro")
        let img3  =   #imageLiteral(resourceName: "imgCryptoPound")
        
        
        table.set(items: [
            CryptoOneItem(state: .init(firstImage: img1, color: Colors.hexStr("F7931A"))),
            CryptoOneItem(state: .init(firstImage: img2, color: Colors.hexStr("3A5FD9"))),
            CryptoOneItem(state: .init(firstImage: img3, color: .black)),
            CryptoOneItem(state: .init(firstImage: img1, color: Colors.hexStr("F7931A"))),
            CryptoOneItem(state: .init(firstImage: img2, color: Colors.hexStr("3A5FD9"))),
            CryptoOneItem(state: .init(firstImage: img3, color: .black)),
            CryptoOneItem(state: .init(firstImage: img1, color: Colors.hexStr("F7931A"))),
            CryptoOneItem(state: .init(firstImage: img2, color: Colors.hexStr("3A5FD9"))),
            CryptoOneItem(state: .init(firstImage: img3, color: .black)),
        ] )
        
        container.add(scrollView: table)
        container.move(type: .bottom)
        
        main(delay: 1.05) {
            container.move(type: .middle
            )
        }
        
        containers.append(container)
        
        //        self.view.addSubview(self.footerImg)
    }
    
    override func containerControllerMove(_ containerController: ContainerController, position: CGFloat, type: ContainerMoveType, animation: Bool) {
        if  animation {
        }
        
    }
}
