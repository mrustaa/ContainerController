import UIKit
import ContainerControllerSwift

// MARK: - State

extension TaxiVisaCardItem {
  struct State {
    var titleText: String?
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class TaxiVisaCardItem: TableAdapterItem {
  init(state: TaxiVisaCardItem.State) {
    let cellData =  TaxiVisaCardCellData(state: state)
    super.init(cellClass: TaxiVisaCardCell.self, cellData: cellData)
  }
}

// MARK: - Data

class TaxiVisaCardCellData: TableAdapterCellData {

  var state: TaxiVisaCardItem.State

  init(state: TaxiVisaCardItem.State) {
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

class TaxiVisaCardCell: TableAdapterCell {
  
  public var data: TaxiVisaCardCellData?
  
  @IBOutlet private weak var titleLabel: UILabel?
  
  @IBOutlet override var selectedView: UIView? { didSet { } }
  @IBOutlet var cardView: UIView?
  @IBOutlet var button: UIButton?
  
  override func awakeFromNib() {
    separator(hide: true)
    button?.tapHideAnimation(
      view: cardView,
      type: .layerGray(0.18),
      callback: { [weak self] type in
        if type == .touchUpInside {
          self?.data?.state.handlers.onClickAt?()
        }
      }
    )
  }
  
  override func fill(data: TableAdapterCellData?) {
    guard let data = data as? TaxiVisaCardCellData else { return }
    self.data = data
    if let v = data.state.titleText { titleLabel?.text = v }
    
  }
}
