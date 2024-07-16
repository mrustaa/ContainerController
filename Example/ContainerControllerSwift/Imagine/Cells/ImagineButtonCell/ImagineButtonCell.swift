import UIKit
import ContainerControllerSwift

// MARK: - State

extension ImagineButtonItem {
  struct State {
    var titleText: String?
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class ImagineButtonItem: TableAdapterItem {
  init(state: ImagineButtonItem.State) {
    let cellData =  ImagineButtonCellData(state: state)
    super.init(cellClass: ImagineButtonCell.self, cellData: cellData)
  }
}

// MARK: - Data

class ImagineButtonCellData: TableAdapterCellData {

  var state: ImagineButtonItem.State

  init(state: ImagineButtonItem.State) {
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
    return 90.0
  }

//  override public func canEditing() -> Bool {
//    return editing
//  }
}

// MARK: - Cell

class ImagineButtonCell: TableAdapterCell {
  
  public var data: ImagineButtonCellData?
  
  @IBOutlet private weak var titleLabel: UILabel?
  
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
    guard let data = data as? ImagineButtonCellData else { return }
    self.data = data
    titleLabel?.text = data.state.titleText
    
  }
}
