import UIKit
import ContainerControllerSwift

// MARK: - State

extension MapParkingTgItem {
  struct State: Equatable {
    var firstImage: UIImage?
    
  }
}

// MARK: - Item

class MapParkingTgItem: CollectionAdapterItem {

  init(state: MapParkingTgItem.State,
       clickCallback: (() -> ())? = nil) {

    let cellData =  MapParkingTgCellData(state: state,
                                  clickCallback: clickCallback)
    super.init(cellClass: MapParkingTgCell.self, cellData: cellData)
  }
}

// MARK: - Data

class MapParkingTgCellData: CollectionAdapterCellData {

  // MARK: Properties
  var state: MapParkingTgItem.State
  public var clickCallback: (() -> Void)?
  
  // MARK: Inits
  init(state: MapParkingTgItem.State,
       clickCallback: (() -> ())?) {
     self.state = state

     self.clickCallback = clickCallback
     super.init()
 }
  
 override public func size() -> CGSize {
     return CGSize(width: 124.0, height: 96.0)
 }
}

// MARK: - Cell

class MapParkingTgCell: CollectionAdapterCell {
  
  // MARK: Properties
  
  public var data: MapParkingTgCellData?
  
    @IBOutlet var ccardView: DesignFigure!
    // MARK: Outlets
  
  @IBOutlet private weak var firstImageView: UIImageView?
    
  
    @IBOutlet var button: UIButton!
    // MARK: Initialize
  
 override func awakeFromNib() {
     
     button?.tapHideAnimation(
        view: ccardView,
        type: .alpha(0.5),
        callback: { type in
            if type == .touchUpInside {
//                self?.data?.state.handlers.onClickAt?()
            }
        }
     )
 }
 
 override func fill(data: Any?) {
     guard let data = data as? MapParkingTgCellData else { return }
     self.data = data

     if let v = data.state.firstImage { firstImageView?.image = v }
        
  }
}
