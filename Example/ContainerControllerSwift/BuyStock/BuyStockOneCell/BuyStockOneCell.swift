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
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
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
  
  @IBOutlet private weak var firstImageView: UIImageView?
    @IBOutlet var ccardView: DesignFigure!
    @IBOutlet private weak var subtitleLabel: UILabel?
  @IBOutlet private weak var label2: UILabel?
  @IBOutlet private weak var label3: UILabel?
  @IBOutlet private weak var label4: UILabel?
  
  @IBOutlet override var selectedView: UIView? { didSet { } }
  @IBOutlet var cardView: UIView?
  @IBOutlet var button: UIButton?
  
  override func awakeFromNib() {
    separator(hide: true)
      
    button?.tapHideAnimation(
      view: ccardView,
      type: .alpha(0.5),
      callback: { [weak self] type in
        if type == .touchUpInside {
          self?.data?.state.handlers.onClickAt?()
        }
      }
    )
  }
  
  override func fill(data: TableAdapterCellData?) {
    guard let data = data as? BuyStockOneCellData else { return }
    self.data = data
      
      subtitleLabel?.textColor = data.state.dark ? .black : .white
      label2?.textColor = data.state.dark ? .black : .white
      label3?.textColor = data.state.dark ? .black : .white
      label4?.textColor = data.state.dark ? .black : .white
      
    if let v = data.state.firstImage { firstImageView?.image = v }
    if let v = data.state.subtitleText { subtitleLabel?.text = v }
    if let v = data.state.text2 { label2?.text = v }
    if let v = data.state.text3 { label3?.text = v }
    if let v = data.state.text4 { label4?.text = v }
    
  }
}
