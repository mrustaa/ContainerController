import UIKit
import ContainerControllerSwift

// MARK: - State

extension ImagineBigTagItem {
  struct State: Equatable {
    var titleText: String?
    
      var image3: UIImage?
  }
}

// MARK: - Item

class ImagineBigTagItem: CollectionAdapterItem {

  init(state: ImagineBigTagItem.State,
       clickCallback: (() -> ())? = nil) {

    let cellData =  ImagineBigTagCellData(state: state,
                                  clickCallback: clickCallback)
    super.init(cellClass: ImagineBigTagCell.self, cellData: cellData)
  }
}

// MARK: - Data

class ImagineBigTagCellData: CollectionAdapterCellData {

  // MARK: Properties
  var state: ImagineBigTagItem.State
  public var clickCallback: (() -> Void)?
  
  // MARK: Inits
  init(state: ImagineBigTagItem.State,
       clickCallback: (() -> ())?) {
     self.state = state

     self.clickCallback = clickCallback
     super.init()
 }
  
 override public func size() -> CGSize {
     return CGSize(width: 158.0, height: 64.0)
 }
}

// MARK: - Cell

class ImagineBigTagCell: CollectionAdapterCell {
  
  // MARK: Properties
  
  public var data: ImagineBigTagCellData?
  
    @IBOutlet var button: UIButton!
    // MARK: Outlets
  
    @IBOutlet var imgVIew: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel?
    
  
  // MARK: Initialize
  
 override func awakeFromNib() { }
 
 override func fill(data: Any?) {
     guard let data = data as? ImagineBigTagCellData else { return }
     self.data = data

     titleLabel?.text = data.state.titleText
     imgVIew.image = data.state.image3
  }
}
