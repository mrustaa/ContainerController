import UIKit
import ContainerControllerSwift

// MARK: - State

extension ImagineHeaderSwitchItem {
  struct State {
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class ImagineHeaderSwitchItem: TableAdapterItem {
  init(state: ImagineHeaderSwitchItem.State) {
    let cellData =  ImagineHeaderSwitchCellData(state: state)
    super.init(cellClass: ImagineHeaderSwitchCell.self, cellData: cellData)
  }
}

// MARK: - Data

class ImagineHeaderSwitchCellData: TableAdapterCellData {

  var state: ImagineHeaderSwitchItem.State

  init(state: ImagineHeaderSwitchItem.State) {
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
    return 102
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class ImagineHeaderSwitchCell: TableAdapterCell {
  
  public var data: ImagineHeaderSwitchCellData?
  
  
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
    guard let data = data as? ImagineHeaderSwitchCellData else { return }
    self.data = data
    
  }
}
