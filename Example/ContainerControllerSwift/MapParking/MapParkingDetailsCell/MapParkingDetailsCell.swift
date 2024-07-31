import UIKit
import ContainerControllerSwift

// MARK: - State

extension MapParkingDetailsItem {
  struct State {
    var firstImage: UIImage?
    var subtitleText: String?
    var text2: String?
    var text3: String?
    var text4: String?
    var text5: String?
    var text6: String?
    var text7: String?
    var text8: String?
    var text9: String?
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class MapParkingDetailsItem: TableAdapterItem {
  init(state: MapParkingDetailsItem.State) {
    let cellData =  MapParkingDetailsCellData(state: state)
    super.init(cellClass: MapParkingDetailsCell.self, cellData: cellData)
  }
}

// MARK: - Data

class MapParkingDetailsCellData: TableAdapterCellData {

  var state: MapParkingDetailsItem.State

  init(state: MapParkingDetailsItem.State) {
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
    return 702.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class MapParkingDetailsCell: TableAdapterCell {
  
  public var data: MapParkingDetailsCellData?
  
  @IBOutlet private weak var firstImageView: UIImageView?
  @IBOutlet private weak var subtitleLabel: UILabel?
  @IBOutlet private weak var label2: UILabel?
  @IBOutlet private weak var label3: UILabel?
  @IBOutlet private weak var label4: UILabel?
  @IBOutlet private weak var label5: UILabel?
  @IBOutlet private weak var label6: UILabel?
  @IBOutlet private weak var label7: UILabel?
  @IBOutlet private weak var label8: UILabel?
  @IBOutlet private weak var label9: UILabel?
  
  @IBOutlet override var selectedView: UIView? { didSet { } }
  @IBOutlet var cardView: UIView?
    
    @IBOutlet var cardView2: DesignFigure!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var cardView1: DesignFigure!
    @IBOutlet var btn1: UIButton!
    @IBOutlet var bottomBtnView: UIView!
    @IBOutlet var button: UIButton?
  
  override func awakeFromNib() {
      
      bottomBtnView.layer.cornerRadius  = 24
      
    separator(hide: true)
    button?.tapHideAnimation(
      view: bottomBtnView,
      type: .layerGray(0.25),
      callback: {    type in
        if type == .touchUpInside {
        }
      }
    )
      
      btn2?.tapHideAnimation(
        view: cardView2,
        type: .layerGray(0.15),
        callback: {   type in
            if type == .touchUpInside {
            }
        }
      )
      btn1?.tapHideAnimation(
        view: cardView1,
        type: .layerGray(0.15),
        callback: {    type in
            if type == .touchUpInside {
            }
        }
      )
  }
  
  override func fill(data: TableAdapterCellData?) {
    guard let data = data as? MapParkingDetailsCellData else { return }
    self.data = data
    if let v = data.state.firstImage { firstImageView?.image = v }
    if let v = data.state.subtitleText { subtitleLabel?.text = v }
    if let v = data.state.text2 { label2?.text = v }
    if let v = data.state.text3 { label3?.text = v }
    if let v = data.state.text4 { label4?.text = v }
    if let v = data.state.text5 { label5?.text = v }
    if let v = data.state.text6 { label6?.text = v }
    if let v = data.state.text7 { label7?.text = v }
    if let v = data.state.text8 { label8?.text = v }
    if let v = data.state.text9 { label9?.text = v }
    
  }
}
