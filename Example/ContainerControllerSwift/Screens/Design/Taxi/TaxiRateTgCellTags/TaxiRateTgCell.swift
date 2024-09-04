import UIKit
import ContainerControllerSwift

// MARK: - State

extension TaxiRateTgItem {
  struct State {
    
var items: [CollectionAdapterItem]?
var insets: CollectionAdapterInsets?
var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class TaxiRateTgItem: TableAdapterItem {
  init(state: TaxiRateTgItem.State) {
    let cellData =  TaxiRateTgCellData(state: state)
    super.init(cellClass: TaxiRateTgCell.self, cellData: cellData)
  }
}

// MARK: - Data

class TaxiRateTgCellData: TableAdapterCellData {

  var state: TaxiRateTgItem.State

  init(state: TaxiRateTgItem.State) {
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
    return 111.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class TaxiRateTgCell: TableAdapterCell {
  
  public var data: TaxiRateTgCellData?
  
  
  @IBOutlet override var selectedView: UIView? { didSet { } }
  @IBOutlet var cardView: UIView?
  @IBOutlet var button: UIButton?
  
  @IBOutlet var collectionView: CollectionAdapterView!

  override func awakeFromNib() {

    separator(hide: true)

     collectionView.selectIndexCallback = { index in

     }

//    button?.tapHideAnimation(
//      view: cardView,
//      type: .alpha(0.5),
//      callback: { [weak self] type in
//        if type == .touchUpInside {
//          self?.data?.state.handlers.onClickAt?()
//        }
//      }
//    )
  }
  
  override func fill(data: TableAdapterCellData?) {
    guard let data = data as? TaxiRateTgCellData else { return }
    self.data = data
    

      
    if let items = data.state.items {
         collectionView.set(items: items)
    }
    
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    if let v = data.state.insets?.minSpacing.cell { layout.minimumInteritemSpacing = v }
    if let v = data.state.insets?.minSpacing.line { layout.minimumLineSpacing = v }
    if let v = data.state.insets?.insets { layout.sectionInset = v }
    
    collectionView.collectionViewLayout = layout
  }
}
