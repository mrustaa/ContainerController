import UIKit
import AVFAudio
import ContainerControllerSwift

// MARK: - State

extension PlayMusicItItem {
    enum FastForwardType {
        case right
        case left
    }
    
    
    struct Padding: Equatable {
        static var zero: Padding { Padding() }
        var horizontal: Double = 0
        var vertical: Double = 0
        
        init(_ horizontal: Double = 0, _ vertical: Double = 0) {
            self.horizontal = horizontal
            self.vertical = horizontal
        }
        
        init(horizontal: Double , vertical: Double ) {
            self.horizontal = horizontal
            self.vertical = horizontal
        }
        
        var str: String {
            "(horizontal: \(self.horizontal),vertical: \(self.vertical))"
        }
        var strShort: String {
            "(\(self.horizontal),\(self.vertical))"
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            (lhs.horizontal == rhs.horizontal) && (lhs.vertical == rhs.vertical)
        }
    }
    
  struct State {
      var type: ViewCallsPlayerType = .none
      
      var duration: CGFloat = 0
      var currentTimeChange: Bool = false
      var currentTime: CGFloat = 0
      var volume: Float = 0
      var time: String = ""
      
      var durationTimeInvert: Bool = false
      var play: Bool?
      
      var box: Bool?
      var boxSet: Bool?
      var paddingSave: PlayMusicItItem.Padding = .zero
      
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
      var onMoreAt: ((ViewCallsPlayerType)->(Void))?
      var onClickAt: (()->(Void))?
      
      
      var onTimeAt: ((_ time: CGFloat)->(Void))?
      var onRedColorAt: ((_ red: Bool)->(Void))?
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
    
    var curentType: ViewCallsPlayerType = .none
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    var padding: PlayMusicItItem.Padding = .zero
    
    @IBOutlet var firstaImagePaddingLeft: NSLayoutConstraint!
    @IBOutlet var firstaImagePaddingRight: NSLayoutConstraint!
    @IBOutlet var firstaImagePaddingTop: NSLayoutConstraint!
    @IBOutlet var firstaImagePaddingBottom: NSLayoutConstraint!
    
    @IBOutlet var firstImageViewBorderPaddingLeft: NSLayoutConstraint!
    @IBOutlet var firstImageViewBorderPaddingRight: NSLayoutConstraint!
    @IBOutlet var firstImageViewBorderPaddingTop: NSLayoutConstraint!
    @IBOutlet var firstImageViewBorderPaddingBottom: NSLayoutConstraint!
    @IBOutlet var imageTop: NSLayoutConstraint!
    @IBOutlet var labelY: NSLayoutConstraint?
    @IBOutlet var imageHeight: NSLayoutConstraint!
    @IBOutlet var imageWidth: NSLayoutConstraint!
    public var data: PlayMusicItCellData?
  
    @IBOutlet var firstMainImageView: DesignFigure!
    @IBOutlet var firstFigureImageView: DesignFigure!
    @IBOutlet var firstImageView: UIImageView?
    @IBOutlet var firstBlurImageView: DesignFigure!
    
    @IBOutlet var miniProgressTimeViewHeight2: NSLayoutConstraint!
    @IBOutlet var miniProgressTimeViewRight: NSLayoutConstraint!
    @IBOutlet var miniProgressTimeViewHeight: NSLayoutConstraint!
    @IBOutlet var miniProgressTimeView: UIView!
    @IBOutlet var miniProgressTimeView2: UIView!
    @IBOutlet var miniView: UIView!
    @IBOutlet  weak var subtitleLabel: UILabel?
  @IBOutlet  weak var titleLabel: UILabel?
    
    @IBOutlet var subtitleMiniLabel: UILabel!
    @IBOutlet private weak var titleMiniLabel: UILabel?
    @IBOutlet var controlMiniImageView: UIImageView!
    @IBOutlet var controlMiniRightImageView: UIImageView!
    
    @IBOutlet var time1Label: UILabel!
    @IBOutlet var time2Label: UILabel!
    @IBOutlet private weak var imageView3: UIImageView?
  @IBOutlet private weak var imageView4: UIImageView?
  @IBOutlet private weak var imageView9: UIImageView?
  @IBOutlet private weak var imageView10: UIImageView?
  @IBOutlet private weak var imageView11: UIImageView?
  
