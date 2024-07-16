import UIKit
import ContainerControllerSwift

// MARK: - State

extension WalletsContainerItemItem {
  struct State {
      
      var img: UIImage?
    var titleText: String?
    var subtitleText: String?
    var text2: String?
    var text3: String?
    var text4: String?
    var text5: String?
    var text6: String?
      var dark: Bool
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class WalletsContainerItemItem: TableAdapterItem {
  init(state: WalletsContainerItemItem.State) {
    let cellData =  WalletsContainerItemCellData(state: state)
    super.init(cellClass: WalletsContainerItemCell.self, cellData: cellData)
  }
}

// MARK: - Data

class WalletsContainerItemCellData: TableAdapterCellData {

  var state: WalletsContainerItemItem.State

  init(state: WalletsContainerItemItem.State) {
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
      return 167.0 + 6.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class WalletsContainerItemCell: TableAdapterCell {
  
  public var data: WalletsContainerItemCellData?
  
  @IBOutlet private weak var titleLabel: UILabel?
  @IBOutlet private weak var subtitleLabel: UILabel?
  @IBOutlet private weak var label2: UILabel?
  @IBOutlet private weak var label3: UILabel?
  @IBOutlet private weak var label4: UILabel?
  @IBOutlet private weak var label5: UILabel?
  @IBOutlet private weak var label6: UILabel?
    @IBOutlet var imgView: UIImageView!
    
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
    guard let data = data as? WalletsContainerItemCellData else { return }
    self.data = data
    titleLabel?.text = data.state.titleText
    subtitleLabel?.text = data.state.subtitleText
    label2?.text = data.state.text2
    label3?.text = data.state.text3
    label4?.text = data.state.text4
    label5?.text = data.state.text5
    label6?.text = data.state.text6
      
      
      imgView.image = data.state.img
      let colr : UIColor = data.state.dark ? .black : .white
      
      titleLabel?.textColor = colr
      subtitleLabel?.textColor = colr
      label2?.textColor = colr
      label3?.textColor = colr
      label4?.textColor = colr
      label5?.textColor = colr
//      label6?.textColor = colr / /
    
  }
}
