
import UIKit
import ContainerControllerSwift
import AVFAudio

class PlayMusicViewController: StoryboardController {
    
    @IBOutlet weak var tableView: TableAdapterView!
    var containers: [ContainerController] = []
    
    var musicItems: [ViewCallsPlayerType] = [
        .disclosure_you_me,
        .flume_greatest_view,
            .disclosure_ware_running,
        .camelphat_dropit,
            .the_audio_bar,
            .funky_house_classic,
            .big_miz_aador,
            .claptone_music_got_me,
            .myselor_neurolife,
            .benno_blome_botha,
    ]
    private var timer: Timer?
    private let timerUpdateInterval = 0.25
    
    
    var containerTableView: TableAdapterView?
    var container: ContainerController?
    
    var container2HeaderView: PlayMusicItGribView?
    var container2TableView: TableAdapterView?
    var container2: ContainerController?
    var box: Bool = false
    var count: Int = 0
    
    
    
    var hideFooterView: PlaylistFooterPlayView?
    /// Description
    ///
    ///
    ///
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Remove the subviews ContainerController
       stopTimer()
        ViewCallsPlayer.shared.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navBarHide = true
        
//        let color1 =  #colorLiteral(red: 0.1254901961, green: 0.1294117647, blue: 0.1568627451, alpha: 1)
//        let color2 =  #colorLiteral(red: 0.07450980392, green: 0.08235294118, blue: 0.1137254902, alpha: 1)
        let color3 =  #colorLiteral(red: 0.1176470588, green: 0.1215686275, blue: 0.137254902, alpha: 1)
        
        title = "PlayMusic"
        view.backgroundColor = color3
        
        let img1  =   #imageLiteral(resourceName: "imgPlaylistLandscape")
        
        
        
        let imgg  =   #imageLiteral(resourceName: "iconSportCatalogStars")
        let imgg2  =   #imageLiteral(resourceName: "iconSportCatalog1")
        
        let imgg11  =   #imageLiteral(resourceName: "imgSportCatalogProduct1")
        let imgg12  =   #imageLiteral(resourceName: "imgSportCatalogProduct2")
        let imgg13  =   #imageLiteral(resourceName: "imgSportCatalogProduct3")
        let imgg14  =  #imageLiteral(resourceName: "imgSportCatalogProduct4")
        
        
        
        var itemsFilter: [CollectionAdapterItem] = []
        itemsFilter.append( SportTagFilterItem(state: .init()))
        itemsFilter.append( SportTagSizeColorItem(state: .init(index: 1, selectted: true, icon: imgg ,  handlers: .init(onClickAt: { n in
//            self.updateTagCellIndex(n, section: 2)
        }))))
        itemsFilter.append( SportTagSizeColorItem(state: .init(index: 2, selectted: true, icon: imgg2 ,  handlers: .init(onClickAt: { n in
//            self.updateTagCellIndex(n, section: 2)
        }))))
        itemsFilter.append( SportTagSizeColorItem(state: .init(index: 3, selectted: false, icon: imgg2 ,  handlers: .init(onClickAt: { n in
//            self.updateTagCellIndex(n, section: 2)
        }))))
        itemsFilter.append( SportTagSizeColorItem(state: .init(index: 4, selectted: false, icon: imgg ,  handlers: .init(onClickAt: { n in
//            self.updateTagCellIndex(n, section: 2)
        }))))
        
        
        
        var itemsProducts: [CollectionAdapterItem] = []
        itemsProducts.append( SportCatalogOneItem(state: .init(secondImage: imgg11, text2: "Adidas\nHuman Race", text3: "$280", handlers: .init(onClickAt: { //[weak self] in
           
        }))))
        itemsProducts.append( SportCatalogOneItem(state: .init(secondImage: imgg12, text2: "Nike\nJoyraide", text3: "$320", handlers: .init(onClickAt: { //[weak self] in
            
        }))))
        itemsProducts.append( SportCatalogOneItem(state: .init(secondImage: imgg13, text2: "Nike\nZoom Pegasus", text3: "$250", handlers: .init(onClickAt: { //[weak self] in
           
        }))))
        itemsProducts.append( SportCatalogOneItem(state: .init(fav: true, secondImage: imgg14, text2: "Adidas\nStreet Ball", text3: "$160", handlers: .init(onClickAt: { //[weak self] in
           
        }))))
        itemsProducts.append( SportCatalogOneItem(state: .init(secondImage: imgg11, text2: "Adidas\nHuman Race", text3: "$280", handlers: .init(onClickAt: {// [weak self] in
           
        }))))
        
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
       
        
        
        
        
