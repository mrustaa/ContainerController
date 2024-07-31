import UIKit
import ContainerControllerSwift

// MARK: - State

extension BuyStockTitleItem {
  struct State {
    var titleText: String?
    var subtitleText: String?
    var image2: UIImage?
    var text3: String?
    var image4: UIImage?
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class BuyStockTitleItem: TableAdapterItem {
  init(state: BuyStockTitleItem.State) {
    let cellData =  BuyStockTitleCellData(state: state)
    super.init(cellClass: BuyStockTitleCell.self, cellData: cellData)
  }
}

// MARK: - Data

class BuyStockTitleCellData: TableAdapterCellData {

  var state: BuyStockTitleItem.State

  init(state: BuyStockTitleItem.State) {
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
    return 280.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class BuyStockTitleCell: TableAdapterCell {
  
  public var data: BuyStockTitleCellData?
  
    @IBOutlet var ccardView: UIView!
    @IBOutlet private weak var titleLabel: UILabel?
  @IBOutlet private weak var subtitleLabel: UILabel?
  @IBOutlet private weak var imageView2: UIImageView?
  @IBOutlet private weak var label3: UILabel?
  @IBOutlet private weak var imageView4: UIImageView?
  
  @IBOutlet override var selectedView: UIView? { didSet { } }
  @IBOutlet var cardView: UIView?
  @IBOutlet var button: UIButton?
  
  override func awakeFromNib() {
    separator(hide: true)
    button?.tapHideAnimation(
      view: ccardView,
      type: .alpha(0.5), //  .androidStyle(color: .systemPink),
      callback: { [weak self] type in
        if type == .touchUpInside {
          self?.data?.state.handlers.onClickAt?()
        }
      }
    )
  }
  
  override func fill(data: TableAdapterCellData?) {
    guard let data = data as? BuyStockTitleCellData else { return }
    self.data = data
    if let v = data.state.titleText { titleLabel?.text = v }
    if let v = data.state.subtitleText { subtitleLabel?.text = v }
    if let v = data.state.image2 { imageView2?.image = v }
    if let v = data.state.text3 { label3?.text = v }
    if let v = data.state.image4 { imageView4?.image = v }
    
  }
}
