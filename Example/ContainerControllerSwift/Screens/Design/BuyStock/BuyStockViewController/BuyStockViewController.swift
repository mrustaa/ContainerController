import UIKit
import ContainerControllerSwift

class BuyStockViewController: StoryboardController {
    
    @IBOutlet weak var tableView: TableAdapterView!
    var containers: [ContainerController] = []

//    @IBOutlet var visualEffectView: UIVisualEffectView!
    @IBOutlet var bbackView: UIView!
    
    var visualEffectView: UIVisualEffectView?
    
    var containerTableView: TableAdapterView?
    var container: ContainerController?
    
    var tableAnimated: Bool = true
    var dark: Bool = true
    var firstInsets: Bool = true
    
    var headerV: BuyStockHeaderView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        self.visualEffectView.blur.radius = 10
        self.navBarHide = true
        view.backgroundColor = .white

        
                    if visualEffectView == nil {
                        let
                        bl = UIVisualEffectView(effect: nil)
                        bl.frame = self.view.bounds
                        bl.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                        bl.layer.cornerRadius = 0
                        bl.clipsToBounds = true
//                        bl.blur.radius = 7.0
//                        bl.blur.tintColor = .clear
//                        bl.blur.tintColor = .white.withAlphaComponent(0.25)
                        visualEffectView = bl
                        self.bbackView?.addSubview(bl)
                    }
//        self.visualEffectView?.alpha = 1
        
        
        let fr =  CGRect(x: 0, y: 0, width: ScreenSize.width, height: 70)
        let header = BuyStockHeaderView()
        header.titleLabel?.text = "19 September"
        header.frame = fr
        headerV = header
      
        let itemsC = self.updateContainerTable(dark: false)
        
        let ccc =   addContainer(position: .init(top: 150, bottom: 233), radius: 20, items: itemsC, addBackShadow: false, header: header)
        
        container = ccc.0
        containerTableView = ccc.1
        
        self.containerTableView?.selectIndexCallback  = { index in
            
            if index == 2, self.dark {
                self.dark = false  // false
                
                
            } else if !self.dark {
                self.dark = true
            }
            
            
            let block: (() -> Void) = {
                
        }
                
                if index == 0, !self.firstInsets {
                    self.firstInsets = true
                    
                    self.container?.set(left: 16)
                    self.container?.set(right: 16)
                } else if self.firstInsets {
                    self.firstInsets = false
                    
                    self.container?.set(left: 0)
                    self.container?.set(right: 0)
                }
                
            
            switch index {
            case 1, 3, 4: self.updateTableIndex(first: 0, complection: block)
            case 2: self.updateTableIndex(first: 2, complection: block)
            default: self.updateTableIndex(first: 1, complection: block)
            }
        }
        
