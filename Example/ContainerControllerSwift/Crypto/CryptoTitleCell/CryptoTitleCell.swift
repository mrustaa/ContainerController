import UIKit
import ContainerControllerSwift

// MARK: - State

extension CryptoTitleItem {
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
    var image12: UIImage?
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class CryptoTitleItem: TableAdapterItem {
  init(state: CryptoTitleItem.State) {
    let cellData =  CryptoTitleCellData(state: state)
    super.init(cellClass: CryptoTitleCell.self, cellData: cellData)
  }
}

// MARK: - Data

class CryptoTitleCellData: TableAdapterCellData {

  var state: CryptoTitleItem.State

  init(state: CryptoTitleItem.State) {
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
    return 296.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class CryptoTitleCell: TableAdapterCell {
  
  public var data: CryptoTitleCellData?
  
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
    guard let data = data as? CryptoTitleCellData else { return }
    self.data = data
//    titleLabel?.text = data.state.titleText
//    subtitleLabel?.text = data.state.subtitleText
//    label2?.text = data.state.text2
//    label3?.text = data.state.text3
//    label4?.text = data.state.text4
//    label5?.text = data.state.text5
//    label6?.text = data.state.text6
//    label7?.text = data.state.text7
//    label8?.text = data.state.text8
//    label9?.text = data.state.text9
//    label10?.text = data.state.text10
//    label11?.text = data.state.text11
    imageView12?.image = data.state.image12
    
  }
}
