import UIKit
import ContainerControllerSwift

class WalletsViewController: StoryboardController {
    
    @IBOutlet var footerImg: UIImageView!
    @IBOutlet weak var tableView: TableAdapterView!
    var containers: [ContainerController] = []
    
    var open1: Bool = true
    var open2: Bool = true
    var open3: Bool = true
    var open4: Bool = true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navBarHide = true
        
        let color1 =  #colorLiteral(red: 1, green: 0.5607843137, blue: 0.2901960784, alpha: 1)
        let color2 =  #colorLiteral(red: 0.2862745098, green: 0.3450980392, blue: 0.7921568627, alpha: 1)
        let color3 =  #colorLiteral(red: 0.8156862745, green: 0.8117647059, blue: 0.9647058824, alpha: 1)
        let color4 =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        let padding: CGFloat = 26 + 24
        
        
        let img1  =  #imageLiteral(resourceName: "imgWalletsBitcoin")
        let img2  = #imageLiteral(resourceName: "imgWalletsEthereum")
        let img3  = #imageLiteral(resourceName: "imgWalletsDigiByte")
        let img4  = #imageLiteral(resourceName: "imgWalletsLitecoin")
        //
        //        container.move(type: container.moveType)
        
        
        addContainer(position: getPosition(index: 0), title: "Bitcoin", sum: "$14.20", color: color1,  img: img1 , dark: true)
        
        main(delay: 0.05) {
            self.addContainer(position: self.getPosition(index: 1), title: "Ethereum", sum: "$9.49",color: color2,  img: img2)
        }
        main(delay: 0.15) {
            self.addContainer(position: self.getPosition(index: 2), title: "DigiByte", sum: "$23.65",  color: color3,  img:img3 , dark: true)
        }
        main(delay: 0.20) {
            self.addContainer(position: self.getPosition(index: 3), title: "Litecoin", sum: "$43.20",color: color4,  img: img4)
        }
        
        
        
        
        title = "Wallets"
        
