import UIKit
import ContainerControllerSwift

// MARK: - State

extension SportTitleItem {
  struct State {
    var titleText: String?
    var subtitleText: String?
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class SportTitleItem: TableAdapterItem {
  init(state: SportTitleItem.State) {
    let cellData =  SportTitleCellData(state: state)
    super.init(cellClass: SportTitleCell.self, cellData: cellData)
  }
}

// MARK: - Data

class SportTitleCellData: TableAdapterCellData {

  var state: SportTitleItem.State

  init(state: SportTitleItem.State) {
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
      return 86.0 + 5.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class SportTitleCell: TableAdapterCell {
  
  public var data: SportTitleCellData?
  
  @IBOutlet private weak var titleLabel: UILabel?
  @IBOutlet private weak var subtitleLabel: UILabel?
  
  @IBOutlet override var selectedView: UIView? { didSet { } }
  @IBOutlet var cardView: UIView?
  @IBOutlet var button: UIButton?
  
  override func awakeFromNib() {
    separator(hide: true)
    button?.tapHideAnimation(
      view: cardView,
      type: .alpha(0.5),
      callback: { [weak self] type in
        if type == .touchUpInside {
          self?.data?.state.handlers.onClickAt?()
        }
      }
    )
  }
  
  override func fill(data: TableAdapterCellData?) {
    guard let data = data as? SportTitleCellData else { return }
    self.data = data
    if let v = data.state.titleText { titleLabel?.text = v }
    if let v = data.state.subtitleText { subtitleLabel?.text = v }
    
  }
}
