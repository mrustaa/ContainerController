import UIKit
import ContainerControllerSwift

// MARK: - State

extension TaxiCarTagItem {
  struct State {
      var first: Bool?
    var titleText: String?
    var subtitleText: String?
    var text2: String?
    var image3: UIImage?
      
      var handlers: Handlers = .init()
  }
    struct Handlers {
        var onClickAt: (()->(Void))?
    }
}

// MARK: - Item

class TaxiCarTagItem: CollectionAdapterItem {

  init(state: TaxiCarTagItem.State,
       clickCallback: (() -> ())? = nil) {

    let cellData =  TaxiCarTagCellData(state: state,
                                  clickCallback: clickCallback)
    super.init(cellClass: TaxiCarTagCell.self, cellData: cellData)
  }
}

// MARK: - Data

class TaxiCarTagCellData: CollectionAdapterCellData {

  // MARK: Properties
  var state: TaxiCarTagItem.State
  public var clickCallback: (() -> Void)?
  
  // MARK: Inits
  init(state: TaxiCarTagItem.State,
       clickCallback: (() -> ())?) {
     self.state = state

     self.clickCallback = clickCallback
     super.init()
 }
  
 override public func size() -> CGSize {
     return CGSize(width: 139.0, height: 139.0)
 }
}

// MARK: - Cell

class TaxiCarTagCell: CollectionAdapterCell {
  
  // MARK: Properties
  
  public var data: TaxiCarTagCellData?
  
  // MARK: Outlets
  
  @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var subtitleLabel: UILabel?
    @IBOutlet private weak var label2: UILabel?
    @IBOutlet private weak var imageView3: UIImageView?
    
    @IBOutlet var buttonn: UIButton!
    @IBOutlet var imageViewV: UIView!
//    @IBOutlet var imageViewV2: UIView!
    
  // MARK: Initialize
  
 override func awakeFromNib() { 
     
     buttonn?.tapHideAnimation(
        view: imageViewV,
        type: .layerGray(0.18),
        callback: { [weak self] type in
            if type == .touchUpInside {
                self?.data?.state.handlers.onClickAt?()
            }
        }
     )
 }
 
 override func fill(data: Any?) {
     guard let data = data as? TaxiCarTagCellData else { return }
     self.data = data

     if let v = data.state.titleText { titleLabel?.text = v }
        if let v = data.state.subtitleText { subtitleLabel?.text = v }
        if let v = data.state.text2 { label2?.text = v }
        if let v = data.state.image3 { imageView3?.image = v }
        
     
     
     if let _ = data.state.first {
         
         titleLabel?.textColor = .white
         subtitleLabel?.textColor = .white
         label2?.textColor = .white
         
         let img  =  #imageLiteral(resourceName: "imgTaxiVectorSel")
         
         let _maskingLayer =  CALayer()
         _maskingLayer.frame = imageViewV.bounds;
         _maskingLayer.contents =  img.cgImage
         imageViewV.layer.mask = _maskingLayer
         imageViewV.backgroundColor = TaxiViewController.blue
         imageViewV.layer.cornerRadius = 0
//         imageViewV2.backgroundColor = TaxiViewController.gray
//         imageViewV2.isHidden = true
//         imageViewV.isHidden = false
         
         
     } else {
         
         titleLabel?.textColor =  TaxiViewController.blackFade
         subtitleLabel?.textColor = TaxiViewController.blackFade
         label2?.textColor = TaxiViewController.blackFade
         
         imageViewV.backgroundColor = TaxiViewController.gray
         imageViewV.layer.cornerRadius = 14
         imageViewV.layer.mask = nil
         
//         imageViewV.isHidden = true
//         imageViewV2.isHidden = false
     }
     
  }
}
