import UIKit
import ContainerControllerSwift

// MARK: - State

extension TaxiRateAvatarItem {
  struct State {
    var firstImage: UIImage?
    var subtitleText: String?
    var image2: UIImage?
    var text3: String?
    var text4: String?
    var text5: String?
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class TaxiRateAvatarItem: TableAdapterItem {
  init(state: TaxiRateAvatarItem.State) {
    let cellData =  TaxiRateAvatarCellData(state: state)
    super.init(cellClass: TaxiRateAvatarCell.self, cellData: cellData)
  }
}

// MARK: - Data

class TaxiRateAvatarCellData: TableAdapterCellData {

  var state: TaxiRateAvatarItem.State

  init(state: TaxiRateAvatarItem.State) {
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
    return 100.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class TaxiRateAvatarCell: TableAdapterCell {
  
  public var data: TaxiRateAvatarCellData?
  
  @IBOutlet private weak var firstImageView: UIImageView?
  @IBOutlet private weak var subtitleLabel: UILabel?
  @IBOutlet private weak var imageView2: UIImageView?
  @IBOutlet private weak var label3: UILabel?
  @IBOutlet private weak var label4: UILabel?
  @IBOutlet private weak var label5: UILabel?
  
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
    guard let data = data as? TaxiRateAvatarCellData else { return }
    self.data = data
    if let v = data.state.firstImage { firstImageView?.image = v }
    if let v = data.state.subtitleText { subtitleLabel?.text = v }
    if let v = data.state.image2 { imageView2?.image = v }
    if let v = data.state.text3 { label3?.text = v }
    if let v = data.state.text4 { label4?.text = v }
    if let v = data.state.text5 { label5?.text = v }
    
  }
}