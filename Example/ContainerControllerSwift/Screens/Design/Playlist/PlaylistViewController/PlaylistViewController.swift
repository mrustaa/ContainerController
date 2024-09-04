import UIKit
import ContainerControllerSwift

class PlaylistViewController: StoryboardController {
    @IBOutlet var imgView: UIImageView!
    
    @IBOutlet var imgViewH: NSLayoutConstraint!
    @IBOutlet var imgViewW: NSLayoutConstraint!
    @IBOutlet var imgViewY: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: TableAdapterView!
    var containers: [ContainerController] = []
    
    
    var containerTableView: TableAdapterView?
    var container: ContainerController?
    
    var container2TableView: TableAdapterView?
    var container2: ContainerController?
    
    var hideFooterView: PlaylistFooterPlayView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navBarHide = true
        
        let color1 =  #colorLiteral(red: 0.1254901961, green: 0.1294117647, blue: 0.1568627451, alpha: 1)
        
        title = "Playlist"
        view.backgroundColor = color1
        
        let img1  =   #imageLiteral(resourceName: "imgPlaylistLandscape")
        
        imgView.alpha = 1
        
        self.imgView.layer.cornerRadius = 9
        
        var items: [TableAdapterItem] = []
        items.append( PlaylistTitleItem(state: .init(titleText: "New Releases", subtitleText: "More") ) )
        items.append( PlaylistCollectionsItem(state: .init(firstImage: img1, secondImage: img1)
                                             ) )
        tableView.set(items: items, animated: true)
        
//        let titleView = PlaylistTitleCell()
//        titleView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 148)
//        view.addSubview(titleView)
//        
//        
//        let titleView2 = PlaylistCollectionsCell()
//        titleView2.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 162)
//        view.addSubview(titleView2)
        
        
        addContainerr(position: .init(top: 50, middle: 310, bottom: 100))
        
        self.container?.move(type: .middle)
        