    @IBOutlet var ccardView: UIView!
    @IBOutlet var cccardView: UIView!
    
    @IBOutlet var timeSSliderVIew: DesignFigure!
    @IBOutlet var timeSlider: UISlider!
    @IBOutlet var timeSlider2: UISlider!
    @IBOutlet var volumeSliderVIew: DesignFigure!
    @IBOutlet var volumeSlider: UISlider!
    @IBOutlet var volumeSlider2: UISlider!
    
    @IBOutlet var topControlMoreImageView: UIImageView!
    @IBOutlet var topControlMoreImageView2: UIImageView!
    
    @IBOutlet var centerControlRightImageView: UIImageView!
    @IBOutlet var centerControlRightImageView2: UIImageView!
    
    @IBOutlet var centerControlLeftImageView: UIImageView!
    @IBOutlet var centerControlLeftImageView2: UIImageView!
    
    @IBOutlet var centerControllPlayView: UIView!
    
    
    @IBOutlet var centerControlPauseImageView: UIImageView!
    @IBOutlet var centerControlPauseImageView2: UIImageView!
    
    @IBOutlet var centerControlPlayImageView: UIImageView!
    @IBOutlet var centerControlPlayImageView2: UIImageView!
    
    @IBOutlet var bottomControlsView: UIView!
    @IBOutlet var bottomControlsView2: UIView!
    
    var firstOpen: Bool = false
    
    
    @IBOutlet override var selectedView: UIView? { didSet { } }
  @IBOutlet var cardView: UIView?
    @IBOutlet var redButton: UIButton?
  @IBOutlet var button: UIButton?
    @IBOutlet var playMiniButton: UIButton?
    @IBOutlet var rightMiniButton: UIButton?
    
    @IBOutlet var imgMusicPicView: DesignFigure!
//    var box: Bool = false
    var pause: Bool = true
    var redColor: Bool = false
    
    
    
    @IBOutlet var topControlMoreBtn: UIButton!
    
    @IBOutlet var bottomControlsBtn: UIButton!
    @IBOutlet var centerControlRightBtn: UIButton!
    @IBOutlet var centerControlLeftBtn: UIButton!
    @IBOutlet var centerControlPlayBtn: UIButton!
    
