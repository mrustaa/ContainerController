import UIKit
import ContainerControllerSwift

// MARK: - State

extension CryptoAmountItem {
  struct State {
    var titleText: String?
    var subtitleText: String?
    var text2: String?
    var text3: String?
      var color: UIColor?
      var img: UIImage?
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class CryptoAmountItem: TableAdapterItem {
  init(state: CryptoAmountItem.State) {
    let cellData =  CryptoAmountCellData(state: state)
    super.init(cellClass: CryptoAmountCell.self, cellData: cellData)
  }
}

// MARK: - Data

class CryptoAmountCellData: TableAdapterCellData {

  var state: CryptoAmountItem.State

  init(state: CryptoAmountItem.State) {
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
    return 93.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class CryptoAmountCell: TableAdapterCell {
  
  public var data: CryptoAmountCellData?
  
    @IBOutlet var imgFill: DesignnView!
    @IBOutlet var imgIcon: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel?
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
    guard let data = data as? CryptoAmountCellData else { return }
    self.data = data
      
      imgFill.fillColor = data.state.color
      imgFill.layoutSubviews()
      
      imgIcon.image = data.state.img
      
      
    if let v = data.state.titleText { titleLabel?.text = v }
    if let v = data.state.subtitleText { subtitleLabel?.text = v }
    if let v = data.state.text2 { label2?.text = v }
    if let v = data.state.text3 { label3?.text = v }
    
  }
}
