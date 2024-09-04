import UIKit
import ContainerControllerSwift

class CryptoViewController: StoryboardController {
    
    @IBOutlet weak var tableView: TableAdapterView!
    
    var c1: ContainerController?
    var ct1: TableAdapterView?
    var containers: [ContainerController] = []
    
    
    var bottomPos = false
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
        
        
        addContainerr(position: .init(top: 100, bottom: 456))
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
        
        
        container.view.backgroundColor = .white
        
        
        let table = TableAdapterView(frame: CGRect(x: 0, y: 0, width: ContainerDevice.width, height: 0), style: .plain)
        table.indicatorStyle =  .default
        self.ct1 = table
        self.c1 = container
        
        table.set(items:  getItems(top: false))
        
        container.add(scrollView: table)
//        container.move(type: .bottom)
        
        main(delay: 1.05) {
            container.move(type: .middle
            )
        }
        
        containers.append(container)
    }
    
    
    func getItems(top: Bool) -> [TableAdapterItem] {
        if top {
            
            let img1  =   #imageLiteral(resourceName: "imgCryptoBitcoin")
            let color1 = UIColor.sportColor
            
            let img2  =  #imageLiteral(resourceName: "imgCryptoEuro")
            let color2 =  #colorLiteral(red: 0.1019607843, green: 0.168627451, blue: 0.4588235294, alpha: 1)
            
            return [
                CryptoAmountItem(state: .init(titleText:  "BTC v", subtitleText: "Crypto Collateral", text2:  "0.0856345" , text3: "All 1.56371 BTC", color: color1, img: img1)),
                CryptoAmountItem(state: .init(titleText:  "USDC v" , subtitleText: "Loan Amount", text2: "5232.05", text3: "", color: color2, img: img2)),
                CryptoDetailsItem(state: .init()),
            ]
        } else {
            
            let img1  =   #imageLiteral(resourceName: "imgCryptoBitcoin")
            let img2  =   #imageLiteral(resourceName: "imgCryptoEuro")
            let img3  =   #imageLiteral(resourceName: "imgCryptoPound")
            
            return [
                CryptoOneItem(state: .init(firstImage: img1, color: Colors.hexStr("F7931A"))),
                CryptoOneItem(state: .init(firstImage: img2, color: Colors.hexStr("3A5FD9"))),
                CryptoOneItem(state: .init(firstImage: img3, color: .black)),
                CryptoOneItem(state: .init(firstImage: img1, color: Colors.hexStr("F7931A"))),
                CryptoOneItem(state: .init(firstImage: img2, color: Colors.hexStr("3A5FD9"))),
                CryptoOneItem(state: .init(firstImage: img3, color: .black)),
                CryptoOneItem(state: .init(firstImage: img1, color: Colors.hexStr("F7931A"))),
                CryptoOneItem(state: .init(firstImage: img2, color: Colors.hexStr("3A5FD9"))),
                CryptoOneItem(state: .init(firstImage: img3, color: .black)),
            ]
        }
    }
    
    override func containerControllerMove(_ containerController: ContainerController, position: CGFloat, type: ContainerMoveType, animation: Bool) {
        if  animation {
            if (type == .top) && bottomPos {
                bottomPos = !bottomPos
                let fr =  CGRect(x: 0, y: -12, width: ScreenSize.width, height: 25)
                let headerr = MapParkingHeaderView()
                headerr.frame = fr
                self.c1?.add(headerView: headerr)
                
                self.ct1?.set(items: getItems(top: true))
            } else if !bottomPos  {
                
                bottomPos = !bottomPos
                let fr =  CGRect(x: 0, y: 0, width: ScreenSize.width, height: 173)
                let header = CryptoHeaderView()
                header.frame = fr
                self.c1?.add(headerView: header)
                self.ct1?.set(items: getItems(top: false))
            }
        }
        
    }
}
