import UIKit
import ContainerControllerSwift

// MARK: - State

extension CryptoDetailsItem {
  struct State {
    var titleText: String?
    var subtitleText: String?
    var text2: String?
    var text3: String?
    var text4: String?
    var text5: String?
    var text6: String?
    var text7: String?
    var text8: String?
    var text9: String?
    var text10: String?
    var text11: String?
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class CryptoDetailsItem: TableAdapterItem {
  init(state: CryptoDetailsItem.State) {
    let cellData =  CryptoDetailsCellData(state: state)
    super.init(cellClass: CryptoDetailsCell.self, cellData: cellData)
  }
}

// MARK: - Data

class CryptoDetailsCellData: TableAdapterCellData {

  var state: CryptoDetailsItem.State

  init(state: CryptoDetailsItem.State) {
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
    return 503.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class CryptoDetailsCell: TableAdapterCell {
  
  public var data: CryptoDetailsCellData?
  
  @IBOutlet private weak var titleLabel: UILabel?
  @IBOutlet private weak var subtitleLabel: UILabel?
  @IBOutlet private weak var label2: UILabel?
  @IBOutlet private weak var label3: UILabel?
  @IBOutlet private weak var label4: UILabel?
  @IBOutlet private weak var label5: UILabel?
  @IBOutlet private weak var label6: UILabel?
  @IBOutlet private weak var label7: UILabel?
  @IBOutlet private weak var label8: UILabel?
  @IBOutlet private weak var label9: UILabel?
  @IBOutlet private weak var label10: UILabel?
  @IBOutlet private weak var label11: UILabel?
  
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
    guard let data = data as? CryptoDetailsCellData else { return }
    self.data = data
    if let v = data.state.titleText { titleLabel?.text = v }
    if let v = data.state.subtitleText { subtitleLabel?.text = v }
    if let v = data.state.text2 { label2?.text = v }
    if let v = data.state.text3 { label3?.text = v }
    if let v = data.state.text4 { label4?.text = v }
    if let v = data.state.text5 { label5?.text = v }
    if let v = data.state.text6 { label6?.text = v }
    if let v = data.state.text7 { label7?.text = v }
    if let v = data.state.text8 { label8?.text = v }
    if let v = data.state.text9 { label9?.text = v }
    if let v = data.state.text10 { label10?.text = v }
    if let v = data.state.text11 { label11?.text = v }
    
  }
}
