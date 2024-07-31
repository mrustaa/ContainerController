import UIKit
import ContainerControllerSwift

// MARK: - State

extension MyCardsTitileItem {
  struct State {
    var titleText: String?
    var secondImage: UIImage?
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class MyCardsTitileItem: TableAdapterItem {
  init(state: MyCardsTitileItem.State) {
    let cellData =  MyCardsTitileCellData(state: state)
    super.init(cellClass: MyCardsTitileCell.self, cellData: cellData)
  }
}

// MARK: - Data

class MyCardsTitileCellData: TableAdapterCellData {

  var state: MyCardsTitileItem.State

  init(state: MyCardsTitileItem.State) {
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
    return 111.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class MyCardsTitileCell: TableAdapterCell {
  
  public var data: MyCardsTitileCellData?
  
  @IBOutlet private weak var titleLabel: UILabel?
  @IBOutlet private weak var secondImageView: UIImageView?
  
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
    guard let data = data as? MyCardsTitileCellData else { return }
    self.data = data
    if let v = data.state.titleText { titleLabel?.text = v }
    if let v = data.state.secondImage { secondImageView?.image = v }
    
  }
}