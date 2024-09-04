import UIKit
import ContainerControllerSwift

// MARK: - State

extension MyCardsCollectionItem {
  struct State {
    var titleText: String?
    var subtitleText: String?
    var text2: String?
    var text3: String?
    var text4: String?
    var image5: UIImage?
    
      var alpha: CGFloat = 1.0
      
      
      var itemsUpdate: Bool? = true
      
var items: [CollectionAdapterItem]?
var insets: CollectionAdapterInsets?
var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class MyCardsCollectionItem: TableAdapterItem {
  init(state: MyCardsCollectionItem.State) {
    let cellData =  MyCardsCollectionCellData(state: state)
    super.init(cellClass: MyCardsCollectionCell.self, cellData: cellData)
  }
}

// MARK: - Data

class MyCardsCollectionCellData: TableAdapterCellData {

  var state: MyCardsCollectionItem.State

  init(state: MyCardsCollectionItem.State) {
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
    return 222.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class MyCardsCollectionCell: TableAdapterCell {
  
  public var data: MyCardsCollectionCellData?
  
  @IBOutlet private weak var titleLabel: UILabel?
  @IBOutlet private weak var subtitleLabel: UILabel?
  @IBOutlet private weak var label2: UILabel?
  @IBOutlet private weak var label3: UILabel?
  @IBOutlet private weak var label4: UILabel?
  @IBOutlet private weak var imageView5: UIImageView?
  
  @IBOutlet override var selectedView: UIView? { didSet { } }
  @IBOutlet var cardView: UIView?
  @IBOutlet var button: UIButton?
  
  @IBOutlet var collectionView: CollectionAdapterView!

  override func awakeFromNib() {

    separator(hide: true)

     collectionView.selectIndexCallback = { index in

     }

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
    guard let data = data as? MyCardsCollectionCellData else { return }
    self.data = data
    if let v = data.state.titleText { titleLabel?.text = v }
    if let v = data.state.subtitleText { subtitleLabel?.text = v }
    if let v = data.state.text2 { label2?.text = v }
    if let v = data.state.text3 { label3?.text = v }
    if let v = data.state.text4 { label4?.text = v }
    if let v = data.state.image5 { imageView5?.image = v }
    
      collectionView.alpha = data.state.alpha
      
      
//      if let itemsUpdate = data.state.itemsUpdate, itemsUpdate == true {
          
          if let items = data.state.items {
              collectionView.set(items: items, section: true)
          }
          self.data?.state.itemsUpdate = nil
//      }
    
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    if let v = data.state.insets?.minSpacing.cell { layout.minimumInteritemSpacing = v }
    if let v = data.state.insets?.minSpacing.line { layout.minimumLineSpacing = v }
    if let v = data.state.insets?.insets { layout.sectionInset = v }
    
    collectionView.collectionViewLayout = layout
  }
}
