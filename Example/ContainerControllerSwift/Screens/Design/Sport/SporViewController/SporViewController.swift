import UIKit
import ContainerControllerSwift

class SporViewController: StoryboardController {
    
    @IBOutlet weak var tableView: TableAdapterView!
    var containerTableView: TableAdapterView?
    var container: ContainerController?
    var containers: [ContainerController] = []
    var bbackView: SportSelectProductView!
    var openProduct: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.navBarHide = true
        view.backgroundColor = .white
//        let color1 =  #colorLiteral(red: 0.1019607843, green: 0.168627451, blue: 0.4588235294, alpha: 1)
//        let img1  =   #imageLiteral(resourceName: "imgPlaylistMain")
        
        let items: [TableAdapterItem] = []
        // items.append( PlaylistTitleItem(state: .init() ) )
        tableView.set(items: items, animated: true)
        
        let fr =  CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
        let header = SportSelectProductView()
        header.onClickAt = {
            self.back()
        }
        bbackView = header
        header.frame = fr
        
        view.addSubview(header)
        
        
        // itemsC.append( TaxiVisaCardItem(state: .init() ) )
        // itemsC.append( TaxiButtonBottomItem(state: .init() ) )
            
        let cc = addContainer(position: .init(top: 1/*361*/, middle: 450,   bottom: 86), radius: 52, items: getItems(products: false))
        
        
        
        let frr =  CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height - 5)
        let backgroundView = SportGradientBackgroundView()
//        cc.0.backView?.backgroundColor = .red
        backgroundView.frame = frr
        
        cc.0.backView?.addSubview( backgroundView)
        
        
        self.containerTableView = cc.1
        self.container = cc.0
//        self.containerTableView?.contentOffset = .init(x: 0, y: 0)
        containers.append( cc.0 )
        
        
        main(delay: 0.5) {
            self.container?.move(type: .middle)
        }
        
