import UIKit
import ContainerControllerSwift

// MARK: - State

extension SportCatalogFilterItem {
    struct State {
        var titleText: String?
        var alpha: CGFloat = 1.0
        var paddingTop: Double?
        var redColor: Bool = false
        var items: [CollectionAdapterItem]?
        var insets: CollectionAdapterInsets?
        var handlers: Handlers = .init()
    }
    struct Handlers {
        var onClickAt: (()->(Void))?
    }
}

// MARK: - Item

class SportCatalogFilterItem: TableAdapterItem {
  init(state: SportCatalogFilterItem.State) {
    let cellData =  SportCatalogFilterCellData(state: state)
    super.init(cellClass: SportCatalogFilterCell.self, cellData: cellData)
  }
}

// MARK: - Data

class SportCatalogFilterCellData: TableAdapterCellData {

  var state: SportCatalogFilterItem.State

  init(state: SportCatalogFilterItem.State) {
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
      if let top = self.state.paddingTop {
          return top
      }
    return Self.cHeight()
  }
  
  public static func cHeight() -> CGFloat  {
    return 80.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class SportCatalogFilterCell: TableAdapterCell {
  
  public var data: SportCatalogFilterCellData?
  
  @IBOutlet private weak var titleLabel: UILabel?
  
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
    guard let data = data as? SportCatalogFilterCellData else { return }
    self.data = data
    if let v = data.state.titleText { titleLabel?.text = v }
    
      collectionView.alpha = data.state.alpha
      
      
    if let items = data.state.items {
         collectionView.set(items: items)
    }
    
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = data.state.insets?.scrollDirection ?? .horizontal
    if let v = data.state.insets?.minSpacing.cell { layout.minimumInteritemSpacing = v }
    if let v = data.state.insets?.minSpacing.line { layout.minimumLineSpacing = v }
    if let v = data.state.insets?.insets { layout.sectionInset = v }
    
    collectionView.collectionViewLayout = layout
  }
}
