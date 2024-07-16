import UIKit
import ContainerControllerSwift

// MARK: - State

extension PlaylistCollectionsItem {
  struct State {
    var firstImage: UIImage?
    var secondImage: UIImage?
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class PlaylistCollectionsItem: TableAdapterItem {
  init(state: PlaylistCollectionsItem.State) {
    let cellData =  PlaylistCollectionsCellData(state: state)
    super.init(cellClass: PlaylistCollectionsCell.self, cellData: cellData)
  }
}

// MARK: - Data

class PlaylistCollectionsCellData: TableAdapterCellData {

  var state: PlaylistCollectionsItem.State

  init(state: PlaylistCollectionsItem.State) {
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
    return 162.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class PlaylistCollectionsCell: TableAdapterCell {
  
  public var data: PlaylistCollectionsCellData?
  
  @IBOutlet private weak var firstImageView: UIImageView?
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
    guard let data = data as? PlaylistCollectionsCellData else { return }
    self.data = data
    firstImageView?.image = data.state.firstImage
    secondImageView?.image = data.state.secondImage
    
  }
}