        var items: [TableAdapterItem] = []
        items.append( PlaylistTitleItem(state: .init(titleText: "New Releases", subtitleText: "More") ) )
        items.append( PlaylistCollectionsItem(state: .init(firstImage: img1, secondImage: img1)))
        
        items.append( PlaylistTitleItem(state: .init(titleText: "Likes Views", subtitleText: "More") ) )
        
//        items.append(MyCardsTitileItem(state: .init()))
        items.append(MyCardsCollectionItem(state: .init(items: tagC, insets: insets)))
        items.append(MyCardsCollAddonsItem(state: .init(items: tagR, insets: insets2)))
        
        items.append( PlaylistTitleItem(state: .init(titleText: "Recommendations", subtitleText: "More") ) )
        
//        items.append( SportCatalogTitileItem(state: .init() ) )
        items.append( SportCatalogFilterItem(state: .init(items: itemsFilter, insets: .init(minSpacing: .init(cell: 16, line: 16), insets: .init(top: 16, left: 32, bottom: 10, right: 32))) ) )
        
        items.append( SportCatalogAllItem(state: .init(items: itemsProducts, insets: .init(minSpacing: .init(cell: 0, line: 16), insets: .init(top: 11, left: 32, bottom: 11, right: 32))) ) )
                      
        
        tableView.set(items: items, animated: true)
        
        main(delay: 0.25) {
            self.music(next: true)
            self.music(play: true, updatePlay: true, next: true)
//            main(delay: 0.25) {
//                self.music(play: true, updatePlay: false)
//            }
//            main(delay: 0.5) {
//                self.music(play: true, updatePlay: true)
//            }
        }
//        main(delay: 2.5) {
//            self.music(play: false, updatePlay: false)
//        }
//        self.music(play: true, next: true)
        //        let titleView = PlaylistTitleCell()
        //        titleView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 148)
        //        view.addSubview(titleView)
        //
        //
        //        let titleView2 = PlaylistCollectionsCell()
        //        titleView2.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 162)
        //        view.addSubview(titleView2)
        
        
        
        
        
        var items2: [TableAdapterItem] = []
        items2.append( PlayMusicItItem(state: .init(handlers: .init(
            onPlayAt: { play in
                self.music(play: play)
            }, onFastForwardAt: { type in
                
                self.music(next: type == .right)
                self.music(play: true, next: true)
                
            }, onMoreAt: {
                self.container?.move(type: .top)
            }, onClickAt: {
                
                self.container2?.move(type: .top)
                
                self.container?.move(type: .hide)
            }, onTimeAt: { time in
//                self.stopTimer()
//                self.music(play: false)
                
//                self.music(play: true, interval: time)
            }))) )
        let header2 = PlayMusicItGribView()
        self.container2HeaderView = header2
        
        
        let gradient = PlayMusicItGradientView()
        
        let ccc2 = addContainer(position: .init(top: 0, bottom: 118), radius: 0, items: items2, delegate: self, addBackShadow: true, header: header2, back: gradient)
        
        self.container2TableView = ccc2.1
//        self.container2TableView?.clipsToBounds = false
//        self.container2?.set(movingEnabled: false)
        self.container2 = ccc2.0
        self.container2?.view.backgroundColor = .clear
        
//        ccc2.0.view.contentView?.insertSubview(ccc2.0.backView, at: 0)
        
        
        self.container2?.move(type: .hide)
        main(delay: 0.15) {
            self.container2?.move(type: .hide )
        }
        self.container2?.move(type: .hide)
        
        main(delay: 0.5) {
            self.container2?.move(type: .bottom )
        }
        
        containers.append(ccc2.0)
        
        
        
        
        addContainerr(position: .init(top: 148, middle: 350/*, bottom: 100*/))
        
