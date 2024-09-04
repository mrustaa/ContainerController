import UIKit
import ContainerControllerSwift

// MARK: - State

extension TaxiCollectionCarsItem {
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

class TaxiCollectionCarsItem: TableAdapterItem {
  init(state: TaxiCollectionCarsItem.State) {
    let cellData =  TaxiCollectionCarsCellData(state: state)
    super.init(cellClass: TaxiCollectionCarsCell.self, cellData: cellData)
  }
}

// MARK: - Data

class TaxiCollectionCarsCellData: TableAdapterCellData {

  var state: TaxiCollectionCarsItem.State

  init(state: TaxiCollectionCarsItem.State) {
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
    return 191.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class TaxiCollectionCarsCell: TableAdapterCell {
  
    @IBOutlet var separator1: NSLayoutConstraint!
    @IBOutlet var separator2: NSLayoutConstraint!
    public var data: TaxiCollectionCarsCellData?
  
  @IBOutlet override var selectedView: UIView? { didSet { } }
  @IBOutlet var cardView: UIView?
  @IBOutlet var button: UIButton?
    
    @IBOutlet var collectionView: CollectionAdapterView!
  
  override func awakeFromNib() {
      
      separator1.constant = 0.5
      separator2.constant = 0.5
      
      collectionView.selectIndexCallback = { index in
          
      }
      
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
    guard let data = data as? TaxiCollectionCarsCellData else { return }
    self.data = data
//      items.removeAll()
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
