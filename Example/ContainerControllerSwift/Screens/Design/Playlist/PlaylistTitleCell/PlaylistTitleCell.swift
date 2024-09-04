import UIKit
import ContainerControllerSwift

// MARK: - State

extension PlaylistTitleItem {
  struct State {
    var titleText: String?
    var subtitleText: String?
      var redColor: Bool = false
      var smallType: Bool = false
      var blackType: Bool = false
      var paddingTop: Double?
      var firstOpen: Bool?
      
      var color: UIColor?
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
      var menuClickAt: (()->(Void))?
      var moreClickAt: (()->(Void))?
  }
}

// MARK: - Item

class PlaylistTitleItem: TableAdapterItem {
  init(state: PlaylistTitleItem.State) {
    let cellData =  PlaylistTitleCellData(state: state)
    super.init(cellClass: PlaylistTitleCell.self, cellData: cellData)
  }
}

// MARK: - Data

class PlaylistTitleCellData: TableAdapterCellData {

  var state: PlaylistTitleItem.State

  init(state: PlaylistTitleItem.State) {
    self.state = state
    super.init()
    // self.cellClickCallback = state.handlers.onClickAt
  }
  
  override public func cellHeight() -> CGFloat {
      let text =  state.titleText
      
      let calcHeight = sizeToFitLabel(
       text:text ,
       font: UIFont.boldSystemFont(ofSize: state.blackType ? 19 : 25),
       padding: state.blackType ? 15 : 28
     )
      
    
      let plus = (calcHeight.height > 200) ? 24 : 0
      return Self.cHeightClass(state: self.state) + CGFloat(plus)
      
//      if let top = self.state.paddingTop {
//          return top
//      }
//      return self.state.smallType ? 50 : Self.cHeight()
  }
  
    public static func cHeight() -> CGFloat  {
        return 148.0
    }
    