    func updateImage(full: Bool = false) {
//        var resultt: Bool = false
////        var cc: UIColor = .playlistColor
//        if   let playerType = self.data?.state.type {
//            let vall = playerType.rawValue
//            let result = (vall % 2)
////            print(" updateImag result \(result)")
//            if result == 0 {
//                resultt = true
////                cc = .playMusicColor
//            } else {
////                cc = .playlistColor
//            }
//        }
        
        
        
        
        let red: UIColor = .playMusicColor
        let blue: UIColor = .playlistColor
        
        self.controlMiniImageView.tintColor = blue
        self.imageView3?.tintColor =  blue
        self.imageView4?.tintColor =  blue
        self.imageView9?.tintColor =  blue
        self.imageView10?.tintColor = blue
        self.imageView11?.tintColor = blue
        self.topControlMoreImageView.tintColor = blue
        
        self.centerControlRightImageView.tintColor = blue
        self.centerControlLeftImageView.tintColor = blue
        self.centerControlPlayImageView.tintColor = blue
        self.centerControlPauseImageView.tintColor = blue
        self.timeSlider.tintColor = .clear
        self.volumeSlider.tintColor = .clear
        
        self.centerControlLeftImageView2.tintColor = red
        self.centerControlRightImageView2.tintColor = red
        self.centerControlPauseImageView2.tintColor = red
        
        self.centerControlPlayImageView2.tintColor = red
    
//        self.timeSlider2.tintColor = red
//        self.volumeSlider2.tintColor = red
        
//        if self.redColor != resultt {
//            self.redColor = resultt
            
            self.button?.isHidden = !self.redColor
            self.redButton?.isHidden = self.redColor
            
            
            
//            self.data?.state.handlers.onRedColorAt?(resultt)
            //        playlistColor
//        }
        
        let v = ScreenSize.width - 50
//        let v2 = ScreenSize.width + 7
        
        let box = self.data?.state.box ?? false
        
        button?.isUserInteractionEnabled = box
        playMiniButton?.isUserInteractionEnabled = box
        
        let sizee = box ? 60 : v
        
        imageTop.constant = 19
        imageWidth.constant = sizee
        imageHeight.constant = sizee
//        labelY.constant = self.box ? 25 : v2
        
        
        
        
        
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

        self.centerControlPlayImageView2.image = self.pause ? imgPlay : imgPause
        self.centerControlPlayImageView.image = self.pause ? imgPlay : imgPause
        
//        self.centerControlPlayImageView.isHidden = self.pause ? false :
        
        self.controlMiniImageView.image = self.pause ? imgMiniPlay : imgMiniPause
        
        
        var updatedBox: Bool?
        var updatedAnimation: Bool?
        
        if   let playerType = self.data?.state.type,
                let d = self.data?.state.duration,
                let c = self.data?.state.currentTime,
                let _ = self.data?.state.time,
             let v = self.data?.state.volume {
            //            print(" player cell \(d) \(c) \(v) ")
            
            
            let currentTimeChange = self.data?.state.currentTimeChange ?? false
            if !currentTimeChange {
                self.timeSlider.maximumValue = Float(d)
                self.timeSlider.value = d == c ? 0.0 : Float(c)
                self.timeSlider2.maximumValue = Float(d)
                self.timeSlider2.value = d == c ? 0.0 : Float(c)
                
                self.miniProgressTimeViewHeight2.constant = 0.5
                self.miniProgressTimeViewHeight.constant = 0.5
//                self.miniProgressTimeView.alpha  = 0.0
//                self.miniProgressTimeView2.alpha  = 0.0
                
                let zero = ((c == 0) && (d == 0))
                if !zero {
                    let percent = ((c / d) + 0.03)
                    let resutl = ScreenSize.width  * percent
                    let resultInvert = ScreenSize.width - resutl
                    
//                    let colorr: UIColor = self.redColor ? .playMusicColor : .playlistColor
//                    self.miniProgressTimeView.backgroundColor = colorr
                    self.miniProgressTimeViewRight.constant = resultInvert
                }
            }
            
            let ddTime =  String(format: "%02d:%02d", ((Int)((d))) / 60, ((Int)((d))) % 60  )
            self.updateTime1Label()
            if !currentTimeChange {
//                self.time1Label.text = time
            }
            self.time2Label.text = ddTime
            
            
            self.volumeSlider.maximumValue = Float(1.00)
            self.volumeSlider.value = Float(v)
            
            
            
            self.volumeSlider2.maximumValue = Float(1.00)
            self.volumeSlider2.value = Float(v)
            
            
            
            
            if let box  = self.data?.state.box {
                
                var findBox = false
                if let boxSet = self.data?.state.boxSet {
                    if boxSet == box {
                        findBox = true
                    }
                }
                
                if box && !findBox {// && !(self.data?.state.boxSet ?? false) {// && self.subtitleLabel?.alpha == 1 {
//                    self.data?.state.boxSet = true
                    //                self.setNeedsUpdateConstraints()
                    updatedBox = true
                    self.data?.state.boxSet = box
                } else if !box && !findBox {//&& (self.data?.state.boxSet ?? true)  { // && self.subtitleLabel?.alpha == 0 {
//                    self.data?.state.boxSet = false
                    //                self.setNeedsUpdateConstraints()
                    updatedBox = false
                    self.data?.state.boxSet = box
                }
            }
            
            
            
            if self.curentType != playerType {
                updatedAnimation = true
//                if box {
//                    updatedBox = true
//                } else if !box {
//                    updatedBox = false
//                }
                
            }
            
            self.curentType = playerType
            
           
                
                let titlee = "\(ViewCallsPlayer.getTitle( playerType))"
                let subtitle = "\(ViewCallsPlayer.getSubtitle( playerType))"
                
                self.titleLabel?.text = titlee
                self.titleMiniLabel!.text = titlee
                
                self.subtitleLabel?.text = subtitle
                self.subtitleMiniLabel.text = subtitle
                
                
                let image = ViewCallsPlayer.getImage( playerType)
                self.firstImageView?.image = image
            if let v = image { self.calculateImageBorder(v, box) }
                self.firstImageView?.layer.cornerRadius = 7
                
            
            if let _ = updatedAnimation {
                self.firstImageView?.alpha = 0.0
            } else {
                self.firstImageView?.alpha = 1.0
            }
            
            
//            if let img = ViewCallsPlayer.getImage( playerType) {
//                self.firstBlurImageView?.image = img // blurImage(image: img)
//                self.firstBlurImageView?.blur = 10
//                self.firstBlurImageView?.cornerRadius = 7
//                self.firstBlurImageView?.layoutSubviews()
//                self.firstBlurImageView?.layoutIfNeeded()
//            }
//    
//            self.firstBlurImageView.alpha = 0.0
            self.spinner.startAnimating()
            
        }
        
        
        
        
        
            if let updatedBox = updatedBox {
                if updatedBox == true {
                    self.spinner.style = .medium
//                    firstImageView?.contentMode = .scaleAspectFill
                    self.setNeedsUpdateConstraints()
                }  else if  updatedBox == false {
//                    self.spinner.isHidden = false
                    self.spinner.style = .large
//                    firstImageView?.contentMode = .scaleAspectFit
                    self.setNeedsUpdateConstraints()
                } else if let _ = updatedAnimation {
                    self.setNeedsUpdateConstraints()
                }
            }
        

            
        
        UIView.animate(withDuration: 0.5) {
            if let updatedBox = updatedBox {
                if updatedBox == true {

//                    self.firstFigureImageView.layoutIfNeeded()
//                    self.firstImageView?.layoutIfNeeded()
//                    self.firstMainImageView.layoutIfNeeded()
                    self.layoutIfNeeded()
                }  else if  updatedBox == false {
//                    self.firstFigureImageView.layoutIfNeeded()
//                    self.firstImageView?.layoutIfNeeded()
//                    self.firstMainImageView.layoutIfNeeded()
                    self.layoutIfNeeded()
                }
            }
        }
   
    
        
        if let _ = updatedAnimation {
//            UIView.animate(withDuration: 0.015) {
               
//                self.firstFigureImageView.layoutIfNeeded()
//                self.firstImageView?.layoutIfNeeded()
//                self.firstMainImageView.layoutIfNeeded()
//                self.layoutIfNeeded()
//            }
            
            
            main(delay: 0.25) {
                
                UIView.animate(withDuration: 0.5, animations: {
                    
                    self.firstImageView?.alpha = 1.0
                    
                })
                
            }
        }
      
   
        
            
            UIView.animate(withDuration: 0.5, animations: {
                if let updatedBox = updatedBox {
                    if updatedBox == true { // self.box && self.titleLabel?.alpha == 1 {
                        
                        //                        self.firstBlurImageView.alpha = 1.0
                        //                        self.setNeedsUpdateConstraints()
                        
                        
                        //                        self.firstBlurImageView?.layoutSubviews()
                        //                        self.firstBlurImageView?.layoutIfNeeded()
                        
//                                                self.firstMainImageView.layoutIfNeeded()
//                                                self.firstFigureImageView.layoutIfNeeded()
//                        self.firstImageView?.alpha = 1.0
                        
                        
                        self.subtitleLabel?.alpha = 0
                        self.titleLabel?.alpha = 0
                        self.miniView.alpha = 1
                        self.playMiniButton?.alpha = 1
                        self.rightMiniButton?.alpha = 1
//                                                self.layoutIfNeeded()
                    } else if  updatedBox == false { // !self.box && self.titleLabel?.alpha == 0 {
//                        self.setNeedsUpdateConstraints()
//                        self.firstImageView?.alpha = 1.0
                        //                        self.firstBlurImageView.alpha = 1.0
                        //                        self.setNeedsUpdateConstraints()
                        
                        //                        self.firstBlurImageView?.layoutSubviews()
                        //                        self.firstBlurImageView?.layoutIfNeeded()
                        
//                                                self.firstMainImageView.layoutIfNeeded()
//                                                self.firstFigureImageView.layoutIfNeeded()
                        self.miniView.alpha = 0
                        self.subtitleLabel?.alpha = 1
                        self.titleLabel?.alpha = 1
                        self.playMiniButton?.alpha = 0
                        self.rightMiniButton?.alpha = 0
//                                                self.layoutIfNeeded()
                    }
                }
            }, completion: { fim in
//                self.spinner.stopAnimating()
//                self.spinner.hidesWhenStopped = true
                
            })
        
        
    }
    
    
    func calculateImageBorder(_ v: UIImage, _ updatedBox: Bool? = nil) {
        
        let mainSize: CGSize = .init(width: ScreenSize.width - 30 - 30, height: 325)
        var newSize: CGSize = .zero
        
        
        
        
        
        //        var verticalPadding: CGFloat = 0
        //        var horizontalPadding: CGFloat = 0
        
        padding = .zero
        
        if v.size.width > v.size.height {
            
            let p = (v.size.width / mainSize.width)
            
            let newHeight = (v.size.height / p)
            let newWidth  = mainSize.width
            
            newSize = .init(width: newWidth, height: newHeight)
            
            //            verticalPadding = mainSize.height - newHeight
            padding.vertical = mainSize.height - newHeight
            self.data?.state.paddingSave = padding
            
            
        } else if v.size.width < v.size.height {
            
            let p = (v.size.height / mainSize.height)
            
            let newWidth = (v.size.width / p)
            let newHeight  = mainSize.height
            
            newSize = .init(width: newWidth, height: newHeight)
            
            //            horizontalPadding = mainSize.width - newWidth
            padding.horizontal = mainSize.width - newWidth
            self.data?.state.paddingSave = padding
        }
        
        
//        var updateYes: Bool = false
        
        
        
        
        if let updatedBox = updatedBox {
            if updatedBox == true {
                padding = .zero
            }  else if  updatedBox == false {
                
            }
        }
        
        if padding == .zero {
            
                firstImageViewBorderPaddingLeft.constant    = 0
                firstImageViewBorderPaddingTop.constant     = 0
                firstImageViewBorderPaddingBottom.constant  = 0
                firstImageViewBorderPaddingRight.constant   = 0
            
            
            firstaImagePaddingLeft.constant = 5
            firstaImagePaddingRight.constant = 5
            firstaImagePaddingTop.constant = 5
            firstaImagePaddingBottom.constant = 5

            
        } else if padding.horizontal != 0 {
            
            let verticalPadding = (padding.horizontal / 2) - 5
            
                firstImageViewBorderPaddingTop.constant     = 0
                firstImageViewBorderPaddingBottom.constant  = 0
                firstImageViewBorderPaddingLeft.constant    = verticalPadding
                firstImageViewBorderPaddingRight.constant   = verticalPadding
            
            
            firstaImagePaddingTop.constant =    5
            firstaImagePaddingBottom.constant = 5
            firstaImagePaddingLeft.constant =   verticalPadding + 5
            firstaImagePaddingRight.constant =  verticalPadding + 5
            
//            firstaImagePaddingTop.constant = 5
//            firstaImagePaddingBottom.constant = 5
//                updateYes  = true
//            }
            
            
            
        } else if padding.vertical != 0 {
            
            let horizontalPadding = (padding.vertical   / 2) - 5
            
            
//            if ((firstImageViewBorderPaddingTop.constant == horizontalPadding) &&
//                (firstImageViewBorderPaddingBottom.constant == horizontalPadding)) {
//                updateYes = false
//            } else {
                firstImageViewBorderPaddingTop.constant     = horizontalPadding
                firstImageViewBorderPaddingBottom.constant  = horizontalPadding
                firstImageViewBorderPaddingLeft.constant    = 0
                firstImageViewBorderPaddingRight.constant   = 0
            
            
            firstaImagePaddingTop.constant =    horizontalPadding + 5
            firstaImagePaddingBottom.constant = horizontalPadding + 5
            firstaImagePaddingLeft.constant =   5
            firstaImagePaddingRight.constant =  5
//
//                firstaImagePaddingTop.constant = horizontalPadding - 5
//                firstaImagePaddingBottom.constant = horizontalPadding - 5
//                updateYes  = true
//            }
            
        }
        
         
        
        
        
        print("  newSize: \(newSize.strShort) | padding: \(padding.strShort)")
    }
    