        self.container?.set(left: 16)
        self.container?.set(right: 16)
        self.container?.view.cornerRadius = 35
        self.container?.view.backgroundColor = Colors.hexStr("242A3E").withAlphaComponent(0.95)
        self.view.backgroundColor = Colors.hexStr("0C1229")
        
        
        containers.append(  ccc.0  )
        
         
        main(delay: 0.5) {
            self.container?.move(type: .bottom)
        }
    }
    
    func updateContainerTable(dark: Bool) -> [TableAdapterItem] {
        //        let color1 =  #colorLiteral(red: 0.1019607843, green: 0.168627451, blue: 0.4588235294, alpha: 1)
        let imgGraph  =  #imageLiteral(resourceName: "imgBuyStockGraph")
        //        let imgGraphGreen  = #imageLiteral(resourceName: "imgBuyStockGraphGreen")
        let imgGraphLine  = #imageLiteral(resourceName: "imgBuyStockGraphLine")
        let imgNikeStore  =  #imageLiteral(resourceName: "imgBuyStockNikeStore")
        let imgNikeItem1  =  #imageLiteral(resourceName: "imgBuyStockNike1")
        let imgNikeItem2  =  #imageLiteral(resourceName: "imgBuyStockNike2")
        let imgNikeItem3  = #imageLiteral(resourceName: "imgBuyStockNike3")
        
        let imgNikeItem5  = #imageLiteral(resourceName: "imgBuyStockNike5")
        
        
        var items: [TableAdapterItem] = []
        items.append( BuyStockTitleItem(state: .init(image2: imgNikeStore, handlers: .init(onClickAt: {
            self.back()
        }))))
        items.append( BuyStockGraphItem(state: .init(image9: imgGraphLine, image10: imgGraph) ) )
        tableView.set(items: items, animated: true)
        
        
        var itemsC: [TableAdapterItem] = []
        itemsC.append( BuyStockOneItem(state: .init(dark: dark, firstImage: imgNikeItem1, handlers: .init(onClickAt: {  
            self.updateTableIndex(first: 1)
        })) ) )
        itemsC.append( BuyStockOneItem(state: .init(dark: dark, firstImage: imgNikeItem3, subtitleText: "Apple", handlers: .init(onClickAt: {
            self.updateTableIndex(first: 0)
        })) ) )
        itemsC.append( BuyStockOneItem(state: .init(dark: dark, firstImage: imgNikeItem5, subtitleText: "Lyft", handlers: .init(onClickAt: {
            self.updateTableIndex(first: 2)
        })) ) )
        itemsC.append( BuyStockOneItem(state: .init(dark: dark,  firstImage: imgNikeItem3, subtitleText: "Apple", handlers: .init(onClickAt: {
            self.updateTableIndex(first: 0)
        })) ) )
        
        itemsC.append( BuyStockOneItem(state: .init( dark: dark, firstImage: imgNikeItem3, subtitleText: "Apple", handlers: .init(onClickAt: {
            self.updateTableIndex(first: 0)
        })) ) )
        itemsC.append( BuyStockOneItem(state: .init(dark: dark, firstImage: imgNikeItem1, handlers: .init(onClickAt: {
            self.updateTableIndex(first: 1)
        })) ) )
        itemsC.append( BuyStockOneItem(state: .init(dark: dark, firstImage: imgNikeItem2, handlers: .init(onClickAt: {
            self.updateTableIndex(first: 1)
        })) ) )
        itemsC.append( BuyStockOneItem(state: .init(dark: dark, firstImage: imgNikeItem1) ) )
        itemsC.append( BuyStockOneItem(state: .init(dark: dark, firstImage: imgNikeItem2) ) )
        itemsC.append( BuyStockOneItem(state: .init(dark: dark, firstImage: imgNikeItem2) ) )
        // itemsC.append( TaxiAddressABItem(state: .init() ) )
        // itemsC.append( TaxiCollectionCarsItem(state: .init() ) )
        // itemsC.append( TaxiVisaCardItem(state: .init() ) )
        // itemsC.append( TaxiButtonBottomItem(state: .init() ) )
        return itemsC
    }
    
    func updateTableIndex(first: Int, complection: (() -> Void)? = nil) {
        
        let imgGraph  =  #imageLiteral(resourceName: "imgBuyStockGraph")
        let imgGraphGreen  = #imageLiteral(resourceName: "imgBuyStockGraphGreen")
        let imgNikeStore  =  #imageLiteral(resourceName: "imgBuyStockNikeStore")
        let imgGraphLine  = #imageLiteral(resourceName: "imgBuyStockGraphLine")
        
//        let imgNikeItem3  = #imageLiteral(resourceName: "imgBuyStockNike3")
        
        
        var items: [TableAdapterItem] = []
        
        if first == 1 {
            
            let itemsC = self.updateContainerTable(dark: false)
            self.containerTableView?.set(items: itemsC)
            self.headerV?.titleLabel?.textColor = .white
            self.container?.set(bottom: 233)
            
//            self.container?.set(left: 16)
//            self.container?.set(right: 16)
            
            
            
            items.append( BuyStockTitleItem(state: .init(
                subtitleText:   "- $10.99"   ,
                image2:  imgNikeStore  ,
                
                text3:   "Nike Store", handlers: .init(onClickAt: {
                    self.back()
                })
            ) ) )
            
            
            items.append( BuyStockGraphItem(state: .init(image9: imgGraphLine,  image10:   imgGraph ) ) )
            
        }  else if first == 2 {
            
            let itemsC = self.updateContainerTable(dark: true)
            self.containerTableView?.set(items: itemsC)
            self.container?.set(bottom: 323)
            self.headerV?.titleLabel?.textColor = .black
            
            
//            self.container?.set(left: 0)
//            self.container?.set(right: 0)
            
            
            var tagC: [CollectionAdapterItem] = []
            tagC.append(MyCardsAddCardItem(state: .init()))
            tagC.append(MyCardsOneCardItem(state: .init(visa: false)))
            tagC.append(MyCardsOneCardItem(state: .init(visa: true)))
            
            var tagR: [CollectionAdapterItem] = []
            tagR.append(MyCardsAddonsItem(state: .init()))
            tagR.append(MyCardsAddonsItem(state: .init()))
            tagR.append(MyCardsAddonsItem(state: .init()))
            tagR.append(MyCardsAddonsItem(state: .init()))
            
            let insets = CollectionAdapterInsets(minSpacing: CollectionAdapterMinSpacing(cell: 16, line: 16), insets: .init(top: 16, left: 21, bottom: 16, right: 21))
            
            let insets2 = CollectionAdapterInsets(minSpacing: CollectionAdapterMinSpacing(cell: 16, line: 16), insets: .init(top: 16, left: 28, bottom: 16, right: 28))
            items.append(MyCardsTitileItem(state: .init()))
            items.append(MyCardsCollectionItem(state: .init(items: tagC, insets: insets)))
            items.append(MyCardsCollAddonsItem(state: .init(items: tagR, insets: insets2)))
            
            
        } else {
            
//            self.container?.set(left: 0)
//            self.container?.set(right: 0)
            
            let itemsC = self.updateContainerTable(dark: false)
            self.containerTableView?.set(items: itemsC)
            
            self.headerV?.titleLabel?.textColor = .white
            self.container?.set(bottom: 233)
            items.append( BuyStockTitleGreenItem(state: .init(
            ) ) )
            
            items.append( BuyStockGraphItem(state: .init(image9: imgGraphLine,  image10:    imgGraphGreen) ) )
        }
        
        
        self.container?.view.backgroundColor = Colors.hexStr("242A3E").withAlphaComponent(0.95)
        self.view.backgroundColor = Colors.hexStr("0C1229")
        if first == 2 {
            self.container?.view.backgroundColor = .white
            self.view.backgroundColor = Colors.hexStr("F8F8FA")
        }
        
        
        container?.move(type: .bottom)
        
        guard self.tableAnimated else { return }
        self.tableAnimated = false
        
        self.tableView?.layer.removeAllAnimations()
        self.view.layer.removeAllAnimations()
        
        UIView.animate(withDuration: 0.35) {
            self.tableView?.alpha = 0
            
        } completion: { fin in
//            main(delay: 0.55) {
                self.tableView?.set(
                    items: items,
                    animated: false
                )
//            }
            
             
//            main(delay: 0.15) {
                UIView.animate(withDuration: 0.35) {
                    self.tableView?.alpha = 1
                } completion: { fin in
                    self.tableAnimated = true
                    
                    complection?()
                }
//            }
           
        }
        
    }
    
    
    override func containerControllerMove(_ containerController: ContainerController, position: CGFloat, type: ContainerMoveType, animation: Bool) {
        if  animation {
            
            
//            self.visualEffectView?.blur.radius = 5
            
            UIView.animate(withDuration: 0.55) {
                
//                self.container?.view.backgroundColor = type == .top ? Colors.hexStr("242A3E") : Colors.hexStr("242A3E").withAlphaComponent(0.95)
                
                
//                self.container?.view.backgroundColor = type == .top ? Colors.hexStr("0C1229").withAlphaComponent(0.7) : Colors.hexStr("242A3E").withAlphaComponent(0.9)
                
//                self.visualEffectView?.alpha =  type == .top ? 0.8 : 0.0
//                self.visualEffectView
                self.bbackView?.alpha =  type == .top ? 1.0 : 0.0
            }
            //            self.c1?.move(type: .top)
            //            self.c2?.move(type: .hide)
            
        }
    }
    
    
    

}