    public static func cHeightClass(state: PlaylistTitleItem.State?) -> CGFloat  {
        if let top = state?.paddingTop {
            return top
        }
        return (state?.smallType ?? false) ? 50 : self.cHeight()
    }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class PlaylistTitleCell: TableAdapterCell {
  
  public var data: PlaylistTitleCellData?
  
  @IBOutlet private weak var titleLabel: UILabel?
  @IBOutlet private weak var subtitleLabel: UILabel?
  
    @IBOutlet var titleSmallLabel: DesignLabel!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var menuImgView: UIImageView!
    @IBOutlet var moreImgView: UIImageView!
    @IBOutlet var moreButton: UIButton!
    
    @IBOutlet override var selectedView: UIView? { didSet { } }
  @IBOutlet var cardView: UIView?
  @IBOutlet var button: UIButton?
    @IBOutlet var mainCardLeading: NSLayoutConstraint!
    @IBOutlet var mainCardBottom: NSLayoutConstraint!
    @IBOutlet var mainCardView: UIView!
    @IBOutlet var sectionCardView: DesignFigure!
    @IBOutlet var ccardView2: UIView!
    public var ccardView3: UIView?
    var firstOpen: Bool = false
  override func awakeFromNib() {
      
//      sectionCardView.isHidden = true
      
      ccardView2.layer.cornerRadius = 11
      let backgroundColor: UIColor =  .playlistColor
//      ccardView2.backgroundColor = .playMusicColor
      ccardView2.layer.backgroundColor = backgroundColor.cgColor
      
      ccardView2.isHidden = true
    separator(hide: true)
      
      menuButton?.tapHideAnimation(
        view: menuImgView,
        type: .alpha(0.5),
        callback: { [weak self] type in
            if type == .touchUpInside {
                self?.data?.state.handlers.menuClickAt?()
            }
        }
      )
      moreButton?.tapHideAnimation(
        view: moreImgView,
        type: .alpha(0.5),
        callback: { [weak self] type in
            if type == .touchUpInside {
                self?.data?.state.handlers.moreClickAt?()
            }
        }
      )
  }
  
    
    func updateVIew3(add: Bool) {
        
        if add {
            if self.ccardView3 == nil {
                let view3 = UIView(frame: .init(x: ScreenSize.width - 64 - 30,
                                                y: PlaylistTitleCellData.cHeightClass(state: self.data?.state) - 22 - 18,
                                                width: 64,
                                                height: 22))
                view3.frame.origin = .zero
                view3.frame = .init(x: 0, y: 0, width: self.mainCardView.width, height: 22)
                
                view3.layer.cornerRadius = 11
                let backgroundColor: UIColor =  self.getColor()
                //      ccardView2.backgroundColor = .playMusicColor
                view3.layer.backgroundColor = backgroundColor.cgColor
                
                
                self.ccardView3 = view3
                
//                if let subtitleLabel = self.subtitleLabel {
                    
//                    self.mainCardView.insertSubview(view3, aboveSubview: subtitleLabel )
                    self.mainCardView.addSubview(view3)
//                }
                
                self.button?.tapHideAnimation(
                    view: ccardView3,
                    type: .flash, // .color([.playMusicColor, .playlistColor]), // .alpha(0.5),\
                    hideSpeed: .s1,
                    callback: { [weak self] type in
                        if type == .touchUpInside {
//                            self?.ccardView3?.animationColor(duration: .s2, colors: [.playMusicColor, .playlistColor])
                            self?.data?.state.handlers.onClickAt?()
                        }
                    }
                )
                
                
                
                self.addConstraintsZerro(view: self.ccardView3, superView: self.mainCardView, padding: 0)
                
            }
            
//            self.ccardView3?.width = self.mainCardView.width
             
        } else {
            self.ccardView3?.layer.removeAllAnimations()
            self.ccardView3?.removeFromSuperview()
            self.ccardView3 = nil
        }
    }
    
    
    
  override func fill(data: TableAdapterCellData?) {
    guard let data = data as? PlaylistTitleCellData else { return }
    self.data = data
      
      self.ccardView3?.width = self.mainCardView.width
      
      self.mainView.backgroundColor = self.data?.state.color ?? .clear
      
      if !firstOpen {
          firstOpen = true
          main(delay: 3) {
              self.updateVIew3(add: false)
              self.updateVIew3(add: true)

          }
      } else {
//          main(delay: 0.55) {

//          }
      }
      
      if data.state.smallType {
          menuImgView.isHidden = true
          moreImgView.isHidden = true
          titleLabel?.isHidden = true
          titleSmallLabel.isHidden = false
      } else {
          
          menuImgView.isHidden = false
          moreImgView.isHidden = false
          titleLabel?.isHidden = false
          titleSmallLabel.isHidden = true
      }
      
      
      
      titleSmallLabel?.textColor = data.state.blackType ? .black : Colors.hexStr("D4D5DA")
      titleSmallLabel?.text = data.state.titleText
      titleSmallLabel?.font = UIFont.boldSystemFont(ofSize: data.state.blackType ? 19 : 25)
      
      mainCardView.isHidden =   data.state.subtitleText == nil
      if data.state.blackType {
          mainCardView.isHidden = true
      }
      
//      let text =  data.state.titleText
//      let calcHeight = sizeToFitLabel(
//        text:text ,
//        font: UIFont.boldSystemFont(ofSize: data.state.blackType ? 19 : 25),
//        padding: data.state.blackType ? 15 : 28
//      )
//      let plus = (calcHeight.height > 200) ? 24 : 0
      
      mainCardBottom.constant =  data.state.blackType ? (6) : 16
      mainCardLeading.constant =  data.state.blackType ? 15 : 28
     
      
      titleLabel?.textColor = data.state.blackType ? .black : .white
    titleLabel?.text = data.state.titleText
    subtitleLabel?.text = data.state.subtitleText
    
      updateSelected()
      
//      if let f = data.state.firstOpen {
//          firstOpen = f
//      }

  }
    
    
    func getColor() -> UIColor {
        
        var cc: UIColor = .playlistColor
        if self.data?.state.redColor ?? false {
            cc = .playMusicColor
        } else {
            cc = .playlistColor
        }
        return cc
    }
    
    func updateSelected() {
        
        if firstOpen {
            
            self.data?.state.firstOpen = true
            updateVIew3(add: false)
            updateVIew3(add: true)
        }
        
        
        self.ccardView3?.backgroundColor = self.getColor()
//        sectionCardView.fillColor = .playlistColor
//        sectionCardView.layoutSubviews()
//        sectionCardView.layoutIfNeeded()
        
    }
}
