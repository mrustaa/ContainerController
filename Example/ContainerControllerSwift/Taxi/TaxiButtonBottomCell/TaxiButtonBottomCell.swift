import UIKit
import ContainerControllerSwift

// MARK: - State

extension TaxiButtonBottomItem {
  struct State {
    var titleText: String?
      var addIcon: Bool = true
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class TaxiButtonBottomItem: TableAdapterItem {
  init(state: TaxiButtonBottomItem.State) {
    let cellData =  TaxiButtonBottomCellData(state: state)
    super.init(cellClass: TaxiButtonBottomCell.self, cellData: cellData)
  }
}

// MARK: - Data

class TaxiButtonBottomCellData: TableAdapterCellData {

  var state: TaxiButtonBottomItem.State

  init(state: TaxiButtonBottomItem.State) {
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
    return 84.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class TaxiButtonBottomCell: TableAdapterCell {
  
  public var data: TaxiButtonBottomCellData?
  
  @IBOutlet private weak var titleLabel: UILabel?
  
    @IBOutlet var carddView: DesignFigure!
    @IBOutlet var timeView: DesignFigure!
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var iconPadding: NSLayoutConstraint!
    @IBOutlet var iconWidth: NSLayoutConstraint!
    @IBOutlet override var selectedView: UIView? { didSet { } }
    @IBOutlet var iconBtn: UIImageView!
    @IBOutlet var cardView: UIView?
  @IBOutlet var button: UIButton?
  
  override func awakeFromNib() {
    separator(hide: true)
      
      btn1.tapHideAnimation(
        view: carddView,
        type: .layerGray(0.18),
        hideSpeed: .ms350)
      { [weak self] type in
          if type == .touchUpInside {
              self?.data?.state.handlers.onClickAt?()
          }
      }
      btn2.tapHideAnimation(
        view: timeView,
        type: .layerGray(0.18),
        hideSpeed: .ms350)
      { [weak self] type in
          if type == .touchUpInside {
              self?.data?.state.handlers.onClickAt?()
          }
      }
  }
  
  override func fill(data: TableAdapterCellData?) {
    guard let data = data as? TaxiButtonBottomCellData else { return }
    self.data = data
      
      self.iconPadding.constant =  data.state.addIcon ? 11 : 0
      self.iconWidth.constant =  data.state.addIcon ? 60 : 0
      self.iconBtn.isHidden  =  !data.state.addIcon
      
    if let v = data.state.titleText { titleLabel?.text = v }
    
  }
}