    func updateTime1Label() {
        
            
            if  let d1 = self.data?.state.currentTime,
                let d0 = self.data?.state.duration,
        
                    let invert = self.data?.state.durationTimeInvert {
                
                var new = d1
                if invert {
                    new = d0 - d1
                }
                
                let ddTime =  String(format: "%02d:%02d", ((Int)((new))) / 60, ((Int)((new))) % 60  )
                self.time1Label.text = (invert ? "-" : "") + ddTime
                
            }
        
    }
    
    @IBAction func durationButtonClickAction(_ sender: UIButton) {
        
        
        if let value = self.data?.state.durationTimeInvert {
            
            let invert = !value
            self.data?.state.durationTimeInvert = invert
        }
        
        updateTime1Label()
    }
    
    func playPauseAction() {
        
        let pl = !self.pause
        self.data?.state.play = !pl
        self.pause = !self.pause
        //                    if let play = self.data?.state.play {
        //                        self.pause = !play
        //                    }
        self.updateImage(full: false)
        self.data?.state.handlers.onPlayAt?(!self.pause)
        
    }
    
    func rightLeftNextAction(_ type: PlayMusicItItem.FastForwardType) {
        self.data?.state.play = true
        self.pause = false
        self.updateImage(full: false)
        
        
//        self.changeRedColor()
        
        self.data?.state.handlers.onFastForwardAt?(type)
        
    }
    
    
    func changeRedColor() {
        
        var resultt: Bool = false
        if   let playerType = self.data?.state.type {
            let vall = playerType.rawValue
            let result = (vall % 2)
            print(" updateImag result \(result)")
            if result == 0 {
                resultt = true
                //                cc = .playMusicColor
            } else {
                //                cc = .playlistColor
            }
        }
        
        if self.redColor != resultt {
            self.redColor = resultt
            self.button?.isHidden = !self.redColor
            self.redButton?.isHidden = self.redColor
            self.data?.state.handlers.onRedColorAt?(resultt)
            
        }
    }
    
