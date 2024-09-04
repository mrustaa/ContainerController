import UIKit
import ContainerControllerSwift

// MARK: - State

extension MyCardsAddonsItem {
  struct State: Equatable {
    var titleText: String?
    var subtitleText: String?
    
  }
}

// MARK: - Item

class MyCardsAddonsItem: CollectionAdapterItem {

  init(state: MyCardsAddonsItem.State,
       clickCallback: (() -> ())? = nil) {

    let cellData =  MyCardsAddonsCellData(state: state,
                                  clickCallback: clickCallback)
    super.init(cellClass: MyCardsAddonsCell.self, cellData: cellData)
  }
}

// MARK: - Data

class MyCardsAddonsCellData: CollectionAdapterCellData {

  // MARK: Properties
  var state: MyCardsAddonsItem.State
  public var clickCallback: (() -> Void)?
  
  // MARK: Inits
  init(state: MyCardsAddonsItem.State,
       clickCallback: (() -> ())?) {
     self.state = state

     self.clickCallback = clickCallback
     super.init()
 }
  
 override public func size() -> CGSize {
     return CGSize(width: 140.0, height: 56.0)
 }
}

// MARK: - Cell

class MyCardsAddonsCell: CollectionAdapterCell {
    @IBOutlet var button: UIButton!
    
  // MARK: Properties
  
  public var data: MyCardsAddonsCellData?
  
  // MARK: Outlets
  
  @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var subtitleLabel: UILabel?
    
  
  // MARK: Initialize
  
 override func awakeFromNib() { }
 
 override func fill(data: Any?) {
     guard let data = data as? MyCardsAddonsCellData else { return }
     self.data = data

     if let v = data.state.titleText { titleLabel?.text = v }
        if let v = data.state.subtitleText { subtitleLabel?.text = v }
        
  }
}
