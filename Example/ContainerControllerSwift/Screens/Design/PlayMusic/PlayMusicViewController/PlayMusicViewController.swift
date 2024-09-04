
import UIKit
import ContainerControllerSwift
import AVFAudio


class PlayMusic {
     
    
    enum PositionType {
        case top
        case bottom
    }
    
    enum PositionAnimationType {
        case start
        case procces
        case ended
    }
    
    enum TableItemsType {
        case playlist
        case playlistRetro
        case playlistBoris
        case playlistDisclosure
        
        case playlistMix
        case playpanel
        case buyStock
        case buyStockMix
        case cards
        case backgroundTop
        case backgroundBottom
        case pickerAll
        case popular
    }
    
    enum CollectionItemsType {
        case playMusicTag
        case playMusicPopular
        case cardsOne
        case cardsAddons
        case filter
        case sport
        case picker
    }
}


class PlayMusicViewController: StoryboardController {
    
    
    @IBOutlet weak var tableView: TableAdapterView!
    var containers: [ContainerController] = []
    
    var musicItems: [ViewCallsPlayerType] = ViewCallsPlayerType.statusList
    var retroItems: [ViewCallsPlayerType] = ViewCallsPlayerType.retroList
    var mixItems: [ViewCallsPlayerType] = ViewCallsPlayerType.mixList
    var borisItems: [ViewCallsPlayerType] = ViewCallsPlayerType.borisList
    var disclosureItems: [ViewCallsPlayerType] = ViewCallsPlayerType.disclosureList
    
    var currentMusicSelect: PlayMusic.TableItemsType = .playlist
    var currentMusicItems: [ViewCallsPlayerType] {
        if currentMusicSelect == .playlist {
            return musicItems
        } else if currentMusicSelect == .playlistRetro {
            return retroItems
        } else if currentMusicSelect == .playlistMix {
            return mixItems
        } else if currentMusicSelect == .playlistBoris {
            return borisItems
        } else if currentMusicSelect == .playlistDisclosure {
            return disclosureItems
        }
        
        return musicItems
    }
    
    var timer: Timer?
    let timerUpdateInterval = 0.5
    
    
    var containerTableView: TableAdapterView?
    var container: ContainerController?
    
    var container2HeaderView: PlayMusicItGribView?
    var container2TableView: TableAdapterView?
    var container2: ContainerController?
    var container2MovingDelegateInViewTop: Bool = false
    var container2MovingDelegateAnim: PlayMusic.PositionAnimationType = .ended

    var container2MovingDelegate: Bool = false
    var container2MovingDelegateOff: Bool = false
    var container2MovingDelegateOn: Bool = false
    var box: Bool = false
    
    
    var container2Moving: Bool = false
    
    static var redStColorValue: UIColor {
        redStColor ? .playMusicColor :
            .playlistColor
    }
    static var redStColor: Bool = false
    var redColor: Bool {
        get {
            Self.redStColor
        }
        set {
            Self.redStColor = newValue
        }
    }
    var count: Int = 0
    var hideFooterView: PlaylistFooterPlayView?
    
    
    //MARK: - viewDidDisappear
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        
       stopTimer()
        musicStop()
        
        
        
//        ViewCallsPlayer.getMp3Files()
    }
    
    //MARK: - viewDidLoad
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.navBarHide = true
        
        
        title = "PlayMusic"
        
        
        self.redColor = !ViewCallsPlayer.shared.colorAnimaton
        view.backgroundColor = ViewCallsPlayer.shared.colorsTest ? .playFullBackgroundOld : .playFullBackground
        
        
        self.tableView.contentInset = .init(top: 0, left: 0, bottom: 150, right: 0)
        
        
        
        let header2 = PlayMusicItGribView()
        self.container2HeaderView = header2
        let gradient2 = PlayMusicItGradientView()
        gradient2.height = ScreenSize.height 
        let items2 = createTableItems(.playpanel)
        let color2 =  #colorLiteral(red: 0.1607843137, green: 0.1333333333, blue: 0.1960784314, alpha: 1)
        createPlayPanelContainer(
            position: .init(top: 0, bottom: 118),
            radius: 0,
            items: items2,
            containerColor: color2,// .clear,
            addBackShadow: true,
            scrollInsets: .init(top: 0, left: 0, bottom: -50, right: 0),
            header: header2,
            back: gradient2
        )
        
        
    
        let header3 = PlaylistHeaderView()
        let items3 = createTableItems(.playlist)
        let color3 =  #colorLiteral(red: 0.07450980392, green: 0.08235294118, blue: 0.1137254902, alpha: 1)
        createPlaylistContainer(
            position: .init(top: 148, middle: 350/*, bottom: 100*/),
            radius: 22,
            items: items3,
            containerColor: color3,
            addShadow: true,
            header: header3
        )
        
        
        
        updateShowAll()
    }
    
    //MARK: - updateShowAll
    
    func updateShowAll() {
        
        self.startMovePlayPanelContainer(.bottom)
        
        self.startMovePlaylistContainer(.hide)
        
        let items =
        createTableItems(.backgroundTop) +
        createTableItems(.buyStockMix) +
        createTableItems(.popular) +
//        createBackBottomItems(other: true) +
        createTableItems(.backgroundBottom) +
        createTableItems(.playlist) +
        
        createTableItems(.pickerAll)
        
        if !ViewCallsPlayer.shared.colorAnimaton {
            self.step1()
        }
            
        main(delay: 0.25) {
            self.tableView.set(items: items, animated: false)
            self.updateCellsBackgroundStartShowAnimation()
        }
        
        main(delay: 0.5) {
            self.container2?.move(type: .bottom )
        }
        
        main(delay: 2.5) {
            self.music(next: true)
            self.music(play: true, updatePlay: true, next: true)
        }
    }
    
}
