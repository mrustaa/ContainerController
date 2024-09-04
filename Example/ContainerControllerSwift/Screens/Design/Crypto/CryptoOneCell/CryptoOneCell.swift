import UIKit
import ContainerControllerSwift

// MARK: - State

extension CryptoOneItem {
  struct State {
    var firstImage: UIImage?
      var color: UIColor?
    var subtitleText: String?
    var text2: String?
    var text3: String?
    var text4: String?
    var text5: String?
    var image6: UIImage?
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class CryptoOneItem: TableAdapterItem {
  init(state: CryptoOneItem.State) {
    let cellData =  CryptoOneCellData(state: state)
    super.init(cellClass: CryptoOneCell.self, cellData: cellData)
  }
}

// MARK: - Data

class CryptoOneCellData: TableAdapterCellData {

  var state: CryptoOneItem.State

  init(state: CryptoOneItem.State) {
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

class CryptoOneCell: TableAdapterCell {
  
  public var data: CryptoOneCellData?
  
  @IBOutlet private weak var firstImageView: UIImageView?
  @IBOutlet private weak var subtitleLabel: UILabel?
    @IBOutlet var ccardView: DesignFigure!
    @IBOutlet private weak var label2: UILabel?
  @IBOutlet private weak var label3: UILabel?
  @IBOutlet private weak var label4: UILabel?
  @IBOutlet private weak var label5: UILabel?
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
    guard let data = data as? CryptoOneCellData else { return }
    self.data = data
    if let v = data.state.firstImage { firstImageView?.image = v }
    if let v = data.state.subtitleText { subtitleLabel?.text = v }
    if let v = data.state.text2 { label2?.text = v }
    if let v = data.state.text3 { label3?.text = v }
    if let v = data.state.text4 { label4?.text = v }
    if let v = data.state.text5 { label5?.text = v }
    if let v = data.state.image6 { imageView6?.image = v }
    
      
      self.ccardView.fillColor = data.state.color ?? .orange
      self.ccardView.layoutSubviews()
      self.ccardView.layoutIfNeeded()
//      self.ccardView.setup()
  }
}
