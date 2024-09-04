import UIKit
import ContainerControllerSwift

// MARK: - State

extension SportCatalogOneItem {
  struct State {
      var fav: Bool = false
    var secondImage: UIImage?
    var text2: String?
    var text3: String?
    var image4: UIImage?
      var handlers: Handlers = .init()
  }
    struct Handlers {
        var onClickAt: (()->(Void))?
    }
}

// MARK: - Item

class SportCatalogOneItem: CollectionAdapterItem {

  init(state: SportCatalogOneItem.State,
       clickCallback: (() -> ())? = nil) {

    let cellData =  SportCatalogOneCellData(state: state,
                                  clickCallback: clickCallback)
    super.init(cellClass: SportCatalogOneCell.self, cellData: cellData)
  }
}

// MARK: - Data

class SportCatalogOneCellData: CollectionAdapterCellData {

  // MARK: Properties
  var state: SportCatalogOneItem.State
  public var clickCallback: (() -> Void)?
  
  // MARK: Inits
  init(state: SportCatalogOneItem.State,
       clickCallback: (() -> ())?) {
     self.state = state

     self.clickCallback = clickCallback
     super.init()
 }
  
 override public func size() -> CGSize {
     return CGSize(width: 148.0, height: 220.0)
 }
}

// MARK: - Cell

class SportCatalogOneCell: CollectionAdapterCell {
  
  // MARK: Properties
  
  public var data: SportCatalogOneCellData?
  
  // MARK: Outlets
  
  @IBOutlet private weak var firstImageView: UIImageView?
    @IBOutlet private weak var secondImageView: UIImageView?
    @IBOutlet private weak var label2: UILabel?
    @IBOutlet private weak var label3: UILabel?
    @IBOutlet private weak var imageView4: UIImageView?
    @IBOutlet var cardView: DesignFigure!
    
    @IBOutlet var button: UIButton!
    
  // MARK: Initialize
  
 override func awakeFromNib() { 
     
     button?.tapHideAnimation(
        view: cardView,
        type: .layerGray(0.15),
        callback: { [weak self] type in
            if type == .touchUpInside {
                self?.data?.state.handlers.onClickAt?()
            }
        }
     )
     
 }
 
 override func fill(data: Any?) {
     guard let data = data as? SportCatalogOneCellData else { return }
     self.data = data

     let imgg11  =   #imageLiteral(resourceName: "iconSportCatalogFavorite")
     let imgg12  =   #imageLiteral(resourceName: "iconSportCatalogFavoriteFull")
     
     if data.state.fav {
         secondImageView?.image = imgg12
     } else {
         
         secondImageView?.image = imgg11
     }
     
//     if let v = data.state.firstImage { firstImageView?.image = v }
        if let v = data.state.secondImage { imageView4?.image = v }
        if let v = data.state.text2 { label2?.text = v }
        if let v = data.state.text3 { label3?.text = v }
//        if let v = data.state.image4 { imageView4?.image = v }
        
  }
}