    override func awakeFromNib() {
        self.updateImage(full: false)
        
        self.cccardView.alpha = 0.00
        self.cccardView.isHidden = true
        
        self.miniProgressTimeView.alpha  = 0.0
        self.miniProgressTimeView2.alpha  = 0.0
        self.miniProgressTimeViewRight.constant = ScreenSize.width
        
    separator(hide: true)
        playMiniButton?.tapClassic({ [weak self] event in
            let down = event == .touchDown
            UIView.animate(withDuration: down ? 0.0 : 0.35) {
                self?.controlMiniImageView.alpha = down ? 0.2 : 1.0
            }
            if event == .touchUpInside {
                self?.playPauseAction()
            }
        })
        
       rightMiniButton?.tapClassic({ [weak self] event in
            let down = event == .touchDown
            UIView.animate(withDuration: down ? 0.0 : 0.35) {
                self?.controlMiniRightImageView.alpha = down ? 0.2 : 1.0
            }
           if event == .touchUpInside {
               self?.rightLeftNextAction(.right)
           }
        })
        
        
        
        var colorr: UIColor = self.redColor ? .playMusicColor : .playlistColor
        colorr = colorr.withAlphaComponent(0.4)
        
        
        
        
        button?.tapHideAnimation(
            view: firstImageView,
            type: .androidStyle(color: .playMusicColor.withAlphaComponent(0.34)),
            hideSpeed: .ms100,
            callback: { [weak self]  eventType in
//                let down = eventType == .touchDown
//                UIView.animate(withDuration: down ? 0.0 : 0.25) {
//                    self?.cccardView.alpha = down ? 0.1 : 0.00
//                }
                
                if eventType == .touchUpInside {
                    
                    
                    self?.data?.state.handlers.onClickAt?()
                    
                }
            }
        )
        
        redButton?.tapHideAnimation(
            view: firstImageView,
            type: .androidStyle(color: .playlistColor.withAlphaComponent(0.34)),
            hideSpeed: .ms100,
            callback: { [weak self]  eventType in
//                let down = eventType == .touchDown
//                UIView.animate(withDuration: down ? 0.0 : 0.25) {
//                    self?.cccardView.alpha = down ? 0.1 : 0.00
//                }
                
                if eventType == .touchUpInside {
                    
                    
                    self?.data?.state.handlers.onClickAt?()
                    
                }
            }
        )
        
//        button?.tapClassic({ [weak self] event in
//            let down = event == .touchDown
//            UIView.animate(withDuration: down ? 0.0 : 0.25) {
//                self?.cccardView.alpha = down ? 0.14 : 0.02
//            }
//            if event == .touchUpInside {
//                self?.data?.state.handlers.onClickAt?()
//            }
//        })
        
        
        
        centerControlPlayBtn?.tapHideAnimation(
            view: centerControlPlayImageView,
            type:  .flash, //.alpha(0.5), //.shake(new: false),
            hideSpeed: .s1,
            callback: { [weak self] type in
                if type == .touchUpInside {
//                    self?.centerControlPlayImageView?.animationOpacity(duration: 1.0, value: 0.1)
                    self?.playPauseAction()
                    
                }
            }
        )
        
        
        
        
        centerControlRightBtn?.tapHideAnimation(
            view: centerControlRightImageView,
            type: .flash, // .shake(new: false),
            hideSpeed: .s1,
            callback: { [weak self] type in
                if type == .touchUpInside {
//                    self?.centerControlRightImageView?.animationOpacity(duration: 1.0, value: 0.1)
                    //
                    
                    
                    self?.rightLeftNextAction(.right)
                }
            }
        )
        centerControlLeftBtn?.tapHideAnimation(
            view: centerControlLeftImageView,
            type:  .flash,
            hideSpeed: .s1,
            callback: { [weak self] type in
                if type == .touchUpInside {
//                    self?.centerControlLeftImageView?.animationOpacity(duration: 1.0, value: 0.1)
                    self?.rightLeftNextAction(.left)
                }
            }
        )
        
        
        topControlMoreBtn?.tapHideAnimation(
            view: topControlMoreImageView,
            type:   .pulsate(new: false, value: 0.7),
            callback: { [weak self]  type in
                if type == .touchUpInside {
                    if let type = self?.data?.state.type {
                        main(delay: 0.4) {
                            self?.data?.state.handlers.onMoreAt?(type)
                        }
                    }
                }
            }
        )
        bottomControlsBtn?.tapHideAnimation(
            view: bottomControlsView,
            type: .pulsate(new: false, value: 0.7),
            callback: { [weak self] type in
                if type == .touchUpInside {
                    if let type = self?.data?.state.type {
                        main(delay: 0.4) {
                            self?.data?.state.handlers.onMoreAt?(type)
                        }
                    }
                }
            }
        )
        
        
        if !ViewCallsPlayer.shared.colorAnimaton {
            step1()
        }
  }
  
