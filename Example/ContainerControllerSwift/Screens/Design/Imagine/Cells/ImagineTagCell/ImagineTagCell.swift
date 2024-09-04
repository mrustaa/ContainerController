import UIKit
import ContainerControllerSwift

// MARK: - State

extension ImagineTagItem {
  struct State {
    var handlers: Handlers = .init()
  }
  struct Handlers {
    var onClickAt: (()->(Void))?
  }
}

// MARK: - Item

class ImagineTagItem: TableAdapterItem {
  init(state: ImagineTagItem.State) {
    let cellData =  ImagineTagCellData(state: state)
    super.init(cellClass: ImagineTagCell.self, cellData: cellData)
  }
}

// MARK: - Data

class ImagineTagCellData: TableAdapterCellData {

  var state: ImagineTagItem.State

  init(state: ImagineTagItem.State) {
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
    return 74.0
  }

  override public func canEditing() -> Bool {
    return editing
  }
}

// MARK: - Cell

class ImagineTagCell: TableAdapterCell {
  
  public var data: ImagineTagCellData?
  
  
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
    guard let data = data as? ImagineTagCellData else { return }
    self.data = data
    
      let iconImagineCamera = #imageLiteral(resourceName: "iconImagineCamera")
      let iconImagineAlien = #imageLiteral(resourceName: "iconImagineAlien")
      let iconImagineStar = #imageLiteral(resourceName: "iconImagineStar")
      let iconImagineWeb = #imageLiteral(resourceName: "iconImagineWeb")
      let iconImagineTravel = #imageLiteral(resourceName: "iconImagineTravel")
      
      items.removeAll()
      items.append( ImagineBigTagItem(state: .init(titleText: "People", image3: iconImagineTravel)) )
      items.append( ImagineSmallTagItem(state: .init(image3: iconImagineCamera)) )
      items.append( ImagineSmallTagItem(state: .init(image3: iconImagineWeb)) )
      items.append( ImagineSmallTagItem(state: .init(image3: iconImagineStar)) )
      items.append( ImagineSmallTagItem(state: .init(image3: iconImagineAlien)) )
      items.append( ImagineSmallTagItem(state: .init(image3: iconImagineCamera)) )
      
      collectionView.set(items: items)
      
  }
}
