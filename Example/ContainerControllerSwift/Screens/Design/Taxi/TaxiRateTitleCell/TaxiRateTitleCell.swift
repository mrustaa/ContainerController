import UIKit
import ContainerControllerSwift

// MARK: - State

extension TaxiRateTitleItem {
  struct State {
    var titleText: String?
    var subtitleText: String?
    var image2: UIImage?
    var image3: UIImage?
    var image4: UIImage?
    var image5: UIImage?
    var image6: UIImage?
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class TaxiRateTitleItem: TableAdapterItem {
  init(state: TaxiRateTitleItem.State) {
    let cellData =  TaxiRateTitleCellData(state: state)
    super.init(cellClass: TaxiRateTitleCell.self, cellData: cellData)
  }
}

// MARK: - Data

class TaxiRateTitleCellData: TableAdapterCellData {

  var state: TaxiRateTitleItem.State

  init(state: TaxiRateTitleItem.State) {
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
    return 169.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class TaxiRateTitleCell: TableAdapterCell {
  
  public var data: TaxiRateTitleCellData?
  
  @IBOutlet private weak var titleLabel: UILabel?
  @IBOutlet private weak var subtitleLabel: UILabel?
  @IBOutlet private weak var imageView2: UIImageView?
  @IBOutlet private weak var imageView3: UIImageView?
  @IBOutlet private weak var imageView4: UIImageView?
  @IBOutlet private weak var imageView5: UIImageView?
  @IBOutlet private weak var imageView6: UIImageView?
  
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
    guard let data = data as? TaxiRateTitleCellData else { return }
    self.data = data
    if let v = data.state.titleText { titleLabel?.text = v }
    if let v = data.state.subtitleText { subtitleLabel?.text = v }
    if let v = data.state.image2 { imageView2?.image = v }
    if let v = data.state.image3 { imageView3?.image = v }
    if let v = data.state.image4 { imageView4?.image = v }
    if let v = data.state.image5 { imageView5?.image = v }
    if let v = data.state.image6 { imageView6?.image = v }
    
  }
}