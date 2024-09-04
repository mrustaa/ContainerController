import UIKit
import ContainerControllerSwift

// MARK: - State

extension PlayMusicTagFilterItem {
  struct State {
    var titleText: String?
    
     var handlers: Handlers = .init()
   }
   struct Handlers {
     var onClickAt: (()->(Void))?
    }
}

// MARK: - Item

class PlayMusicTagFilterItem: CollectionAdapterItem {

  init(state: PlayMusicTagFilterItem.State,
       clickCallback: (() -> ())? = nil) {

    let cellData =  PlayMusicTagFilterCellData(state: state,
                                  clickCallback: clickCallback)
    super.init(cellClass: PlayMusicTagFilterCell.self, cellData: cellData)
  }
}

// MARK: - Data

class PlayMusicTagFilterCellData: CollectionAdapterCellData {

  // MARK: Properties
  var state: PlayMusicTagFilterItem.State
  public var clickCallback: (() -> Void)?
  
  // MARK: Inits
  init(state: PlayMusicTagFilterItem.State,
       clickCallback: (() -> ())?) {
     self.state = state

     self.clickCallback = clickCallback
     super.init()
 }
  
 override public func size() -> CGSize {
     
     
     if let text = self.state.titleText {
         let w = sizeToFitLabel(text: text, font: UIFont.mediumSystemFont(ofSize: 16), lines: 1, padding: 16).width
         return CGSize(width: w, height: 40)
     } else {
         
         return CGSize(width: 116, height: 40)
     }
     
     
//     return CGSize(width: 116.75127410888672, height: 40.0)
 }
}

// MARK: - Cell

class PlayMusicTagFilterCell: CollectionAdapterCell {
  
  // MARK: Properties
  
  @IBOutlet var button: UIButton!

    @IBOutlet var ccardView2: UIView?
    @IBOutlet var ccardView: UIView!
    public var data: PlayMusicTagFilterCellData?
  
  // MARK: Outlets
  
  @IBOutlet private weak var titleLabel: UILabel?
    
  
  // MARK: Initialize
  

 override func awakeFromNib() {
 
     button?.tapHideAnimation(
         view: ccardView2,
         type: .androidStyle(color: .playMusicColor),//.alpha(0.35),
         hideSpeed: .ms300,
         callback: { [weak self] eventType in
             if eventType == .touchUpInside {
                 self?.data?.state.handlers.onClickAt?()
                 
             }
         }
     )
 }
 
 override func fill(data: Any?) {
     guard let data = data as? PlayMusicTagFilterCellData else { return }
     self.data = data

     if let v = data.state.titleText { titleLabel?.text = v }
        
  }
}
