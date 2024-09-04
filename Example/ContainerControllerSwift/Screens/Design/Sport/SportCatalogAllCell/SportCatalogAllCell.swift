import UIKit
import ContainerControllerSwift

// MARK: - State

extension SportCatalogAllItem {
  struct State {
    var titleText: String?
    var subtitleText: String?
    var image2: UIImage?
    var text3: String?
    var text4: String?
    var image5: UIImage?
    var text6: String?
    var text7: String?
    var image8: UIImage?
    var text9: String?
    var text10: String?
    var image11: UIImage?
    
      var alpha: CGFloat = 1.0
var items: [CollectionAdapterItem]?
var insets: CollectionAdapterInsets?
var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class SportCatalogAllItem: TableAdapterItem {
  init(state: SportCatalogAllItem.State) {
    let cellData =  SportCatalogAllCellData(state: state)
    super.init(cellClass: SportCatalogAllCell.self, cellData: cellData)
  }
}

// MARK: - Data

class SportCatalogAllCellData: TableAdapterCellData {

  var state: SportCatalogAllItem.State

  init(state: SportCatalogAllItem.State) {
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
    return 480.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class SportCatalogAllCell: TableAdapterCell {
  
  public var data: SportCatalogAllCellData?
  
  @IBOutlet private weak var titleLabel: UILabel?
  @IBOutlet private weak var subtitleLabel: UILabel?
  @IBOutlet private weak var imageView2: UIImageView?
  @IBOutlet private weak var label3: UILabel?
  @IBOutlet private weak var label4: UILabel?
  @IBOutlet private weak var imageView5: UIImageView?
  @IBOutlet private weak var label6: UILabel?
  @IBOutlet private weak var label7: UILabel?
  @IBOutlet private weak var imageView8: UIImageView?
  @IBOutlet private weak var label9: UILabel?
  @IBOutlet private weak var label10: UILabel?
  @IBOutlet private weak var imageView11: UIImageView?
  
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
    guard let data = data as? SportCatalogAllCellData else { return }
    self.data = data
    if let v = data.state.titleText { titleLabel?.text = v }
    if let v = data.state.subtitleText { subtitleLabel?.text = v }
    if let v = data.state.image2 { imageView2?.image = v }
    if let v = data.state.text3 { label3?.text = v }
    if let v = data.state.text4 { label4?.text = v }
    if let v = data.state.image5 { imageView5?.image = v }
    if let v = data.state.text6 { label6?.text = v }
    if let v = data.state.text7 { label7?.text = v }
    if let v = data.state.image8 { imageView8?.image = v }
    if let v = data.state.text9 { label9?.text = v }
    if let v = data.state.text10 { label10?.text = v }
    if let v = data.state.image11 { imageView11?.image = v }
    

      
      collectionView.alpha = data.state.alpha
      
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
