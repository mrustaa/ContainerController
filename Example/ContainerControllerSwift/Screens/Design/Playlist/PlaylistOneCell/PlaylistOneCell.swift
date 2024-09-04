import UIKit
import ContainerControllerSwift

// MARK: - State

extension PlaylistOneItem {
  struct State {
      var type: ViewCallsPlayerType = .none
      var selectted: Bool = false
      var redColor: Bool = false
    var firstImage: UIImage?
    var subtitleText: String?
    var text2: String?
    var text3: String?
      
      
      var durationTime: String?
      var radius: CGFloat?
      
    var handlers: Handlers = .init()
  }
  struct Handlers {
  
      var onClickAt: ((_ selType: ViewCallsPlayerType)->(Void))?
  }
}

// MARK: - Item

class PlaylistOneItem: TableAdapterItem {
  init(state: PlaylistOneItem.State) {
    let cellData =  PlaylistOneCellData(state: state)
    super.init(cellClass: PlaylistOneCell.self, cellData: cellData)
  }
}

// MARK: - Data

class PlaylistOneCellData: TableAdapterCellData {

  var state: PlaylistOneItem.State

  init(state: PlaylistOneItem.State) {
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
    return 64.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class PlaylistOneCell: TableAdapterCell {
  
  public var data: PlaylistOneCellData?
  
  @IBOutlet private weak var firstImageView: UIImageView?
  @IBOutlet private weak var subtitleLabel: UILabel?
  @IBOutlet private weak var label2: UILabel?
  @IBOutlet private weak var label3: UILabel?
  
  @IBOutlet override var selectedView: UIView? { didSet { } }
    @IBOutlet var whiteView: UIView!
    
    
    public var blue: Bool = true
    @IBOutlet public var ccardView: DesignnView?
    @IBOutlet public var ccardView2: DesignnView?
  @IBOutlet var button: UIButton?
  
  override func awakeFromNib() {
    separator(hide: true)
      
      
      button?.tapClassic({ [weak self] event in
          var sselected = false
          if event == .touchUpInside {
              self?.data?.state.selectted = true
              sselected = self?.data?.state.selectted ?? false
          }
          
          
          let down = event == .touchDown
          
          UIView.animate(withDuration: down ? 0.0 : 0.45) {
//
              
              self?.whiteView.alpha = down ? 0.1 : 0.0
          }
          
          self?.ccardView?.alpha = (sselected ? 1 : 0.0)
          self?.ccardView2?.alpha = (sselected ? 1 : 0.0)
          
          if event == .touchUpInside {
            
              
              if   let playerType = self?.data?.state.type {
                  self?.data?.state.handlers.onClickAt?(playerType)
              }
              
              
              self?.data?.state.selectted = true
          }
      })
      
      
//      UIView.animate(withDuration: 0.15) {
          self.ccardView?.alpha = 0.0
          
          self.ccardView2?.alpha = 0.0
//      }
//    button?.tapHideAnimation(
//      view: cardView,
//      type: .alpha(0.5),
//      callback: { [weak self] type in
//        if type == .touchUpInside {
//          self?.data?.state.handlers.onClickAt?()
//        }
//      }
//    )
  }
  
  override func fill(data: TableAdapterCellData?) {
    guard let data = data as? PlaylistOneCellData else { return }
    self.data = data
      
      firstImageView?.layer.cornerRadius = self.data?.state.radius ?? 0
      firstImageView?.clipsToBounds = true
      if   let playerType = self.data?.state.type {
          
          
          let firstImage =  ViewCallsPlayer.getImage( playerType)
          let subtitleText =  ViewCallsPlayer.getTitle( playerType)
          let text2 = ViewCallsPlayer.getSubtitle( playerType)
//          let text3 = "0:00"
          
         
          updateDuration()
          
          self.data?.state.firstImage = firstImage
          self.data?.state.subtitleText = subtitleText
          self.data?.state.text2 = text2
//          self.data?.state.text3 = text3
          
          firstImageView?.image = firstImage
          subtitleLabel?.text = subtitleText
          label2?.text = text2
//          label3?.text = text3
      } else {
          
          
          firstImageView?.image = data.state.firstImage
          subtitleLabel?.text = data.state.subtitleText
          label2?.text = data.state.text2
          label3?.text = data.state.text3
      }
      
      self.updateSelected()
      
      //        let red = self.data?.state.redColor ?? false
      self.ccardView?.fillColor = .playlistColor.withAlphaComponent(0.1)
      self.ccardView?.layoutSubviews()
      self.ccardView2?.fillColor = .playMusicColor.withAlphaComponent(0.1)
      self.ccardView2?.layoutSubviews()
      
      
    
  }
    
    
    func updateDuration() {
        
        
        if let time = self.data?.state.durationTime {
            self.data?.state.text3 = time
            self.label3?.text = time
            self.label3?.alpha = 1.0
        } else {
            self.label3?.alpha = 0.4
            if   let playerType = self.data?.state.type {
                
                ViewCallsPlayer.getDuration(playerType) { duration in
                    
                    main {
                        let time =  String(format: "%02d:%02d", ((Int)((duration))) / 60, ((Int)((duration))) % 60 )
                        
                        self.data?.state.durationTime = time
                        self.data?.state.text3 = time
                        self.label3?.text = time
                        self.label3?.alpha = 0.4
                    }
                }
            }
        }
    }
    
    func updateSelected() {
        
        
        
        let sselected = self.data?.state.selectted ?? false
     
//        UIView.animate(withDuration: 0.15) {
            
            if self.blue {
                self.ccardView?.alpha = sselected ? 1 : 0.0
                self.ccardView2?.alpha = sselected ? 0.0 : 0.0
                
            } else {
                self.ccardView?.alpha = sselected ? 0.0 : 0.0
                self.ccardView2?.alpha = sselected ? 1 : 0.0
                
            }
            
//            self.ccardView?.alpha = 1.0// (sselected ? 0.1 : 0.0)
            
//            self.ccardView2?.alpha = (sselected ? 0.1 : 0.0)
//        }
    }
}
