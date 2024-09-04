import UIKit
import ContainerControllerSwift

// MARK: - State

extension SportCatalogTitileItem {
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

class SportCatalogTitileItem: TableAdapterItem {
  init(state: SportCatalogTitileItem.State) {
    let cellData =  SportCatalogTitileCellData(state: state)
    super.init(cellClass: SportCatalogTitileCell.self, cellData: cellData)
  }
}

// MARK: - Data

class SportCatalogTitileCellData: TableAdapterCellData {

  var state: SportCatalogTitileItem.State

  init(state: SportCatalogTitileItem.State) {
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
    return 163.0   - 8
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class SportCatalogTitileCell: TableAdapterCell {
  
  public var data: SportCatalogTitileCellData?
  
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
    guard let data = data as? SportCatalogTitileCellData else { return }
    self.data = data
    if let v = data.state.titleText { titleLabel?.text = v }
    if let v = data.state.secondImage { secondImageView?.image = v }
    
  }
}
