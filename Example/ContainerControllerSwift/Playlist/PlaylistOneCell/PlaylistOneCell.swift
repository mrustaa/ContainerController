import UIKit
import ContainerControllerSwift

// MARK: - State

extension PlaylistOneItem {
  struct State {
    var firstImage: UIImage?
    var subtitleText: String?
    var text2: String?
    var text3: String?
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class PlaylistOneItem: TableAdapterItem {
  init(state: PlaylistOneItem.State) {
    let cellData =  PlaylistOneCellData(state: state)
    super.init(cellClass: PlaylistOneCell.self, cellData: cellData)
  }
}

// MARK: - Data

class PlaylistOneCellData: TableAdapterCellData {

  var state: PlaylistOneItem.State

  init(state: PlaylistOneItem.State) {
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
    return 64.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class PlaylistOneCell: TableAdapterCell {
  
  public var data: PlaylistOneCellData?
  
  @IBOutlet private weak var firstImageView: UIImageView?
  @IBOutlet private weak var subtitleLabel: UILabel?
  @IBOutlet private weak var label2: UILabel?
  @IBOutlet private weak var label3: UILabel?
  
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
    guard let data = data as? PlaylistOneCellData else { return }
    self.data = data
    firstImageView?.image = data.state.firstImage
    subtitleLabel?.text = data.state.subtitleText
    label2?.text = data.state.text2
    label3?.text = data.state.text3
    
  }
}
