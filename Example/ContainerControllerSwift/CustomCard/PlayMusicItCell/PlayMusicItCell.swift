import UIKit
import ContainerControllerSwift

// MARK: - State

extension PlayMusicItItem {
  struct State {
    var firstImage: UIImage?
    var subtitleText: String?
    var text2: String?
    var image3: UIImage?
    var image4: UIImage?
    var image5: UIImage?
    var image6: UIImage?
    var image7: UIImage?
    var image8: UIImage?
    var image9: UIImage?
    var image10: UIImage?
    var image11: UIImage?
    var image12: UIImage?
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class PlayMusicItItem: TableAdapterItem {
  init(state: PlayMusicItItem.State) {
    let cellData =  PlayMusicItCellData(state: state)
    super.init(cellClass: PlayMusicItCell.self, cellData: cellData)
  }
}

// MARK: - Data

class PlayMusicItCellData: TableAdapterCellData {

  var state: PlayMusicItItem.State

  init(state: PlayMusicItItem.State) {
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
    return 706.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class PlayMusicItCell: TableAdapterCell {
  
  public var data: PlayMusicItCellData?
  
  @IBOutlet private weak var firstImageView: UIImageView?
  @IBOutlet private weak var subtitleLabel: UILabel?
  @IBOutlet private weak var label2: UILabel?
  @IBOutlet private weak var imageView3: UIImageView?
  @IBOutlet private weak var imageView4: UIImageView?
  @IBOutlet private weak var imageView5: UIImageView?
  @IBOutlet private weak var imageView6: UIImageView?
  @IBOutlet private weak var imageView7: UIImageView?
  @IBOutlet private weak var imageView8: UIImageView?
  @IBOutlet private weak var imageView9: UIImageView?
  @IBOutlet private weak var imageView10: UIImageView?
  @IBOutlet private weak var imageView11: UIImageView?
  @IBOutlet private weak var imageView12: UIImageView?
  
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
    guard let data = data as? PlayMusicItCellData else { return }
    self.data = data
    if let v = data.state.firstImage { firstImageView?.image = v }
    if let v = data.state.subtitleText { subtitleLabel?.text = v }
    if let v = data.state.text2 { label2?.text = v }
    if let v = data.state.image3 { imageView3?.image = v }
    if let v = data.state.image4 { imageView4?.image = v }
    if let v = data.state.image5 { imageView5?.image = v }
    if let v = data.state.image6 { imageView6?.image = v }
    if let v = data.state.image7 { imageView7?.image = v }
    if let v = data.state.image8 { imageView8?.image = v }
    if let v = data.state.image9 { imageView9?.image = v }
    if let v = data.state.image10 { imageView10?.image = v }
    if let v = data.state.image11 { imageView11?.image = v }
    if let v = data.state.image12 { imageView12?.image = v }
    
  }
}