import UIKit
import ContainerControllerSwift

// MARK: - State

extension MyCardsAddCardItem {
  struct State: Equatable {
    
  }
}

// MARK: - Item

class MyCardsAddCardItem: CollectionAdapterItem {

  init(state: MyCardsAddCardItem.State,
       clickCallback: (() -> ())? = nil) {

    let cellData =  MyCardsAddCardCellData(state: state,
                                  clickCallback: clickCallback)
    super.init(cellClass: MyCardsAddCardCell.self, cellData: cellData)
  }
}

// MARK: - Data

class MyCardsAddCardCellData: CollectionAdapterCellData {

  // MARK: Properties
  var state: MyCardsAddCardItem.State
  public var clickCallback: (() -> Void)?
  
  // MARK: Inits
  init(state: MyCardsAddCardItem.State,
       clickCallback: (() -> ())?) {
     self.state = state

     self.clickCallback = clickCallback
     super.init()
 }
  
 override public func size() -> CGSize {
     return CGSize(width: 71.0, height: 185.0)
 }
}

// MARK: - Cell

class MyCardsAddCardCell: CollectionAdapterCell {
  
    @IBOutlet var button: UIButton!
    // MARK: Properties
  
  public var data: MyCardsAddCardCellData?
  
  // MARK: Outlets
  
  
  
  // MARK: Initialize
  
 override func awakeFromNib() { }
 
 override func fill(data: Any?) {
     guard let data = data as? MyCardsAddCardCellData else { return }
     self.data = data

     
  }
}
