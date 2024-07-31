import UIKit
import AVFAudio
import ContainerControllerSwift

// MARK: - State

extension PlayMusicItItem {
    enum FastForwardType {
        case right
        case left
    }
    
  struct State {
      var type: ViewCallsPlayerType = .none
      
      var duration: CGFloat = 0
      var currentTimeChange: Bool = false
      var currentTime: CGFloat = 0
      var volume: Float = 0
      var time: String = ""
      var play: Bool?
      
    var firstImage: UIImage?
      var title: String?
    var subtitle: String?
    var image3: UIImage?
    var image4: UIImage?
    var image5: UIImage?
    var image6: UIImage?
    var image7: UIImage?
    var image8: UIImage?
    var image9: UIImage?
    var image10: UIImage?
    var image11: UIImage?
    var image12: UIImage?
    var handlers: Handlers = .init()
  }
  struct Handlers {
      var onPlayAt: ((_ play: Bool)->(Void))?
      var onFastForwardAt: ((_ type: FastForwardType)->(Void))?
      var onMoreAt: (()->(Void))?
      var onClickAt: (()->(Void))?
      
      
      var onTimeAt: ((_ time: CGFloat)->(Void))?
//      var onBottomAllAt: (()->(Void))?
  }
}

// MARK: - Item

class PlayMusicItItem: TableAdapterItem {
  init(state: PlayMusicItItem.State) {
    let cellData =  PlayMusicItCellData(state: state)
    super.init(cellClass: PlayMusicItCell.self, cellData: cellData)
  }
}

// MARK: - Data

class PlayMusicItCellData: TableAdapterCellData {

  var state: PlayMusicItItem.State

  init(state: PlayMusicItItem.State) {
    self.state = state
    super.init()
    // self.cellClickCallback = state.handlers.onClickAt
  }
  
  override public func cellHeight() -> CGFloat {
    // let calcHeight = calculateLabel(
    //   text: state.titleText,
    //   padding: 16,
    //   titleFont: SFProText.regular.size(.headline)
    // )
    return Self.cHeight()
  }
  
