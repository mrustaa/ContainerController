import UIKit
import ContainerControllerSwift

// MARK: - State

extension TaxiRateEmojiItem {
    struct State {
      var blue: Bool = false
    var titleText: String?
    var subtitleText: String?
    var text2: String?
      
      var handlers: Handlers = .init()
  }
    struct Handlers {
        var onClickAt: ((UIControl.Event)->(Void))?
    }
  
}

// MARK: - Item

class TaxiRateEmojiItem: CollectionAdapterItem {

  init(state: TaxiRateEmojiItem.State,
       clickCallback: (() -> ())? = nil) {

    let cellData =  TaxiRateEmojiCellData(state: state,
                                  clickCallback: clickCallback)
    super.init(cellClass: TaxiRateEmojiCell.self, cellData: cellData)
  }
}

// MARK: - Data

class TaxiRateEmojiCellData: CollectionAdapterCellData {

  // MARK: Properties
  var state: TaxiRateEmojiItem.State
  public var clickCallback: (() -> Void)?
  
  // MARK: Inits
  init(state: TaxiRateEmojiItem.State,
       clickCallback: (() -> ())?) {
     self.state = state

     self.clickCallback = clickCallback
     super.init()
 }
  
 override public func size() -> CGSize {
     return CGSize(width: 151.0, height: 81.0)
 }
}

// MARK: - Cell

class TaxiRateEmojiCell: CollectionAdapterCell {
  
  // MARK: Properties
  
  public var data: TaxiRateEmojiCellData?
  
    @IBOutlet var btn: UIButton!
    var btnAdded: Bool = false
    // MARK: Outlets
  
    @IBOutlet var grayView: DesignFigure!
    @IBOutlet var blueView: DesignFigure!
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var subtitleLabel: UILabel?
    @IBOutlet private weak var label2: UILabel?
    
  
  // MARK: Initialize
  
 override func awakeFromNib() { 
     
     
     
     btn?.tapHideAnimation(
        views: [blueView, grayView],
        type: .alpha(0.5)
     )
 }
 
 override func fill(data: Any?) {
     guard let data = data as? TaxiRateEmojiCellData else { return }
     self.data = data

     if !btnAdded {
         btn?.tapHideAnimation(
            views: [blueView, grayView],
            type: data.state.blue ? .alpha(0.5) : .layerGray(0.20),
            callback: { [weak self] type in
                if type == .touchUpInside {
                    self?.data?.state.handlers.onClickAt?(type)
                }
            }
         )
     }
     
     self.blueView.isHidden = !data.state.blue
     self.grayView.isHidden = data.state.blue
     
     titleLabel?.textColor  = data.state.blue ? .white :  TaxiViewController.blackFade
     subtitleLabel?.textColor  = data.state.blue ? .white :  TaxiViewController.blackFade
     label2?.textColor = data.state.blue ? .white  :  TaxiViewController.blackFade
     
     if let v = data.state.titleText { titleLabel?.text = v }
        if let v = data.state.text2   { subtitleLabel?.text = v }
        if let v = data.state.subtitleText { label2?.text = v }
        
  }
} 