        main(delay: 0.5) {
            self.container?.move(type: .middle )
        }
        
        
        
//        var items2: [TableAdapterItem] = []
//        items2.append( PlayMusicItItem(state: .init(handlers: .init(
//            onPlayAt: { play in
//            
//        }, onFastForwardAt: { type in
//            
//        }, onMoreAt: {
//            
//        }, onBottomAllAt: {
//            
//        }))) )
//        let header2 = PlayMusicItGribView()
//                       
//        let ccc2 = addContainer(position: .init(top: 0, bottom: 98), radius: 0, items: items2, delegate: self, addBackShadow: true, header: header2)
//        
//        self.container2TableView = ccc2.1
//        self.container2 = ccc2.0
//        
//        
//        self.container2?.move(type: .hide)
//        
//        main(delay: 0.5) {
//            self.container2?.move(type: .top )
//        }
//        
//        containers.append(ccc2.0)
//        
        
        
        let fr2 =  CGRect(x: 0, y: ScreenSize.height - 98, width: ScreenSize.width, height: 98)
        let footer = PlaylistFooterPlayView()
        footer.frame = fr2
        view.addSubview(footer)
        hideFooterView = footer
        hideFooterView?.clickCallback = {
            
            if (self.containers.count != 0) {
                
                self.container2?.move(type: .top)
                
            }
        }
        self.hideFooterView?.alpha = 0
        
        
        
        
    }
    
    func addContainerr(position: ContainerPosition) {
        
        let layoutC = ContainerLayout()
        layoutC.positions =  position //
        layoutC.insets = .init(right: 0, left: 0)
        let container = ContainerController(addTo: self, layout: layoutC)
        container.view.cornerRadius = 22
        container.view.addShadow()
        container.view.tag = 15
        container.delegate = self
//        let shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        
        container.view.layer.shadowOpacity = Float(0.20)
        container.view.layer.shadowOffset = .init(width: 0, height: 13)
        container.view.layer.shadowRadius = 30.0
        container.view.layer.shadowColor = UIColor.black.cgColor
        
        let fr =  CGRect(x: 0, y: 0, width: ScreenSize.width, height: 77)
        let header = PlaylistHeaderView()
        header.frame = fr
        container.add(headerView: header)
        
        
        let fr2 =  CGRect(x: 0, y: 0, width: ScreenSize.width, height: 98)
        let footer = PlaylistFooterPlayView()
        footer.frame = fr2
        
        footer.clickCallback = {
            
            if (self.containers.count != 0) {
                
                self.container2?.move(type: .top)
                
            }
        }
        
        container.add(footerView: footer)
        
        
        
//        var imgHeader = UIImage(named: "imgWalletsHeader2")?.withTintColor(color, renderingMode: .alwaysTemplate)
        
        let color1 =  #colorLiteral(red: 0.07450980392, green: 0.08235294118, blue: 0.1137254902, alpha: 1)
        
//        var header = UIImageView(frame: CGRect(x: 0, y: 0, width: ScreenSize.width  - 23 - 23 , height: 680)) //
//        header.image = imgHeader
//        header.tintColor = color
//        
//        //        container.view.addSubview(header) //
//        container.view.insertSubview(header, at: 0)
        container.view.backgroundColor = color1
        //        container.view.mask = header
        
        //        container.add(headerView: header)
        //        container.view.backgroundColor = color
        
        let table = TableAdapterView(frame: CGRect(x: 0, y: 0, width: ContainerDevice.width, height: 0), style: .plain)
        table.indicatorStyle =  .default
        //        container.add(scrollView: addCollectionView())
        
        self.containerTableView = table
        self.container = container
        
        let img1  =   #imageLiteral(resourceName: "imgPlaylistMain")
        let img2  =   #imageLiteral(resourceName: "imgPlaylistFlume")
        
        
        table.set(items: [
            PlaylistOneItem(state: .init(firstImage: img2, subtitleText: "Flume", text2: "What you need", text3: "4:10")),
            PlaylistOneItem(state: .init(firstImage: img2, subtitleText: "Martin Ikin", text2: "Headnoise", text3: "4:10")),
            
            PlaylistOneItem(state: .init(firstImage: img1, subtitleText: "ZHU", text2: "Generationwhy", text3: "59:14")),
            
            PlaylistOneItem(state: .init(firstImage: img2, subtitleText: "Flume", text2: "What you need", text3: "4:10")),
            PlaylistOneItem(state: .init(firstImage: img2, subtitleText: "Martin Ikin", text2: "Headnoise", text3: "4:10")),
            PlaylistOneItem(state: .init(firstImage: img2, subtitleText: "Flume", text2: "What you need", text3: "4:10")),
            
            PlaylistOneItem(state: .init(firstImage: img1, subtitleText: "Flume", text2: "What you need", text3: "4:10")),
            PlaylistOneItem(state: .init(firstImage: img1, subtitleText: "Martin Ikin", text2: "Headnoise", text3: "4:10")),
            PlaylistOneItem(state: .init(firstImage: img2, subtitleText: "Flume", text2: "What you need", text3: "4:10"))
        ] )
        
        container.add(scrollView: table)
//        container.move(type: .bottom)
        
        
//        main(delay: 1.05) {
//            container.move(type: .middle
//            )
//        }
        
        containers.append(container)
        
//        self.view.addSubview(self.footerImg)
    }
    
    
    override func containerControllerMove(_ containerController: ContainerController, position: CGFloat, type: ContainerMoveType, animation: Bool) {
        if  animation {
            
            if containerController == self.container2 {
                UIView.animate(withDuration: 2) {
                    if type == .bottom {
                        self.container2?.view.alpha = 0
                        self.container?.move(type: .top)
                    } else {
                        
                        self.container2?.view.alpha = 1
                    }
                }
            }
            else if containerController == self.container {
                
                if (containers.count != 0) {
                    if type == .bottom {
                        
                        containers[0].footerView?.alpha = 0
                        
                        
                        containers[0].view.alpha = 0
                    } else   {
                        containers[0].footerView?.alpha = 1
                        containers[0].view.alpha = 1
                    }
                }
                UIView.animate(withDuration: 0.35) {
                    if type == .bottom { self.hideFooterView?.alpha = 1 }
                    else  { self.hideFooterView?.alpha = 0 }
                    
                }
                
                //            main {
                
                if type == .bottom {
                    
                    self.imgView.alpha = 1
                    
                    self.imgViewH.constant = ScreenSize.height
                    self.imgViewW.constant = ScreenSize.width
                    self.imgViewY.constant = 0
                    
                } else if type == .middle {
                    
                    self.imgView.alpha = 0
                    self.imgViewW.constant = 313
                    self.imgViewH.constant = 162
                    self.imgViewY.constant = 197
                    
                    
                } else {
                    self.imgView.alpha = 0
                    self.imgViewW.constant = 313
                    self.imgViewH.constant = 162
                    self.imgViewY.constant = 197
                    
                }
                
                self.view.setNeedsUpdateConstraints()
                
                
                UIView.animate(withDuration: 2.5) {
                    
                    self.view.layoutIfNeeded()
                    
                    if type == .bottom {
                        //                        self.imgView.alpha = 1
                        
                        self.tableView.alpha  = 1
                        //                        self.imgViewH.constant = ScreenSize.height
                        //                        self.imgViewW.constant = ScreenSize.width
                        //                        self.imgViewY.constant = 0
                        //                        self.imgView.layer.cornerRadius = 0
                        
                    } else if type == .middle {
                        self.tableView.alpha  = 1
                        
                        //                        self.imgViewW.constant = 313
                        //                        self.imgViewH.constant = 162
                        //                        self.imgViewY.constant = 196
                        
                        //                        self.imgView.alpha = 1
                        //                        self.imgView.layer.cornerRadius = 9
                        
                    } else {
                        
                        //                        self.imgViewW.constant = 313
                        //                        self.imgViewH.constant = 162
                        //                        self.imgViewY.constant = 196
                        
                        self.tableView.alpha  = 0
                        //                        self.imgView.layer.cornerRadius = 9
                    }
                }
                
                //            } //
                
            }
            
        }
    }
}