        let imgImagine  =  #imageLiteral(resourceName: "iconWalletsMore")
        var items: [TableAdapterItem] = []
        items.append( WalletsTitleItem(state: .init(firstImage: imgImagine, subtitleText: "My Wallets" , text2: "$55,849.20", text3: "Total balance", handlers: .init(backAt: {
            self.back()
        })) ) )
        tableView.set(items: items, animated: true)
    }
    
    override func containerControllerMove(_ containerController: ContainerController, position: CGFloat, type: ContainerMoveType, animation: Bool) {
        
        
        print(" containerControllerMove \(containerController.view.tag) \(type == .top ? "TOP" : "BOTTOM") \(animation)  \(open1) \(open2) \(open3) \(open4) ")
       
        
        
        if animation && self.containers.count == 4 {
            
            
            switch containerController.view.tag {
            case 0:
                
                if open1 {
                    
                    if self.open2 {
                        self.containers[1].move(type: .bottom)
                    }
                    if self.open3 {
                        self.containers[2].move(type: .bottom)
                    }
                    if self.open4 {
                        self.containers[3].move(type: .bottom)
                    }
                } else {
                    if !self.open2 {
                        self.containers[1].move(type: .top)
                    }
                    if !self.open3 {
                        self.containers[2].move(type: .top)
                    }
                    if !self.open4 {
                        self.containers[3].move(type: .top)
                    }
                }
                
            case 1:
                if open2 {
                    
                    if self.open3 {
                        self.containers[2].move(type: .bottom)
                    }
                    if self.open4 {
                        self.containers[3].move(type: .bottom)
                    }
                } else {
                    if !self.open3 {
                        self.containers[2].move(type: .top)
                    }
                    if !self.open4 {
                        self.containers[3].move(type: .top)
                    }
                }
            case 2:
                if open3 {
                    
                    if self.open4 {
                        self.containers[3].move(type: .bottom)
                    }
                } else {
                    if !self.open4 {
                        self.containers[3].move(type: .top)
                    }
                }
            case 3: break
            default:
                break
            }
            
        }
        
        switch containerController.view.tag {
        case 0: open1 = (type == .top)
        case 1: open2 = (type == .top)
        case 2: open3 = (type == .top)
        case 3: open4 = (type == .top)
        default:
            break
        }
            
            
            
//            return
//            
//            var i = 0
//            for containr in containers {
//                
//                
//                let layoutC = ContainerLayout()
//                layoutC.positions =  getPosition(index: i) //
//                layoutC.insets = .init(right: 23, left: 23)
////                containr.middleEnable
//                
//                containers[i].set(layout: layoutC)
//                containr.set(layout: layoutC)
//                
//                i = i + 1
//            }
//            
//        }
    }
    
    func getPosition(index: Int) -> ContainerPosition {
        let pa: CGFloat = 36
    
        
        
//        switch index {
//        case 0:  return ContainerPosition(top: 268 , middle: 268 - (open2 ? 0 : pa) - (open3 ? 0 : pa) - (open4 ? 0 : pa) , bottom: 170   )
//        case 1: return  ContainerPosition(top: 368 , middle: 368 - (open3 ? 0 : pa) - (open4 ? 0 : pa), bottom: 140 )
//        case 2:  return ContainerPosition(top: 468 , middle: 468 - (open4 ? 0 : pa), bottom: 110  )
//        case 3:   return ContainerPosition(top: 568 , bottom: 80  )
//        default:
//            return ContainerPosition(top: 500, bottom: 80)
//        }
        
        switch index {
        case 0:  return ContainerPosition(top: 268 , bottom: 170 + pa   )
        case 1: return  ContainerPosition(top: 368 , bottom: 140 + pa  )
        case 2:  return ContainerPosition(top: 468 , bottom: 110 + pa   )
        case 3:   return ContainerPosition(top: 568 , bottom: 80 + pa )
        default:
            return ContainerPosition(top: 500, bottom: 80)
        }
        
        
        
        
    }
    
    func addContainer(position: ContainerPosition, title: String, sum: String, color: UIColor, img: UIImage, dark: Bool = false) {
        
        let layoutC = ContainerLayout()
        layoutC.positions =  position //
        layoutC.insets = .init(right: 23, left: 23)
        let container = ContainerController(addTo: self, layout: layoutC)
        container.view.cornerRadius = 22
        container.view.addShadow()
        container.view.tag = containers.count
        container.delegate = self
//        let shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        
        container.view.layer.shadowOpacity = Float(0.20)
        container.view.layer.shadowOffset = .init(width: 0, height: 13)
        container.view.layer.shadowRadius = 30.0
        container.view.layer.shadowColor = UIColor.black.cgColor

        
        
        
        let imgHeader = UIImage(named: "imgWalletsHeader2")?.withTintColor(color, renderingMode: .alwaysTemplate)
        
        
        let header = UIImageView(frame: CGRect(x: 0, y: 0, width: ScreenSize.width  - 23 - 23 , height: 680)) //
        header.image = imgHeader
        header.tintColor = color
        
//        container.view.addSubview(header) //
        container.view.insertSubview(header, at: 0)
        container.view.backgroundColor = .clear
//        container.view.mask = header
        
//        container.add(headerView: header)
//        container.view.backgroundColor = color
        
        let table = TableAdapterView(frame: CGRect(x: 0, y: 0, width: ContainerDevice.width, height: 0), style: .plain)
        table.indicatorStyle =  .default
        //        container.add(scrollView: addCollectionView())
        table.set(items: [
            WalletsContainerItemItem(state: .init(
                
                img: img,
                titleText: title,
                subtitleText: "2.73 LTC",
                text2: sum,
                text3: "+1.45 (345)",
                text4: "1LTC = $2983.40",
                text5: "~ 2.70%",
                text6: "Buy",
                dark: dark
            ))
        ] )
        
        container.add(scrollView: table)
        container.move(type: .top)
        
        containers.append(container)
        
        self.view.addSubview(self.footerImg)
    }
}
