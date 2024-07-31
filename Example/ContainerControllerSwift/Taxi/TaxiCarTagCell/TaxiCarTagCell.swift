import UIKit
import ContainerControllerSwift

// MARK: - State

extension TaxiCarTagItem {
  struct State {
      var first: Bool?
      var index: Int = 0
    var titleText: String?
    var subtitleText: String?
    var text2: String?
    var image3: UIImage?
      
      var handlers: Handlers = .init()
  }
    struct Handlers {
        var onClickAt: ((UIControl.Event)->(Void))?
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
    var index: Int = 0
    
    var selectt: Bool = false
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
                main(delay: 0.5) {
                    self?.isSelected = false
                }
                self?.isSelected = true
                self?.isHighlighted = false
                self?.data?.state.handlers.onClickAt?(type)
            }
            if type == .touchDown {
                
                self?.isHighlighted = true
            }
        }
     )
 }
 
 override func fill(data: Any?) {
     guard let data = data as? TaxiCarTagCellData else { return }
     self.data = data
     
     self.index = data.state.index

     if let v = data.state.titleText { titleLabel?.text = v }
        if let v = data.state.subtitleText { subtitleLabel?.text = v }
        if let v = data.state.text2 { label2?.text = v }
        if let v = data.state.image3 { imageView3?.image = v }
        
     
     
//     if let _ = data.state.first {
//         
//         titleLabel?.textColor = .white
//         subtitleLabel?.textColor = .white
//         label2?.textColor = .white
//         
//         let img  =  #imageLiteral(resourceName: "imgTaxiVectorSel")
//         
//         let _maskingLayer =  CALayer()
//         _maskingLayer.frame = imageViewV.bounds;
//         _maskingLayer.contents =  img.cgImage
//         imageViewV.layer.mask = _maskingLayer
//         
//         
//         imageViewV.layer.cornerRadius = 0
//         
//     } else {
//         
//         titleLabel?.textColor =  TaxiViewController.blackFade
//         subtitleLabel?.textColor = TaxiViewController.blackFade
//         label2?.textColor = TaxiViewController.blackFade
//         
//         imageViewV.layer.cornerRadius = 14
//         imageViewV.layer.mask = nil
//         
//         
//     }
     
     updateColor()
  }
    
    func updateColor() {
        guard let data = self.data else { return }
        
        
        if let _ = data.state.first {
            
            let img  =  #imageLiteral(resourceName: "imgTaxiVectorSel")
            
            let _maskingLayer =  CALayer()
            _maskingLayer.frame = imageViewV.bounds;
            _maskingLayer.contents =  img.cgImage
            imageViewV.layer.mask = _maskingLayer
            
            
            imageViewV.layer.cornerRadius = 0
            
//            main {
        
            let d: CGFloat = 1
            let changeColor = CATransition()
            changeColor.duration = d
            changeColor.type = .fade
            let changeColor1 = CATransition()
            changeColor1.duration = d
            changeColor1.type = .fade
            let changeColor2 = CATransition()
            changeColor2.duration = d
            changeColor2.type = .fade
            
            CATransaction.begin()
            
            CATransaction.setCompletionBlock {
                self.titleLabel?.layer.add(changeColor, forKey: nil)
                self.subtitleLabel?.layer.add(changeColor1, forKey: nil)
                self.label2?.layer.add(changeColor2, forKey: nil)
                self.titleLabel?.textColor = .white
                self.subtitleLabel?.textColor = .white
                self.label2?.textColor = .white
            }
            
            self.titleLabel?.textColor =  Colors.halfBlack//  TaxiViewController.gray
            self.subtitleLabel?.textColor = Colors.halfBlack//  TaxiViewController.gray
            self.label2?.textColor = Colors.halfBlack// TaxiViewController.gray
            
            CATransaction.commit()
            
                
                
//                if let l1 =  self.titleLabel, let l2 =  self.subtitleLabel, let l3 =  self.label2  {
//                    UIView.transition(with: l1, duration: 1, options: .transitionCrossDissolve, animations: {
//                        self.titleLabel?.textColor = .white
//                        self.subtitleLabel?.textColor = .white
//                        self.label2?.textColor = .white
//                    }, completion: nil)
//                }
//            }
            
            
            
        } else {
            
            imageViewV.layer.cornerRadius = 14
            imageViewV.layer.mask = nil
//            main {
                
//                titleLabel?.textColor = .white
//                subtitleLabel?.textColor = .white
//                label2?.textColor = .white
//                
//                if let l1 =  self.titleLabel, let l2 =  self.subtitleLabel, let l3 =  self.label2  {
//                    UIView.transition(with: l1, duration: 1, options: .transitionCrossDissolve, animations: {
//                        self.titleLabel?.textColor =  TaxiViewController.blackFade
//                        self.subtitleLabel?.textColor = TaxiViewController.blackFade
//                        self.label2?.textColor =  TaxiViewController.blackFade
//                    }, completion: nil)
//                }
//            }
            
            let d: CGFloat = 1
            let changeColor = CATransition()
            changeColor.duration = d
            changeColor.type = .fade
            let changeColor1 = CATransition()
            changeColor1.duration = d
            changeColor1.type = .fade
            let changeColor2 = CATransition()
            changeColor2.duration = d
            changeColor2.type = .fade
            
            CATransaction.begin()
            
            CATransaction.setCompletionBlock {
                self.titleLabel?.layer.add(changeColor, forKey: nil)
                self.subtitleLabel?.layer.add(changeColor1, forKey: nil)
                self.label2?.layer.add(changeColor2, forKey: nil)
                self.titleLabel?.textColor =  TaxiViewController.blackFade
                self.subtitleLabel?.textColor = TaxiViewController.blackFade
                self.label2?.textColor =  TaxiViewController.blackFade
            }
            
            self.titleLabel?.textColor = .white
            self.subtitleLabel?.textColor = .white
            self.label2?.textColor = .white
            
            CATransaction.commit()
            
            
        }
        
        
        
//        main {
           
            
            if let _ = data.state.first {
                
                if !self.selectt {
                    self.selectt = true
                    
                    
                    let colourAnim = CABasicAnimation(keyPath: "backgroundColor")
                    colourAnim.fromValue = TaxiViewController.gray.cgColor
                    colourAnim.toValue = TaxiViewController.blue.cgColor
                    colourAnim.duration = 1.25
                    self.imageViewV.layer.add(colourAnim, forKey: "colourAnimation")
                    self.imageViewV.layer.backgroundColor =  TaxiViewController.blue.cgColor
                }
                
            } else {
                if self.selectt {
                    self.selectt = false
                    
                    
                    let colourAnim = CABasicAnimation(keyPath: "backgroundColor")
                    colourAnim.fromValue = TaxiViewController.blue.cgColor
                    colourAnim.toValue = TaxiViewController.gray.cgColor
                    colourAnim.duration = 0.5
                    self.imageViewV.layer.add(colourAnim, forKey: "colourAnimation")
                    self.imageViewV.layer.backgroundColor =  TaxiViewController.gray.cgColor
                }
            }
//        }
    }
}
