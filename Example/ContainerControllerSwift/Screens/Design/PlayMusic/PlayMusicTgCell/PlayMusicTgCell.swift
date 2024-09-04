import UIKit
import ContainerControllerSwift

// MARK: - State

extension PlayMusicTgItem {
  struct State {
      
      var type: ViewCallsPlayerType = .none
    var firstImage: UIImage?
    var subtitleText: String?
    var text2: String?
    var text3: String?
      var handlers: Handlers = .init()
  }
    struct Handlers {
        var onClickAt: ((ViewCallsPlayerType)->(Void))?
    }
}

// MARK: - Item

class PlayMusicTgItem: CollectionAdapterItem {

  init(state: PlayMusicTgItem.State,
       clickCallback: (() -> ())? = nil) {

    let cellData =  PlayMusicTgCellData(state: state,
                                  clickCallback: clickCallback)
    super.init(cellClass: PlayMusicTgCell.self, cellData: cellData)
  }
}

// MARK: - Data

class PlayMusicTgCellData: CollectionAdapterCellData {

  // MARK: Properties
  var state: PlayMusicTgItem.State
  public var clickCallback: (() -> Void)?
  
  // MARK: Inits
  init(state: PlayMusicTgItem.State,
       clickCallback: (() -> ())?) {
     self.state = state

     self.clickCallback = clickCallback
     super.init()
 }
  
 override public func size() -> CGSize {
     return CGSize(width: 206.0, height: 203.0)
 }
}

// MARK: - Cell

class PlayMusicTgCell: CollectionAdapterCell {
  
  // MARK: Properties
  
  public var data: PlayMusicTgCellData?
  
  // MARK: Outlets
    @IBOutlet var ccardView: DesignFigure!
    
    @IBOutlet var button: UIButton!
    @IBOutlet var imgView: DesignFigure!
    @IBOutlet private weak var subtitleLabel: UILabel?
    @IBOutlet private weak var label2: UILabel?
    @IBOutlet private weak var label3: UILabel?
    
  
  // MARK: Initialize
  
 override func awakeFromNib() {
     
     imgView.clipsToBounds = true
     
     button?.tapHideAnimation(
        view: imgView,//ccardView,
        type: .androidStyle(color: .systemPink.withAlphaComponent(0.64)),
        hideSpeed: .ms100,
        callback: { [weak self]  eventType in
            if eventType == .touchUpInside {
                self?.data?.state.handlers.onClickAt?(self?.data?.state.type ?? .none)
                
            }
        }
     )
 }
 
 override func fill(data: Any?) {
     guard let data = data as? PlayMusicTgCellData else { return }
     self.data = data

     if let v = data.state.firstImage {
         imgView?.image = v
         imgView.layoutSubviews()
         imgView.layoutIfNeeded()
     }
        if let v = data.state.subtitleText { subtitleLabel?.text = v }
        if let v = data.state.text2 { label2?.text = v }
        if let v = data.state.text3 { label3?.text = v }
        
  }
}
