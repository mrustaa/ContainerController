import UIKit
import ContainerControllerSwift

// MARK: - State

extension PlayMusicCatalogItem {
  struct State {
      var redColor: Bool = false
    var firstImage: UIImage?
    var secondImage: UIImage?
      var handlers: Handlers = .init()
  }
    struct Handlers {
        
        var onClickAt: (()->(Void))?
    }
}

// MARK: - Item

class PlayMusicCatalogItem: CollectionAdapterItem {

  init(state: PlayMusicCatalogItem.State,
       clickCallback: (() -> ())? = nil) {

    let cellData =  PlayMusicCatalogCellData(state: state,
                                  clickCallback: clickCallback)
    super.init(cellClass: PlayMusicCatalogCell.self, cellData: cellData)
  }
}

// MARK: - Data

class PlayMusicCatalogCellData: CollectionAdapterCellData {

  // MARK: Properties
  var state: PlayMusicCatalogItem.State
  public var clickCallback: (() -> Void)?
  
  // MARK: Inits
  init(state: PlayMusicCatalogItem.State,
       clickCallback: (() -> ())?) {
     self.state = state

     self.clickCallback = clickCallback
     super.init()
 }
  
 override public func size() -> CGSize {
     return CGSize(width: 313.0, height: 162.0)
 }
}

// MARK: - Cell

class PlayMusicCatalogCell: CollectionAdapterCell {
  
  // MARK: Properties
  
  public var data: PlayMusicCatalogCellData?
  
  // MARK: Outlets
  
    @IBOutlet var redBtn: UIButton!
    @IBOutlet var button: UIButton!
    @IBOutlet private weak var firstImageView: UIImageView?
    @IBOutlet var cardImageView: DesignFigure!
    @IBOutlet private weak var secondImageView: UIImageView?
    
  
  // MARK: Initialize
  
 override func awakeFromNib() { 
     
     let red = self.data?.state.redColor ?? false
     
     redBtn.isHidden = !red
     button.isHidden = red
     
     button?.tapHideAnimation(
        view: cardImageView,
        type: .androidStyle(color: .playlistColor.withAlphaComponent(0.5)),
        hideSpeed: .ms100,
        callback: {  eventType in
            if eventType == .touchUpInside {
                self.data?.state.handlers.onClickAt?()
            }
        }
     )
     
     redBtn?.tapHideAnimation(
        view: self,
        type: .androidStyle(color: .playMusicColor.withAlphaComponent(0.5) ),
        hideSpeed: .ms100,
        callback: {   eventType in
            if eventType == .touchUpInside {
                self.data?.state.handlers.onClickAt?()
            }
        }
     )
 }
 
    override func fill(data: Any?) {
        guard let data = data as? PlayMusicCatalogCellData else { return }
        self.data = data
        
        if let v = data.state.firstImage {
            cardImageView.image = v
            cardImageView.layoutSubviews()
            cardImageView.layoutIfNeeded()
        }
        updateRed()
    }
    func updateRed() {
     
     let red = self.data?.state.redColor ?? false
     
     redBtn.isHidden = !red
     button.isHidden = red
     
     
  }
}
