import UIKit
import ContainerControllerSwift

// MARK: - State

extension TaxiAddressABItem {
  struct State {
    var titleText: String?
    var subtitleText: String?
    var edit: String?
      var time: String?
    var image3: UIImage?
    var image4: UIImage?
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class TaxiAddressABItem: TableAdapterItem {
  init(state: TaxiAddressABItem.State) {
    let cellData =  TaxiAddressABCellData(state: state)
    super.init(cellClass: TaxiAddressABCell.self, cellData: cellData)
  }
}

// MARK: - Data

class TaxiAddressABCellData: TableAdapterCellData {

  var state: TaxiAddressABItem.State

  init(state: TaxiAddressABItem.State) {
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
    return 65.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class TaxiAddressABCell: TableAdapterCell {
  
  public var data: TaxiAddressABCellData?
  
  @IBOutlet private weak var titleLabel: UILabel?
  @IBOutlet private weak var subtitleLabel: UILabel?
  @IBOutlet private weak var label2: UILabel?
  @IBOutlet private weak var imageView3: UIImageView?
    
    @IBOutlet var abView: UIView!
  
    @IBOutlet var rightEditButton: UIView!
    @IBOutlet var rightTimeLabel: UILabel!
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
    guard let data = data as? TaxiAddressABCellData else { return }
    self.data = data
      if let v = data.state.titleText  { label2?.text = v }
    if let v = data.state.subtitleText { subtitleLabel?.text = v }
    if let v = data.state.image3 { imageView3?.image = v }
      
      
      
      if let v = data.state.edit { titleLabel?.text = v; rightEditButton.isHidden = false } else  { rightEditButton.isHidden = true }
      if let v = data.state.time { rightTimeLabel?.text = v; rightTimeLabel.isHidden = false } else  { rightTimeLabel.isHidden = true }
    
  }
}