  public static func cHeight() -> CGFloat  {
    return 740.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class PlayMusicItCell: TableAdapterCell {
  
    @IBOutlet var labelY: NSLayoutConstraint?
    @IBOutlet var imageHeight: NSLayoutConstraint!
    @IBOutlet var imageWidth: NSLayoutConstraint!
    public var data: PlayMusicItCellData?
  
  @IBOutlet private weak var firstImageView: UIImageView?
    
    @IBOutlet var miniView: UIView!
    @IBOutlet private weak var subtitleLabel: UILabel?
  @IBOutlet private weak var titleLabel: UILabel?
    
    @IBOutlet var subtitleMiniLabel: UILabel!
    @IBOutlet private weak var titleMiniLabel: UILabel?
    @IBOutlet var controlMiniImageView: UIImageView!
    
    @IBOutlet var time1Label: UILabel!
    @IBOutlet var time2Label: UILabel!
    @IBOutlet private weak var imageView3: UIImageView?
  @IBOutlet private weak var imageView4: UIImageView?
  @IBOutlet private weak var imageView9: UIImageView?
  @IBOutlet private weak var imageView10: UIImageView?
  @IBOutlet private weak var imageView11: UIImageView?
  
    @IBOutlet var ccardView: UIView!
    @IBOutlet var cccardView: UIView!
    
    @IBOutlet var timeSlider: UISlider!
    @IBOutlet var volumeSlider: UISlider!
    
    @IBOutlet var topControlMoreImageView: UIImageView!
    @IBOutlet var centerControlRightImageView: UIImageView!
    @IBOutlet var centerControlLeftImageView: UIImageView!
    @IBOutlet var centerControllPlayView: UIView!
    @IBOutlet var centerControlPlayImageView: UIImageView!
    @IBOutlet var bottomControlsView: UIView!
    
  @IBOutlet override var selectedView: UIView? { didSet { } }
  @IBOutlet var cardView: UIView?
  @IBOutlet var button: UIButton?
    
    @IBOutlet var imgMusicPicView: DesignFigure!
    var box: Bool = false
    var pause: Bool = true
    
    @IBOutlet var topControlMoreBtn: UIButton!
    
    @IBOutlet var bottomControlsBtn: UIButton!
    @IBOutlet var centerControlRightBtn: UIButton!
    @IBOutlet var centerControlLeftBtn: UIButton!
    @IBOutlet var centerControlPlayBtn: UIButton!
    
    func updateImage(full: Bool = false) {
        let v = ScreenSize.width - 50
//        let v2 = ScreenSize.width + 7
        imageWidth.constant = self.box ? 60 : v
        imageHeight.constant = self.box ? 60 : v
//        labelY.constant = self.box ? 25 : v2
        
        if self.box && self.subtitleLabel?.alpha == 1 {
            self.setNeedsUpdateConstraints()
        } else if !self.box && self.subtitleLabel?.alpha == 0 {
            self.setNeedsUpdateConstraints()
        }
        
        if   let playerType = self.data?.state.type, 
                let d = self.data?.state.duration,
                let c = self.data?.state.currentTime,
                let time = self.data?.state.time,
             let v = self.data?.state.volume {
            print(" player cell \(d) \(c) \(v) ")
            
                let currentTimeChange = self.data?.state.currentTimeChange ?? false
            if !currentTimeChange {
                self.timeSlider.maximumValue = Float(d)
                self.timeSlider.value = d == c ? 0.0 : Float(c)
            }
            
            self.volumeSlider.maximumValue = Float(1.00)
            
            self.volumeSlider.value = Float(v)
            
            let titlee = "\(ViewCallsPlayer.getTitle( playerType))"
            let subtitle = "\(ViewCallsPlayer.getSubtitle( playerType))"
            
            self.titleLabel?.text = titlee
            self.titleMiniLabel!.text = titlee
            
            self.subtitleLabel?.text = subtitle
            self.subtitleMiniLabel.text = subtitle
            
            let ddTime =  String(format: "%02d:%02d", ((Int)((d))) / 60, ((Int)((d))) % 60  )
            if !currentTimeChange {
                self.time1Label.text = time
            }
            self.time2Label.text = ddTime
            
            self.firstImageView?.image = ViewCallsPlayer.getImage( playerType)
            
        }
        
        
        UIView.animate(withDuration: 0.35) {
            if self.box && self.titleLabel?.alpha == 1 {
                self.subtitleLabel?.alpha = 0
                self.titleLabel?.alpha = 0
                self.miniView.alpha = 1
                self.layoutIfNeeded()
            } else if !self.box && self.titleLabel?.alpha == 0 {
                self.miniView.alpha = 0
                self.subtitleLabel?.alpha = 1
                self.titleLabel?.alpha = 1
                self.layoutIfNeeded()
            }
        }
        
        let imgPlay   =   #imageLiteral(resourceName: "iconPlayMusicControlsPlay")
        let imgPause  =   #imageLiteral(resourceName: "iconPlayMusicControlsPause")
        
        let imgMiniPause   =  #imageLiteral(resourceName: "iconPlaylistPause")
        let imgMiniPlay   =  #imageLiteral(resourceName: "iconPlaylistPlay")
        
        if full {
            self.pause = !self.pause
        }
         
        
        if let play = self.data?.state.play {
            self.pause = !play
        }
        
        self.centerControlPlayImageView.image = self.pause ? imgPlay : imgPause
        self.controlMiniImageView.image = self.pause ? imgMiniPlay : imgMiniPause
    }
    
    override func awakeFromNib() {
        self.updateImage(full: false)
        
    separator(hide: true)
        
        button?.tapClassic({ [weak self] down in
            UIView.animate(withDuration: down ? 0.0 : 0.15) {
                self?.cccardView.alpha = down ? 0.14 : 0.05
            }
            if !down {
                self?.data?.state.handlers.onClickAt?()
            }
        })
        
        
        
        centerControlPlayBtn?.tapHideAnimation(
            view: centerControllPlayView,
            type: .alpha(0.5),
            callback: { //[weak self]
                type in
                if type == .touchUpInside {
                    let pl = !self.pause
                    self.data?.state.play = !pl
                    self.pause = !self.pause
//                    if let play = self.data?.state.play {
//                        self.pause = !play
//                    }
                    self.updateImage(full: false)
                    self.data?.state.handlers.onPlayAt?(!self.pause)
                }
            }
        )
        
        centerControlRightBtn?.tapHideAnimation(
            view: centerControlRightImageView,
            type: .alpha(0.5),
            callback: { //[weak self]
                type in
                if type == .touchUpInside {
                    self.data?.state.play = true
                    self.pause = false
                    self.updateImage(full: false)
                    self.data?.state.handlers.onFastForwardAt?(.right)
                }
            }
        )
        centerControlLeftBtn?.tapHideAnimation(
            view: centerControlLeftImageView,
            type: .alpha(0.5),
            callback: { //[weak self]
                type in
                if type == .touchUpInside {
                    self.data?.state.play = true
                    self.pause = false
                    self.updateImage(full: false)
                    self.data?.state.handlers.onFastForwardAt?(.left)
                }
            }
        )
        
        
        topControlMoreBtn?.tapHideAnimation(
            view: topControlMoreImageView,
            type: .alpha(0.5),
            callback: { //[weak self]
                type in
                if type == .touchUpInside {
                    self.data?.state.handlers.onMoreAt?()
                }
            }
        )
        bottomControlsBtn?.tapHideAnimation(
            view: bottomControlsView,
            type: .alpha(0.5),
            callback: { //[weak self]
                type in
                if type == .touchUpInside {
                    
                    self.data?.state.handlers.onMoreAt?()
                }
            }
        )
  }
  
    @IBAction func timeSliderDownAction(_ sender: UISlider) {
        timeSliderrAction(sender, change: true)
    }
    
    @IBAction func timeSliderAction(_ sender: UISlider) {
        timeSliderrAction(sender, change: false)
        
        
    }
    
    func timeSliderrAction(_ sender: UISlider, change: Bool = true) {
        if change {  self.data?.state.currentTimeChange = true }
        
        let newV =  CGFloat(sender.value)
        
        
        let time =  String(format: "%02d:%02d", ((Int)((newV))) / 60, ((Int)((newV))) % 60  )
        
        print("timeSliderrAction \(newV) ")
        
        self.time1Label.text = time
        
        if !change {
            ViewCallsPlayer.shared.avPlayer?.currentTime = newV
            self.data?.state.currentTimeChange = false
        }
        
        self.data?.state.handlers.onTimeAt?(newV)
    }
    
    @IBAction func volumeSliderAction(_ sender: UISlider) {
        
//        AVAudioSession.sharedInstance().setVolume(sender.value, at: CMTime.zero)
    }
    override func fill(data: TableAdapterCellData?) {
    guard let data = data as? PlayMusicItCellData else { return }
    self.data = data
        
        if let play = self.data?.state.play {
            self.pause = !play
        }
        
    if let v = data.state.firstImage { firstImageView?.image = v }
    if let v = data.state.title {
        titleLabel?.text = v
        titleMiniLabel?.text = v
    }
      if let v = data.state.subtitle {
          subtitleLabel?.text = v
          subtitleMiniLabel?.text = v
      }
    if let v = data.state.image3 { imageView3?.image = v
    }
    if let v = data.state.image4 { imageView4?.image = v }
      if let v = data.state.image9 { imageView9?.image = v }
      if let v = data.state.image10 { imageView10?.image = v }
      if let v = data.state.image11 { imageView11?.image = v }
//    if let v = data.state.image5 { imageView5?.image = v }
//    if let v = data.state.image6 { imageView6?.image = v }
//    if let v = data.state.image7 { imageView7?.image = v }
//    if let v = data.state.image8 { imageView8?.image = v }
//    if let v = data.state.image12 { imageView12?.image = v }
    
  }
}
