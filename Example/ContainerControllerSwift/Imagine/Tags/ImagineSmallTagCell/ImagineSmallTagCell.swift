import UIKit
import ContainerControllerSwift

// MARK: - State

extension ImagineSmallTagItem {
  struct State: Equatable {
    
      var image3: UIImage?
  }
}

// MARK: - Item

class ImagineSmallTagItem: CollectionAdapterItem {

  init(state: ImagineSmallTagItem.State,
       clickCallback: (() -> ())? = nil) {

    let cellData =  ImagineSmallTagCellData(state: state,
                                  clickCallback: clickCallback)
    super.init(cellClass: ImagineSmallTagCell.self, cellData: cellData)
  }
}

// MARK: - Data

class ImagineSmallTagCellData: CollectionAdapterCellData {

  // MARK: Properties
  var state: ImagineSmallTagItem.State
  public var clickCallback: (() -> Void)?
  
  // MARK: Inits
  init(state: ImagineSmallTagItem.State,
       clickCallback: (() -> ())?) {
     self.state = state

     self.clickCallback = clickCallback
     super.init()
 }
  
 override public func size() -> CGSize {
     return CGSize(width: 64.0, height: 64.0)
 }
}

// MARK: - Cell

class ImagineSmallTagCell: CollectionAdapterCell {
  
  // MARK: Properties
  
    @IBOutlet var imageeView: UIImageView!
    public var data: ImagineSmallTagCellData?
  
    @IBOutlet var button: UIButton!
    // MARK: Outlets
  
  
  
  // MARK: Initialize
  
 override func awakeFromNib() { }
 
 override func fill(data: Any?) {
     guard let data = data as? ImagineSmallTagCellData else { return }
     self.data = data

     imageeView.image = data.state.image3
  }
}