    func step1() {
        UIView.animate(withDuration: 1, animations: {
            
            self.centerControlPlayImageView?.alpha = 0
            self.centerControlRightImageView?.alpha = 0
            self.centerControlLeftImageView?.alpha = 0
            self.topControlMoreImageView?.alpha = 0
            
//            self.timeSlider?.alpha = 0
//            self.volumeSlider?.alpha = 0
            self.volumeSliderVIew?.alpha = 0
            self.timeSSliderVIew?.alpha = 0
            
            self.bottomControlsView?.alpha = 0
//            main {
//                self.timeSlider?.tintColor = .playlistColor.withAlphaComponent(0.0)
//                self.volumeSlider?.tintColor = .playlistColor.withAlphaComponent(0.0)
//            }
            
            //                self.v1.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            //                self.v2.transform = .identity
        }) { _ in
            main {
                self.step2()
            }
        }
    }
    
    func step2() {
        UIView.animate(withDuration: 1, animations: {
            
            
            self.centerControlPlayImageView?.alpha = 1
            self.centerControlRightImageView?.alpha = 1
            self.centerControlLeftImageView?.alpha = 1
            
            self.topControlMoreImageView?.alpha = 1
            
//            self.timeSlider?.alpha = 1
//            self.volumeSlider?.alpha = 1
            self.volumeSliderVIew?.alpha = 1
            self.timeSSliderVIew?.alpha = 1
            self.bottomControlsView?.alpha = 1
            
            
            
//            main {
//                self.timeSlider?.tintColor = .playlistColor.withAlphaComponent(1.0)
//                self.volumeSlider?.tintColor = .playlistColor.withAlphaComponent(1.0)
//            }
            
            //                self.v1.transform = .identity
            //                self.v2.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { _ in
            main {
                self.step1()
            }
        }
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
        
        self.data?.state.currentTime = newV
        self.updateTime1Label()
        
//        let time =  String(format: "%02d:%02d", ((Int)((newV))) / 60, ((Int)((newV))) % 60  )
//        
//        print("timeSliderrAction \(newV) ")
//        
//        self.time1Label.text = time
        
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
        
//        self.firstBlurImageView?.image = nil
        
        if let play = self.data?.state.play {
            self.pause = !play
        }
        firstImageView?.clipsToBounds = true
        firstImageView?.layer.cornerRadius = 7
        
        firstImageView?.contentMode = ViewCallsPlayer.shared.colorsTest ? .scaleAspectFill : .scaleAspectFit
        
        firstImageView?.contentMode =   .scaleAspectFit
        
        firstBlurImageView?.layer.cornerRadius = 7
        
        firstMainImageView?.layer.cornerRadius = 10
        firstFigureImageView?.layer.cornerRadius = 10
        
//        firstMainImageView.layoutSubviews()
//        firstMainImageView.layoutIfNeeded()
//        firstFigureImageView.layoutSubviews()
//        firstFigureImageView.layoutIfNeeded()
        
        if let v = data.state.firstImage {
            firstImageView?.image = v
            
//             self.calculateImageBorder(v) 
            self.firstImageView?.layer.cornerRadius = 7
        }
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
        
        
//        var resultt: Bool = false
////        var cc: UIColor = .playlistColor
//        if   let playerType = self.data?.state.type {
//            let vall = playerType.rawValue
//            let result = (vall % 2)
//            print(" updateImag result \(result)")
//            if result == 0 {
//                resultt = true
////                cc = .playMusicColor
//            } else {
////                cc = .playlistColor
//            }
//        }
        
//        if self.redColor != resultt {
//            self.redColor = resultt
            self.button?.isHidden = !self.redColor
            self.redButton?.isHidden = self.redColor
//            self.data?.state.handlers.onRedColorAt?(resultt)
            //        playlistColor
//        }
        
        
        let red: UIColor = .playMusicColor
        let blue: UIColor = .playlistColor
        
        self.controlMiniImageView.tintColor = blue
        self.imageView3?.tintColor =  blue
        self.imageView4?.tintColor =  blue
        self.imageView9?.tintColor =  blue
        self.imageView10?.tintColor = blue
        self.imageView11?.tintColor = blue
        self.topControlMoreImageView.tintColor = blue
        
        self.centerControlRightImageView.tintColor = blue
        self.centerControlLeftImageView.tintColor = blue
        self.centerControlPlayImageView.tintColor = blue
        self.centerControlPauseImageView.tintColor = blue
        self.timeSlider.tintColor = .clear
        self.volumeSlider.tintColor = .clear
        
        self.centerControlLeftImageView2.tintColor = red
        self.centerControlRightImageView2.tintColor = red
        self.centerControlPauseImageView2.tintColor = red
        
        self.centerControlPlayImageView2.tintColor = red
        
        self.timeSlider2.tintColor = red
        self.volumeSlider2.tintColor = red
        
        
        
        if !firstOpen {
            firstOpen = true
            main(delay: 5) {
//                self.centerControlLeftImageView2?.animationOpacity(duration: 1.0, value: 0.1)
                
            }
        } else {
            
            
            if firstOpen {
                main(delay: 1.0) {
//                    self.centerControlLeftImageView2?.animationOpacity(duration: 1.0, value: 0.1)
                    
                }
            }
        }
        
  }
    
    func blurImage(image:UIImage) -> UIImage? {
        let context = CIContext(options: nil)
        let inputImage = CIImage(image: image)
        let originalOrientation = image.imageOrientation
        let originalScale = image.scale
        
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        filter?.setValue(10.0, forKey: kCIInputRadiusKey)
        let outputImage = filter?.outputImage
        
        var cgImage:CGImage?
        
        if let asd = outputImage
        {
            cgImage = context.createCGImage(asd, from: (inputImage?.extent)!)
        }
        
        if let cgImageA = cgImage
        {
            return UIImage(cgImage: cgImageA, scale: originalScale, orientation: originalOrientation)
        }
        
        return nil
    }
}


extension CGSize {
    var str: String {
        "(width: \(self.width),height: \(self.height))"
    }
    var strShort: String {
        "(\(self.width),\(self.height))"
    }
}
