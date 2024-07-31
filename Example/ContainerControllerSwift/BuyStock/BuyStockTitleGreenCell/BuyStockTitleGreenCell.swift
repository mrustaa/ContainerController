import UIKit
import ContainerControllerSwift

// MARK: - State

extension BuyStockTitleGreenItem {
  struct State {
    var titleText: String?
    var subtitleText: String?
    var image2: UIImage?
    var text3: String?
    var text4: String?
    var text5: String?
    var text6: String?
    var text7: String?
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class BuyStockTitleGreenItem: TableAdapterItem {
  init(state: BuyStockTitleGreenItem.State) {
    let cellData =  BuyStockTitleGreenCellData(state: state)
    super.init(cellClass: BuyStockTitleGreenCell.self, cellData: cellData)
  }
}

// MARK: - Data

class BuyStockTitleGreenCellData: TableAdapterCellData {

  var state: BuyStockTitleGreenItem.State

  init(state: BuyStockTitleGreenItem.State) {
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
    return 267.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class BuyStockTitleGreenCell: TableAdapterCell {
  
  public var data: BuyStockTitleGreenCellData?
  
  @IBOutlet private weak var titleLabel: UILabel?
  @IBOutlet private weak var subtitleLabel: UILabel?
    @IBOutlet var ccardView: UIView!
    @IBOutlet private weak var imageView2: UIImageView?
  @IBOutlet private weak var label3: UILabel?
  @IBOutlet private weak var label4: UILabel?
  @IBOutlet private weak var label5: UILabel?
  @IBOutlet private weak var label6: UILabel?
  @IBOutlet private weak var label7: UILabel?
  
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
    guard let data = data as? BuyStockTitleGreenCellData else { return }
    self.data = data
    if let v = data.state.titleText { titleLabel?.text = v }
    if let v = data.state.subtitleText { subtitleLabel?.text = v }
    if let v = data.state.image2 { imageView2?.image = v }
    if let v = data.state.text3 { label3?.text = v }
    if let v = data.state.text4 { label4?.text = v }
    if let v = data.state.text5 { label5?.text = v }
    if let v = data.state.text6 { label6?.text = v }
    if let v = data.state.text7 { label7?.text = v }
    
  }
}
