import UIKit
import ContainerControllerSwift

// MARK: - State

extension MapParkingMiniItem {
  struct State {
    var titleText: String?
    var secondImage: UIImage?
    var image2: UIImage?
    var image3: UIImage?
    var text4: String?
    var text5: String?

      var items: [CollectionAdapterItem]?
      var insets: CollectionAdapterInsets?
      var handlers: Handlers = .init()
  }
    struct Handlers {
        var onClickAt: (()->(Void))?
    }
}

// MARK: - Item

class MapParkingMiniItem: TableAdapterItem {
  init(state: MapParkingMiniItem.State) {
    let cellData =  MapParkingMiniCellData(state: state)
    super.init(cellClass: MapParkingMiniCell.self, cellData: cellData)
  }
}

// MARK: - Data

class MapParkingMiniCellData: TableAdapterCellData {

  var state: MapParkingMiniItem.State

  init(state: MapParkingMiniItem.State) {
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
    return 258.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class MapParkingMiniCell: TableAdapterCell {
  
  public var data: MapParkingMiniCellData?
  
  @IBOutlet private weak var titleLabel: UILabel?
  @IBOutlet private weak var secondImageView: UIImageView?
  @IBOutlet private weak var imageView2: UIImageView?
  @IBOutlet private weak var imageView3: UIImageView?
  @IBOutlet private weak var label4: UILabel?
  @IBOutlet private weak var label5: UILabel?
  
    @IBOutlet var collectionView: CollectionAdapterView!
    
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
    guard let data = data as? MapParkingMiniCellData else { return }
    self.data = data
    if let v = data.state.titleText { titleLabel?.text = v }
    if let v = data.state.secondImage { secondImageView?.image = v }
    if let v = data.state.image2 { imageView2?.image = v }
    if let v = data.state.image3 { imageView3?.image = v }
    if let v = data.state.text4 { label4?.text = v }
    if let v = data.state.text5 { label5?.text = v }
      
      
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
