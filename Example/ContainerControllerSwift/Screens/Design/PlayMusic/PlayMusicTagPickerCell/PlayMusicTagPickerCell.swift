import UIKit
import ContainerControllerSwift

// MARK: - State

extension PlayMusicTagPickerItem {
  struct State {
      var type: ViewCallsPlayerType?
    var firstImage: UIImage?
    var subtitleText: String?
    
     var handlers: Handlers = .init()
   }
   struct Handlers {
     var onClickAt: ((ViewCallsPlayerType?)->(Void))?
    }
}

// MARK: - Item

class PlayMusicTagPickerItem: CollectionAdapterItem {

  init(state: PlayMusicTagPickerItem.State,
       clickCallback: (() -> ())? = nil) {

    let cellData =  PlayMusicTagPickerCellData(state: state,
                                  clickCallback: clickCallback)
    super.init(cellClass: PlayMusicTagPickerCell.self, cellData: cellData)
  }
}

// MARK: - Data

class PlayMusicTagPickerCellData: CollectionAdapterCellData {

  // MARK: Properties
  var state: PlayMusicTagPickerItem.State
  public var clickCallback: (() -> Void)?
  
  // MARK: Inits
  init(state: PlayMusicTagPickerItem.State,
       clickCallback: (() -> ())?) {
     self.state = state

     self.clickCallback = clickCallback
     super.init()
 }
  
 override public func size() -> CGSize {
     return CGSize(width: 109.0, height: 109.0)
 }
}

// MARK: - Cell

class PlayMusicTagPickerCell: CollectionAdapterCell {
  
  // MARK: Properties
  
 
 @IBOutlet var ccardView: UIView?
  @IBOutlet var button: UIButton!

  public var data: PlayMusicTagPickerCellData?
  
  // MARK: Outlets
  
    @IBOutlet var firstPicView: DesignnImageView!
//    @IBOutlet private weak var firstImageView: UIImageView?
    @IBOutlet private weak var subtitleLabel: UILabel?
    
  
  // MARK: Initialize
  

 override func awakeFromNib() {
 
     button?.tapHideAnimation(
         view: ccardView,
         type: .alpha(0.35),
         hideSpeed: .ms300,
         callback: { [weak self] eventType in
             if eventType == .touchUpInside {
                 self?.data?.state.handlers.onClickAt?(self?.data?.state.type)
                 
             }
         }
     )
 }
 
 override func fill(data: Any?) {
     guard let data = data as? PlayMusicTagPickerCellData else { return }
     self.data = data

     firstPicView.image = nil
     firstPicView.layoutSubviews()
     firstPicView.layoutIfNeeded()
     
     if let type = data.state.type {
         firstPicView.image = ViewCallsPlayer.getImage(type)
         firstPicView.layoutSubviews()
         firstPicView.layoutIfNeeded()
         
         subtitleLabel?.text = (ViewCallsPlayer.getTitle(type) + " - " +  ViewCallsPlayer.getSubtitle(type))
     } else {
         
         if let v = data.state.firstImage {
             firstPicView.image = v
             firstPicView.layoutSubviews()
             firstPicView.layoutIfNeeded()
         }
         if let v = data.state.subtitleText { subtitleLabel?.text = v }
     }
        
  }
}