//        if let sr = cc.0.scrollView {
//            cc.0.view.insertSubview(backgroundView, belowSubview: sr)
//        }
    }
    
    func getItems(products: Bool) ->  [TableAdapterItem] {
        
        
        
        var itemsC: [TableAdapterItem] = []
        
        if products {
            
            let imgg  =   #imageLiteral(resourceName: "iconSportCatalogStars")
            let imgg2  =   #imageLiteral(resourceName: "iconSportCatalog1")
            
            let imgg11  =   #imageLiteral(resourceName: "imgSportCatalogProduct1")
            let imgg12  =   #imageLiteral(resourceName: "imgSportCatalogProduct2")
            let imgg13  =   #imageLiteral(resourceName: "imgSportCatalogProduct3")
            let imgg14  =  #imageLiteral(resourceName: "imgSportCatalogProduct4")
            
//            let imgg111  =   #imageLiteral(resourceName: "imgSportSelectProduct1")
//            let imgg122  =   #imageLiteral(resourceName: "imgSportSelectProduct2")
//            let imgg133  =   #imageLiteral(resourceName: "imgSportSelectProduct3")
//            let imgg144  =  #imageLiteral(resourceName: "imgSportSelectProduct4")
            
            
            var itemsFilter: [CollectionAdapterItem] = []
            itemsFilter.append( SportTagFilterItem(state: .init(titleText: "Filter", sport: true)))
            itemsFilter.append( SportTagSizeColorItem(state: .init(index: 1, selectted: true, icon: imgg , sport: true,  handlers: .init(onClickAt: { n in
                self.updateTagCellIndex(n, section: 2)
            }))))
            itemsFilter.append( SportTagSizeColorItem(state: .init(index: 2, selectted: true, icon: imgg2 ,  sport: true,   handlers: .init(onClickAt: { n in
                self.updateTagCellIndex(n, section: 2)
            }))))
            itemsFilter.append( SportTagSizeColorItem(state: .init(index: 3, selectted: false, icon: imgg2 ,  sport: true,  handlers: .init(onClickAt: { n in
                self.updateTagCellIndex(n, section: 2)
            }))))
            itemsFilter.append( SportTagSizeColorItem(state: .init(index: 4, selectted: false, icon: imgg ,  sport: true,  handlers: .init(onClickAt: { n in
                self.updateTagCellIndex(n, section: 2)
            }))))
            
          
            
            var itemsProducts: [CollectionAdapterItem] = []
            itemsProducts.append( SportCatalogOneItem(state: .init(secondImage: imgg11, text2: "Adidas\nHuman Race", text3: "$280", handlers: .init(onClickAt: { [weak self] in
                self?.bbackViewUpdate(0)
            }))))
            itemsProducts.append( SportCatalogOneItem(state: .init(secondImage: imgg12, text2: "Nike\nJoyraide", text3: "$320", handlers: .init(onClickAt: { [weak self] in
                self?.bbackViewUpdate(3)
            }))))
            itemsProducts.append( SportCatalogOneItem(state: .init(secondImage: imgg13, text2: "Nike\nZoom Pegasus", text3: "$250", handlers: .init(onClickAt: { [weak self] in
                self?.bbackViewUpdate(2)
            }))))
            itemsProducts.append( SportCatalogOneItem(state: .init(fav: true, secondImage: imgg14, text2: "Adidas\nStreet Ball", text3: "$160", handlers: .init(onClickAt: { [weak self] in
                self?.bbackViewUpdate(1)
            }))))
            itemsProducts.append( SportCatalogOneItem(state: .init(secondImage: imgg11, text2: "Adidas\nHuman Race", text3: "$280", handlers: .init(onClickAt: { [weak self] in
                self?.bbackViewUpdate(0)
            }))))
            
            
//            var itemsC: [TableAdapterItem] = []
            itemsC.append( SportCatalogTitileItem(state: .init() ) )
            itemsC.append( SportCatalogFilterItem(state: .init(items: itemsFilter, insets: .init(minSpacing: .init(cell: 16, line: 16), insets: .init(top: 16, left: 32, bottom: 10, right: 32))) ) )
            itemsC.append( SportCatalogAllItem(state: .init(items: itemsProducts, insets: .init(minSpacing: .init(cell: 0, line: 16), insets: .init(top: 11, left: 32, bottom: 11, right: 32))) ) )
            
            self.containerTableView?.set(items: itemsC)
        }    else {
            
           
//            let orange = Colors.hexStr("F38A0E")
            
            
            var itemsCC: [CollectionAdapterItem] = []
            itemsCC.append( SportTagSizeColorItem(state: .init(index: 0, selectted: true,  text: "US 6", sport: true, handlers: .init(onClickAt: { i in
                self.updateTagCellIndex(i, section: 0)
            }))))
            itemsCC.append( SportTagSizeColorItem(state: .init(index: 1, selectted: false, text: "US 7", sport: true,  handlers: .init(onClickAt: { i in
                self.updateTagCellIndex(i, section: 0)
            }))))
            itemsCC.append( SportTagSizeColorItem(state: .init(index: 2, selectted: false, text: "US 7", sport: true,  handlers: .init(onClickAt: { i in
                self.updateTagCellIndex(i, section: 0)
            }))))
            itemsCC.append( SportTagSizeColorItem(state: .init(index: 3, selectted: false, text: "US 8", sport: true,  handlers: .init(onClickAt: { i in
                self.updateTagCellIndex(i, section: 0)
            }))))
            itemsCC.append( SportTagSizeColorItem(state: .init(index: 4, selectted: false, text: "US 9", sport: true,  handlers: .init(onClickAt: { i in
                self.updateTagCellIndex(i, section: 0)
            }))))
            itemsCC.append( SportTagSizeColorItem(state: .init(index: 5, selectted: false, text: "US 10", sport: true,  handlers: .init(onClickAt: { i in
                self.updateTagCellIndex(i, section: 0)
            }))))
            itemsCC.append( SportTagSizeColorItem(state: .init(index: 6, selectted: false, text: "US 11", sport: true,  handlers: .init(onClickAt: { i in
                self.updateTagCellIndex(i, section: 0)
            }))))
            
            
            let colorREd = Colors.hexStr("B02C34")
            let colorYe = Colors.hexStr("FFC700")
            let colorGreen = Colors.hexStr("2CB099")
            let colorGray = Colors.hexStr("2D2C2F")
            
            var itemsTT: [CollectionAdapterItem] = []
            itemsTT.append( SportTagSizeColorItem(state: .init(index: 0, borderColor: .orange, backColor: .white, centerColor: colorREd,  sport: true,  handlers: .init(onClickAt: { i in
//                self.updateTagCellIndex(i, section: 1)
            }))))
            itemsTT.append( SportTagSizeColorItem(state: .init(index: 1, borderColor: .clear,  backColor: .white, centerColor: colorGreen,  sport: true,   handlers: .init(onClickAt: { i in
//                self.updateTagCellIndex(i, section: 1)
            }))))
            itemsTT.append( SportTagSizeColorItem(state: .init(index: 2, borderColor: .clear,  backColor: colorYe, centerColor: colorGray,  sport: true,   handlers: .init(onClickAt: { i in
//                self.updateTagCellIndex(i, section: 1)
            }))))
            
            
            
            itemsC.append( SportTitleItem(state: .init() ) )
            itemsC.append( SportSizeItem(state: .init(items: itemsCC, insets: .init(minSpacing: .init(cell: 16, line: 16), insets: .init(top: 0, left: 32, bottom: 0, right: 32))) ) )
            itemsC.append( SportColorItem(state: .init(items: itemsTT, insets: .init(minSpacing: .init(cell: 16, line: 16), insets: .init(top: 0, left: 32, bottom: 0, right: 32))) ) )
            itemsC.append( SportBottomButtonItem(state: .init() ) )
            
            
        }
        return itemsC
    }
    func bbackViewUpdate(_  number: Int)  {
        
        self.bbackView.buttonClickNumber(number)
        
        main(delay: 0.05) {
            self.container?.move(type: .middle)
        }
        
    }
    
    func updateTagCellIndex(_ index: Int,  section: Int) {
//        main {
            if let tablee = self.containerTableView    {
                
                
                // SportSizeItem
//                 SportColorItem
                tablee.visibleCells.forEach { visCell in
                    
                    var collectionView: CollectionAdapterView?
                    if let collCell = visCell as? SportSizeCell, section == 0 {
                        collectionView = collCell.collectionView
                    } else if let collCell = visCell as? SportColorCell, section == 1 {
                        collectionView = collCell.collectionView
                    } else if let collCell = visCell as? SportCatalogFilterCell, section == 2 {
                        collectionView = collCell.collectionView
                    }
                    
                    
                    if let collectionView = collectionView {
                    
//                    if let collCell = visCell as? TagUpdateCollectionCellDelegate {
                        
//                        let collectionView = collCell.getCollectionView()
                        
                        collectionView.items.enumerated().forEach { i, tagItm  in
                            
                            
                            
                            if let tagItem = collectionView.items[i] as? SportTagSizeColorItem,
                               let tagCellData = tagItem.cellData as? SportTagSizeColorCellData {
//                                tagCellData.state.first = i == index ? true : nil
                                if section == 0 {
                                    
                                    tagCellData.state.selectted  = i == index ? true : false
                                } else if section == 2 {
                                    if i == index {
                                        tagCellData.state.selectted  = !tagCellData.state.selectted
                                        
                                    }
                                }
                            }
                            
                        }
                        collectionView.visibleCells.forEach { visTagCell in
                            
                            
                            if let tagCell = visTagCell as? TagUpdateCellDelegate {
                                tagCell.updateColor()
                            }
                            
                        }
                        //                        collCell.collectionView.reloadData()
                    }
                }
            }
//        }
    }
    
   override func containerControllerMove(_ containerController: ContainerController, position: CGFloat, type: ContainerMoveType, animation: Bool) {
        if  animation {
            if type ==  .top {
                
//                self.bbackView.imagesAlpha(0.0)
                
                self.bbackView.paddingTopImg.constant = -50
                UIView.animate(withDuration: 0.5) {
                    
                    self.bbackView.imagesAlpha(0.0)
                    self.view.layoutIfNeeded()
                }
                
                if !openProduct {
                    self.openProduct = true
                     
//                    main(delay: 0.05, work: {
//                        self.containerTableView?.set(items: self.getItems(products: true))
//                    })
                    self.containerTableView?.set(
                        items: self.getItems(products: true),
                        animated: false
                    )
                    
//                    self.containerTableView?.contentOffset = .init(x: 0, y: 0)
                }
            } else {
                
                
                
                if type ==  .middle {
                    
                    
                    bbackView.paddingTopImg.constant = 0
                    UIView.animate(withDuration: 0.5) {
                        
                        self.bbackView.imagesAlpha(1.0)
                        self.view.layoutIfNeeded()
                    }
                } else {
                    
                    bbackView.paddingTopImg.constant = 150
                    UIView.animate(withDuration: 0.5) {
                        
                        self.bbackView.imagesAlpha(1.0)
                        self.view.layoutIfNeeded()
                    }
                }
                
                if self.openProduct {
                    self.openProduct = false
                    
//                    main(delay: 0.05, work: {
                        self.containerTableView?.set(
                            items: self.getItems(products: false),
                            animated: false
                        )
//                    })
                    
                   
                    
//                    self.containerTableView?.contentOffset = .init(x: 0, y: 0)
                }
            }
        }
    }
}
