import UIKit
import ContainerControllerSwift

// MARK: - State

extension PlayMusicNewTagItem {
  struct State {
    var titleText: String?
    
     var handlers: Handlers = .init()
   }
   struct Handlers {
     var onClickAt: (()->(Void))?
    }
}

// MARK: - Item

class PlayMusicNewTagItem: CollectionAdapterItem {

  init(state: PlayMusicNewTagItem.State,
       clickCallback: (() -> ())? = nil) {

    let cellData =  PlayMusicNewTagCellData(state: state,
                                  clickCallback: clickCallback)
    super.init(cellClass: PlayMusicNewTagCell.self, cellData: cellData)
  }
}

// MARK: - Data

class PlayMusicNewTagCellData: CollectionAdapterCellData {

  // MARK: Properties
  var state: PlayMusicNewTagItem.State
  public var clickCallback: (() -> Void)?
  
  // MARK: Inits
  init(state: PlayMusicNewTagItem.State,
       clickCallback: (() -> ())?) {
     self.state = state

     self.clickCallback = clickCallback
     super.init()
 }
  
 override public func size() -> CGSize {
     return CGSize(width: 116.75127410888672, height: 40.0)
 }
}

// MARK: - Cell

class PlayMusicNewTagCell: CollectionAdapterCell {
  
  // MARK: Properties
  
 
 @IBOutlet var ccardView: UIView?
  @IBOutlet var button: UIButton!

  public var data: PlayMusicNewTagCellData?
  
  // MARK: Outlets
  
  @IBOutlet private weak var titleLabel: UILabel?
    
  
  // MARK: Initialize
  

 override func awakeFromNib() {
 
     button?.tapHideAnimation(
         view: ccardView,
         type: .alpha(0.35),
         hideSpeed: .ms300,
         callback: { [weak self] eventType in
             if eventType == .touchUpInside {
                 self?.data?.state.handlers.onClickAt?()
                 
             }
         }
     )
 }
 
 override func fill(data: Any?) {
     guard let data = data as? PlayMusicNewTagCellData else { return }
     self.data = data

     if let v = data.state.titleText { titleLabel?.text = v }
        
  }
}