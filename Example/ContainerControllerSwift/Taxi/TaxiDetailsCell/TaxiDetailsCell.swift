import UIKit
import ContainerControllerSwift

// MARK: - State

extension TaxiDetailsItem {
  struct State {
    var titleText: String?
    var secondImage: UIImage?
    var text2: String?
    var text3: String?
    var text4: String?
    var image5: UIImage?
    var text6: String?
    var text7: String?
    var text8: String?
    var text9: String?
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: ((Int)->(Void))?
  }
}
// MARK: - Item

class TaxiDetailsItem: TableAdapterItem {
  init(state: TaxiDetailsItem.State) {
    let cellData =  TaxiDetailsCellData(state: state)
    super.init(cellClass: TaxiDetailsCell.self, cellData: cellData)
  }
}

// MARK: - Data

class TaxiDetailsCellData: TableAdapterCellData {

  var state: TaxiDetailsItem.State

  init(state: TaxiDetailsItem.State) {
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
    return 331.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class TaxiDetailsCell: TableAdapterCell {
  
  public var data: TaxiDetailsCellData?
  
  @IBOutlet private weak var titleLabel: UILabel?
  @IBOutlet private weak var secondImageView: UIImageView?
  @IBOutlet private weak var label2: UILabel?
  @IBOutlet private weak var label3: UILabel?
  @IBOutlet private weak var label4: UILabel?
  @IBOutlet private weak var imageView5: UIImageView?
  @IBOutlet private weak var label6: UILabel?
  @IBOutlet private weak var label7: UILabel?
  @IBOutlet private weak var label8: UILabel?
  @IBOutlet private weak var label9: UILabel?
  
  @IBOutlet override var selectedView: UIView? { didSet { } }
  @IBOutlet var cardView: UIView?
  @IBOutlet var button: UIButton?
    
    @IBOutlet var cardView1: UIView?
    @IBOutlet var button1: UIButton?
    
    
    @IBOutlet var cardView2: UIView?
    @IBOutlet var button2: UIButton?
  
  override func awakeFromNib() {
    separator(hide: true)
      
    button?.tapHideAnimation(
      view: cardView,
      type: .layerGray(0.25),
      callback: { [weak self] type in
        if type == .touchUpInside {
          self?.data?.state.handlers.onClickAt?(0)
        }
      }
    )
      
      button1?.tapHideAnimation(
        view: cardView1,
        type: .layerGray(0.25),
        callback: { [weak self] type in
            if type == .touchUpInside {
                self?.data?.state.handlers.onClickAt?(1)
            }
        }
      )
      
      button2?.tapHideAnimation(
        view: cardView2,
        type: .layerGray(0.5),
        callback: { [weak self] type in
            if type == .touchUpInside {
                self?.data?.state.handlers.onClickAt?(1)
            }
        }
      )
  }
  
  override func fill(data: TableAdapterCellData?) {
    guard let data = data as? TaxiDetailsCellData else { return }
    self.data = data
    if let v = data.state.titleText { titleLabel?.text = v }
    if let v = data.state.secondImage { secondImageView?.image = v }
    if let v = data.state.text2 { label2?.text = v }
    if let v = data.state.text3 { label3?.text = v }
    if let v = data.state.text4 { label4?.text = v }
    if let v = data.state.image5 { imageView5?.image = v }
    if let v = data.state.text6 { label6?.text = v }
    if let v = data.state.text7 { label7?.text = v }
    if let v = data.state.text8 { label8?.text = v }
    if let v = data.state.text9 { label9?.text = v }
    
  }
}
