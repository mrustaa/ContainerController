import UIKit
import ContainerControllerSwift

// MARK: - State

extension SportTagFilterItem {
  struct State: Equatable {
    var titleText: String?
    
  }
}

// MARK: - Item

class SportTagFilterItem: CollectionAdapterItem {

  init(state: SportTagFilterItem.State,
       clickCallback: (() -> ())? = nil) {

    let cellData =  SportTagFilterCellData(state: state,
                                  clickCallback: clickCallback)
    super.init(cellClass: SportTagFilterCell.self, cellData: cellData)
  }
}

// MARK: - Data

class SportTagFilterCellData: CollectionAdapterCellData {

  // MARK: Properties
  var state: SportTagFilterItem.State
  public var clickCallback: (() -> Void)?
  
  // MARK: Inits
  init(state: SportTagFilterItem.State,
       clickCallback: (() -> ())?) {
     self.state = state

     self.clickCallback = clickCallback
     super.init()
 }
  
 override public func size() -> CGSize {
     return CGSize(width: 101.0, height: 54.0)
 }
}

// MARK: - Cell

class SportTagFilterCell: CollectionAdapterCell {
  
  // MARK: Properties
  
  public var data: SportTagFilterCellData?
  
  // MARK: Outlets
  
  @IBOutlet private weak var titleLabel: UILabel?
    
  
  // MARK: Initialize
  
 override func awakeFromNib() { }
 
 override func fill(data: Any?) {
     guard let data = data as? SportTagFilterCellData else { return }
     self.data = data

     if let v = data.state.titleText { titleLabel?.text = v }
        
  }
}