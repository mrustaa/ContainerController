import UIKit
import ContainerControllerSwift

// MARK: - State

extension WalletsTitleItem {
  struct State {
    var firstImage: UIImage?
    var subtitleText: String?
    var text2: String?
    var text3: String?
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
      var backAt: (()->(Void))?
  }
}

// MARK: - Item

class WalletsTitleItem: TableAdapterItem {
  init(state: WalletsTitleItem.State) {
    let cellData =  WalletsTitleCellData(state: state)
    super.init(cellClass: WalletsTitleCell.self, cellData: cellData)
  }
}

// MARK: - Data

class WalletsTitleCellData: TableAdapterCellData {

  var state: WalletsTitleItem.State

  init(state: WalletsTitleItem.State) {
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
    return 235.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class WalletsTitleCell: TableAdapterCell {
  
  public var data: WalletsTitleCellData?
    @IBOutlet var moreButton: UIButton!
    
  @IBOutlet  weak var firstImageView: UIImageView!
  @IBOutlet private weak var subtitleLabel: UILabel?
  @IBOutlet private weak var label2: UILabel?
  @IBOutlet private weak var label3: UILabel?
  
  @IBOutlet override var selectedView: UIView? { didSet { } }
  @IBOutlet var cardView: UIView?
  @IBOutlet var button: UIButton?
  
  override func awakeFromNib() {
    separator(hide: true)
      
      
      
      moreButton?.tapHideAnimation(
        views: [firstImageView],
        type: .alpha(0.5),
        callback: { [weak self] type in
            if type == .touchUpInside {
                self?.data?.state.handlers.backAt?()
            }
        }
      )
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
    guard let data = data as? WalletsTitleCellData else { return }
    self.data = data
    firstImageView?.image = data.state.firstImage
    subtitleLabel?.text = data.state.subtitleText
    label2?.text = data.state.text2
    label3?.text = data.state.text3
    
  }
}