        self.container?.move(type: .hide)
        self.container?.move(type: .bottom )
        main(delay: 0.05) {
            self.container?.move(type: .bottom )
        }
        
        
//        let fr2 =  CGRect(x: 0, y: ScreenSize.height - 98, width: ScreenSize.width, height: 98)
//        let footer = PlaylistFooterPlayView()
//        footer.frame = fr2
//        view.addSubview(footer)
//        hideFooterView = footer
//        hideFooterView?.clickCallback = {
//            
//            if (self.containers.count != 0) {
//                
//                self.container2?.move(type: .top)
//                
//            }
//        }
//        self.hideFooterView?.alpha = 0
        
        
        
        
    }
    
    func music(next: Bool) {
        
        if self.count == 0 {
            ViewCallsPlayer.shared.stop()
            ViewCallsPlayer.shared.play(  .none )
            ViewCallsPlayer.shared.pause()
        }
        
        if next {
            self.count = self.count + 1
            if self.count > musicItems.count {
                self.count = 1
            }
        } else if !next {
            self.count = self.count - 1
            if self.count < 1 {
                self.count = musicItems.count
            }
        }
        
        
        ViewCallsPlayer.shared.stop()
//        let typee = ViewCallsPlayerType(rawValue: self.count) ?? .disclosure_you_me
//        if typee == .none {
//            ViewCallsPlayer.shared.stop()
//        } else {
//            ViewCallsPlayer.shared.play(  typee )
//        }
    }
    
    
    func music(play: Bool, updatePlay: Bool? = nil, next: Bool = false, interval: CGFloat? = nil) {
        if play {
            let typee = ViewCallsPlayerType(rawValue: self.count) ?? .none
            
            if next { ViewCallsPlayer.shared.play(  typee ) }
            else if let _ = interval {
//                ViewCallsPlayer.shared.play(interval: interval)
//                ViewCallsPlayer.shared.play()
//                ViewCallsPlayer.shared.avPlayer?.currentTime = interval
            }
            else { ViewCallsPlayer.shared.play() }
            
            
            if let u = updatePlay {
                self.updatePlayerCell(play: u)
            }
            
            self.startTimer()
            
        } else {
            
            if let u = updatePlay {
                self.updatePlayerCell(play: u)
            }
            
            ViewCallsPlayer.shared.pause()
            
            
            self.stopTimer()
        }
    }
    
    private func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: timerUpdateInterval,
                                         repeats: true) { [weak self] _ in
                guard let strongSelf = self else { return }
                main {
                    
                    strongSelf.updatePlayerCell()
                }
            }
        }
    }
    
    private func updatePlayerCell(play: Bool? = nil) {
        let typee = ViewCallsPlayerType(rawValue: self.count) ?? .none
        
        let t1 =  (ViewCallsPlayer.shared.avPlayer?.duration ?? 0)
        let t2 =  (ViewCallsPlayer.shared.avPlayer?.currentTime ?? 0)
        
        //               let v3 =  (ViewCallsPlayer.shared.avPlayer?.volume ?? 0)
        
        if t1 == t2 {
            self.music(next: true)
            self.music(play: true, next: true)
        
            return
        }
        
        let vol = AVAudioSession.sharedInstance().outputVolume
        
        let time =  String(format: "%02d:%02d", ((Int)((t2))) / 60, ((Int)((t2))) % 60 )
        
        //               let remainingTime: CGFloat =   (ViewCallsPlayer.shared.avPlayer?.duration ?? 0) - (ViewCallsPlayer.shared.avPlayer?.currentTime ?? 0)
        
        if let cell = self.container2TableView?.cellForRow(at: .init(row: 0, section: 0)) as? PlayMusicItCell {
            cell.box = self.box
            cell.data?.state.type = typee
            cell.data?.state.duration = t1
            cell.data?.state.currentTime = t2
            cell.data?.state.volume = vol
            cell.data?.state.time = time
            if let play = play {
                cell.data?.state.play = play
            }
            cell.updateImage()
        }
    }
    
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func addContainerr(position: ContainerPosition) {
        
        let layoutC = ContainerLayout()
        layoutC.positions =  position //
        layoutC.insets = .init(right: 0, left: 0)
        let container = ContainerController(addTo: self, layout: layoutC)
        container.view.cornerRadius = 22
        container.view.addShadow()
        container.view.tag = 12
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
        
        
        //        footer.frame = fr2
//        let fr2 =  CGRect(x: 0, y: 0, width: ScreenSize.width, height: 98)
//        let footer = PlaylistFooterPlayView()
//        footer.frame = fr2
//        
//        footer.clickCallback = {
//            
//            if (self.containers.count != 0) {
//                
//                self.container2?.move(type: .top)
//                
//            }
//        }
//        
//        container.add(footerView: footer)
        
        
        
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
        
//        let img1  =   #imageLiteral(resourceName: "imgPlaylistMain")
//        let img2  =   #imageLiteral(resourceName: "imgPlaylistFlume")
        
        
        
        var items: [TableAdapterItem] = []
        
        self.musicItems.forEach { type in
            items.append( PlaylistOneItem(state: .init(type: type, handlers: .init(onClickAt: { selType in
                
                
//                self.music(next: type == .right)
                self.count = selType.rawValue
                ViewCallsPlayer.shared.stop()
                self.music(play: true, next: true)
                
            }))) )
        }
        
        table.set(items: items)
//                    [
//            PlaylistOneItem(state: .init(firstImage:  ViewCallsPlayer.getImage( playerType), subtitleText: "Flume", text2: "What you need", text3: "4:10")),
//            PlaylistOneItem(state: .init(firstImage: img2, subtitleText: "Martin Ikin", text2: "Headnoise", text3: "4:10")),
//            
//            PlaylistOneItem(state: .init(firstImage: img1, subtitleText: "ZHU", text2: "Generationwhy", text3: "59:14")),
//            
//            PlaylistOneItem(state: .init(firstImage: img2, subtitleText: "Flume", text2: "What you need", text3: "4:10")),
//            PlaylistOneItem(state: .init(firstImage: img2, subtitleText: "Martin Ikin", text2: "Headnoise", text3: "4:10")),
//            PlaylistOneItem(state: .init(firstImage: img2, subtitleText: "Flume", text2: "What you need", text3: "4:10")),
//            
//            PlaylistOneItem(state: .init(firstImage: img1, subtitleText: "Flume", text2: "What you need", text3: "4:10")),
//            PlaylistOneItem(state: .init(firstImage: img1, subtitleText: "Martin Ikin", text2: "Headnoise", text3: "4:10")),
//            PlaylistOneItem(state: .init(firstImage: img2, subtitleText: "Flume", text2: "What you need", text3: "4:10"))
//        ] 
        
        
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
                
               
                
                self.headerUpdate(open: type == .bottom, height: 0, grib: type == .top)
                
//                UIView.animate(withDuration: 2) {
               
//                    self.headerUpdate(open: type == .bottom )
                    
                self.box = type == .bottom
                
                    if let cell = self.container2TableView?.cellForRow(at: .init(row: 0, section: 0)) as? PlayMusicItCell {
                        cell.box =  self.box
                        cell.updateImage()
                    }
                
//                self.container2?.set(movingEnabled:  ((type == .top) && self.box))
               
//                }
                main(delay: 0.05) {
                    if type == .bottom {
                        self.container?.move(type: .hide)
                    }
                }
            }
            else if containerController == self.container {
               
                if type == .top || type == .middle {
                    
                    self.headerUpdate(open: type == .top, height: 54.0, grib: self.container2?.moveType == .top)
                    
                    
                    self.box = type == .top
                    
                    //                main(delay: 0.05) {
                    
                    if let cell = self.container2TableView?.cellForRow(at: .init(row: 0, section: 0)) as? PlayMusicItCell {
                        cell.box = self.box
                        cell.updateImage()
                    }
                    
                    
                    self.container2?.set(movingEnabled:  !((type == .top) && self.box))
                    
//                    if type == .middle {
//                        self.container2?.move(type: .bottom)
//                        
//                    }
                    //                }
                } else if type == .bottom  {
                    self.box = (self.container2?.moveType == .bottom) || ((self.container2?.moveType == .top) && (type == .top))
                    
                    if let cell = self.container2TableView?.cellForRow(at: .init(row: 0, section: 0)) as? PlayMusicItCell {
                        cell.box = self.box
                        cell.updateImage()
                    }
                    
                    self.container2?.set(movingEnabled: !self.box)
                }
                
                
//
                
                
                
                
            }
        }
    }
    
    func headerUpdate(open: Bool, height: CGFloat = 54.0, grib: Bool) {
        
//        main {
            
       let heightt = open ? height : PlayMusicItGribView.rrect().height
        if  self.container2HeaderView?.height != heightt {
            self.container2HeaderView?.height = heightt
            self.container2?.headerView?.height = heightt
            UIView.animate(withDuration: 0.15) {
                
                self.container2?.calculationViews()
            }
        }
//        if grib {
            UIView.animate(withDuration: 0.75) {
                self.container2HeaderView?.grib(visible: !open, open: grib)
            }
//        }
           
            
//            if open {
////                self.container2?.headerView?.height = 15
//                
////                if let headerView = self.container2HeaderView, self.container2?.headerView == nil {
////                    headerView.height = 15
////                    self.container2?.add(headerView: headerView)
////                    
////                }
//                
//                self.container2?.removeHeaderView()
//                //                        self.container2?.view.alpha = 0
//                //                        self.container?.move(type: .top)
//            } else {
//                
//                
//                
//                if let headerView = self.container2HeaderView, self.container2?.headerView == nil {
//                    self.container2?.add(headerView: headerView)
//                    
//                }
//                
//                if self.container2?.headerView != nil {
//                    self.container2?.headerView?.height = PlayMusicItGribView.rrect().height
//                }
//                
//                
//                //                        self.container2?.view.alpha = 1
//            }
//        }
    }
    
}
