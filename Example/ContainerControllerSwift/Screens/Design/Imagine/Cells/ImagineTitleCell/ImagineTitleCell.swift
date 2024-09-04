import UIKit
import ContainerControllerSwift

// MARK: - State

extension ImagineTitleItem {
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

class ImagineTitleItem: TableAdapterItem {
  init(state: ImagineTitleItem.State) {
    let cellData =  ImagineTitleCellData(state: state)
    super.init(cellClass: ImagineTitleCell.self, cellData: cellData)
  }
}

// MARK: - Data

class ImagineTitleCellData: TableAdapterCellData {

  var state: ImagineTitleItem.State

  init(state: ImagineTitleItem.State) {
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
    return 160
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class ImagineTitleCell: TableAdapterCell {
  
  public var data: ImagineTitleCellData?
  
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
    guard let data = data as? ImagineTitleCellData else { return }
    self.data = data
    titleLabel?.text = data.state.titleText
    subtitleLabel?.text = data.state.subtitleText
    
  }
}
