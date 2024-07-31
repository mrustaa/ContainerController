import UIKit
import ContainerControllerSwift

// MARK: - State

extension SportBottomButtonItem {
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

class SportBottomButtonItem: TableAdapterItem {
  init(state: SportBottomButtonItem.State) {
    let cellData =  SportBottomButtonCellData(state: state)
    super.init(cellClass: SportBottomButtonCell.self, cellData: cellData)
  }
}

// MARK: - Data

class SportBottomButtonCellData: TableAdapterCellData {

  var state: SportBottomButtonItem.State

  init(state: SportBottomButtonItem.State) {
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
    return 147.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class SportBottomButtonCell: TableAdapterCell {
  
  public var data: SportBottomButtonCellData?
  
  @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet var carddView: DesignFigure!
    @IBOutlet private weak var subtitleLabel: UILabel?
  
    @IBOutlet var cccardView: DesignFigure!
    @IBOutlet override var selectedView: UIView? { didSet { } }
  @IBOutlet var cardView: UIView?
  @IBOutlet var button: UIButton?
  
  override func awakeFromNib() {
    separator(hide: true)
    button?.tapHideAnimation(
      views: [cccardView, carddView],
      type: .layerGray(0.25),
      callback: { [weak self] type in
        if type == .touchUpInside {
          self?.data?.state.handlers.onClickAt?()
        }
      }
    )
  }
  
  override func fill(data: TableAdapterCellData?) {
    guard let data = data as? SportBottomButtonCellData else { return }
    self.data = data
    if let v = data.state.titleText { titleLabel?.text = v }
    if let v = data.state.subtitleText { subtitleLabel?.text = v }
    
  }
}
