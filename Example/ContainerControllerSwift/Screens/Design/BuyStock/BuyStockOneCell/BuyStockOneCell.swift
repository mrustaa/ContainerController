import UIKit
import ContainerControllerSwift

// MARK: - State

extension BuyStockOneItem {
  struct State {
      var dark: Bool = false
    var firstImage: UIImage?
    var subtitleText: String?
    var text2: String?
    var text3: String?
    var text4: String?
      var radius: CGFloat?
      var redColor: Bool = false
      var selectted: Bool = false
      
      
      
      
      var durationTime: String?
      
      var musicType: ViewCallsPlayerType?
    var handlers: Handlers = .init()
  }
  struct Handlers {
      var onClickAt: (()->(Void))?
      var onClickTypeAt: ((ViewCallsPlayerType)->(Void))?
  }
}

// MARK: - Item

class BuyStockOneItem: TableAdapterItem {
  init(state: BuyStockOneItem.State) {
    let cellData =  BuyStockOneCellData(state: state)
    super.init(cellClass: BuyStockOneCell.self, cellData: cellData)
  }
}

// MARK: - Data

class BuyStockOneCellData: TableAdapterCellData {

  var state: BuyStockOneItem.State

  init(state: BuyStockOneItem.State) {
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
    return 68.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class BuyStockOneCell: TableAdapterCell {
  
  public var data: BuyStockOneCellData?
  
    @IBOutlet var ccardSelView: UIView!
    @IBOutlet private weak var firstImageView: UIImageView?
    @IBOutlet var ccardView: DesignFigure!
    @IBOutlet private weak var subtitleLabel: UILabel?
  @IBOutlet private weak var label2: UILabel?
  @IBOutlet private weak var label3: UILabel?
  @IBOutlet private weak var label4: UILabel?
  
  @IBOutlet override var selectedView: UIView? { didSet { } }
  @IBOutlet var cardView: UIView?
  @IBOutlet var button: UIButton?
  
    
    override func selectEvent(_ event: UIControl.Event) {
        if event == .touchUpInside {
            
            
            if let red  = self.data?.state.redColor {
                self.ccardSelView?.backgroundColor =  red ? .playMusicColor :
                    .playlistColor
            } else {
                
                self.ccardSelView?.backgroundColor =  .white
            }
            
            self.ccardSelView?.alpha = 0.0
            UIView.animate(withDuration: 0.45) {
                self.ccardSelView?.alpha = 0.1
            }
            
            if let playerType = self.data?.state.musicType {
                self.data?.state.handlers.onClickTypeAt?(playerType)
            } else {
                self.data?.state.handlers.onClickAt?()
            }
            
            
            self.data?.state.selectted = true
        }
    }
    
  override func awakeFromNib() {
    separator(hide: true)
      
    button?.tapHideAnimation(
      view: ccardView,
      type: .alpha(0.5),
      callback: { [weak self] type in
        if type == .touchUpInside {
            if let playerType = self?.data?.state.musicType {
                self?.data?.state.handlers.onClickTypeAt?(playerType)
            } else {
                self?.data?.state.handlers.onClickAt?()
            }
        }
      }
    )
  }
  
  override func fill(data: TableAdapterCellData?) {
    guard let data = data as? BuyStockOneCellData else { return }
    self.data = data
      
      firstImageView?.layer.cornerRadius = data.state.radius ?? 18
      firstImageView?.clipsToBounds = true
      ccardView?.cornerRadius = data.state.radius ?? 18
      ccardView.layoutSubviews()
      ccardView.layoutIfNeeded()
      
      subtitleLabel?.textColor = data.state.dark ? .black : .white
      label2?.textColor = data.state.dark ? .black : .white
      label3?.textColor = data.state.dark ? .black : .white
      label4?.textColor = data.state.dark ? .black : .white
      
      if let playerType = data.state.musicType {
          
          let firstImage =  ViewCallsPlayer.getImage( playerType)
          let subtitleText =  ViewCallsPlayer.getTitle( playerType)
          let text2 = ViewCallsPlayer.getSubtitle( playerType)
           ViewCallsPlayer.getDuration(playerType) { duration in
               
               main {
                   let time =  String(format: "%02d:%02d", ((Int)((duration))) / 60, ((Int)((duration))) % 60 )
                   
                   self.label3?.text = time
                   
               }
          }
          
          updateDuration()
          
          firstImageView?.image =  firstImage
          subtitleLabel?.text = subtitleText
          label2?.text = text2
      } else {
          
          if let v = data.state.firstImage { firstImageView?.image = v }
          if let v = data.state.subtitleText { subtitleLabel?.text = v }
          if let v = data.state.text2 { label2?.text = v }
          if let v = data.state.text3 { label3?.text = v }
          if let v = data.state.text4 { label4?.text = v }
      }
    
      updateSelected()
  }
    
    func updateDuration() {
        
        
        if let time = self.data?.state.durationTime {
            self.label4?.text = time
        } else {
            self.label4?.text = "..."
        
        }
    }
    
    
    func updateSelected() {
        
        let red = self.data?.state.redColor ?? false
        self.ccardSelView?.backgroundColor = red ? .playMusicColor : .playlistColor
        
        let sselected = self.data?.state.selectted ?? false
        UIView.animate(withDuration: 0.35) {
            self.ccardSelView?.alpha = (sselected ? 0.1 : 0.0)
        }
        
    }
}
