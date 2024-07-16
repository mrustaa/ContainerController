import UIKit
import ContainerControllerSwift

// MARK: - State

extension ImagineCollectionItem {
  struct State {
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class ImagineCollectionItem: TableAdapterItem {
  init(state: ImagineCollectionItem.State) {
    let cellData =  ImagineCollectionCellData(state: state)
    super.init(cellClass: ImagineCollectionCell.self, cellData: cellData)
  }
}

// MARK: - Data

class ImagineCollectionCellData: TableAdapterCellData {

  var state: ImagineCollectionItem.State

  init(state: ImagineCollectionItem.State) {
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
    return 320.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class ImagineCollectionCell: TableAdapterCell {
  
  public var data: ImagineCollectionCellData?
  
    var items: [CollectionAdapterItem] = []
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
    guard let data = data as? ImagineCollectionCellData else { return }
    self.data = data
    let greenColor =  #colorLiteral(red: 0.4862745098, green: 0.8823529412, blue: 0.8980392157, alpha: 1)
      let yaColor =  #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
      let imgImagine  = #imageLiteral(resourceName: "imgImagineGirls")
      
      items.removeAll()
      items.append( ImagineCollItem(state: .init(titleText: "Girls Fashion",subtitleText: "Smiley",text2: "Fashion",image3: imgImagine ) ) )
      items.append( ImagineCollItem(state: .init(titleText: "Girls Fashion",subtitleText: "Smiley",text2: "Fashion",image3: imgImagine , color1: greenColor, color2: greenColor) ) )
      items.append( ImagineCollItem(state: .init(titleText: "Girls Fashion",subtitleText: "Smiley",text2: "Fashion",image3: imgImagine , color1: yaColor , color2: yaColor  ) ) )
      
      collectionView.set(items: items)
  }
}
