import UIKit
import ContainerControllerSwift

// MARK: - State

extension SportTagSizeColorItem {
  struct State {
      
      var first: Bool?
      var index: Int = 0
      var selectted: Bool = false
      var text: String?
      var icon: UIImage?
//    var firstImage: UIImage?
//    var secondImage: UIImage?
//    var image2: UIImage?
      var borderColor: UIColor?
    var backColor: UIColor?
    var centerColor:  UIColor?
      var handlers: Handlers = .init()
  }
    struct Handlers {
        var onClickAt: ((Int)->(Void))?
    }
}

protocol TagUpdateCellDelegate {
    func updateColor()
}
// MARK: - Item

class SportTagSizeColorItem: CollectionAdapterItem {

  init(state: SportTagSizeColorItem.State,
       clickCallback: (() -> ())? = nil) {

    let cellData =  SportTagSizeColorCellData(state: state,
                                  clickCallback: clickCallback)
    super.init(cellClass: SportTagSizeColorCell.self, cellData: cellData)
  }
}

// MARK: - Data

class SportTagSizeColorCellData: CollectionAdapterCellData {

  // MARK: Properties
  var state: SportTagSizeColorItem.State
  public var clickCallback: (() -> Void)?
  
  // MARK: Inits
  init(state: SportTagSizeColorItem.State,
       clickCallback: (() -> ())?) {
     self.state = state

     self.clickCallback = clickCallback
     super.init()
 }
  
 override public func size() -> CGSize {
     return CGSize(width: 54.0, height: 54.0)
 }
}

// MARK: - Cell

class SportTagSizeColorCell: CollectionAdapterCell, TagUpdateCellDelegate {
  
  // MARK: Properties
  
  public var data: SportTagSizeColorCellData?
  
  // MARK: Outlets
  
    @IBOutlet var button: UIButton!
    @IBOutlet private weak var firstImageView: UIImageView?
    @IBOutlet private weak var secondImageView: UIImageView?
    @IBOutlet private weak var imageView2: UIImageView?
    @IBOutlet private weak var label3: UILabel?
    @IBOutlet private weak var label4: UILabel?
    
    @IBOutlet var iconImageView: UIImageView!
    
    @IBOutlet var unSelectedView: DesignFigure!
    @IBOutlet var unSelectedLabel: UILabel!
    
    @IBOutlet var backCenterColorView: DesignFigure!
    @IBOutlet var backColorView: DesignFigure!
    
    @IBOutlet var sselectedView: DesignFigure!
    @IBOutlet var sselectedLabel: UILabel!
    // MARK: Initialize
  
 override func awakeFromNib() {
     
     
     button?.tapHideAnimation(
        views: [unSelectedView,
                backCenterColorView,
                sselectedView],
        type: .layerGray(0.25),
        callback: { [weak self] type in
            if type == .touchUpInside {
                self?.data?.state.handlers.onClickAt?(self?.data?.state.index ?? 0)
            }
        }
     )
 }
 
 override func fill(data: Any?) {
     guard let data = data as? SportTagSizeColorCellData else { return }
     self.data = data
     
     self.updateColor()
     
     if let text = data.state.text {
         self.sselectedLabel.isHidden = false
         self.sselectedLabel.text = text
         self.unSelectedLabel.isHidden = false
         self.unSelectedLabel.text = text
     } else {
         
         self.sselectedLabel.isHidden = true
         self.unSelectedLabel.isHidden = true
     }
     
     if let icon = data.state.icon {
         self.iconImageView.isHidden = false
         self.iconImageView.image = icon
     } else {
         self.iconImageView.isHidden = true
     }
     
     if let color = data.state.backColor {
         
         self.sselectedView.isHidden = true
         self.unSelectedView.isHidden = true
         
         
         self.backColorView.fillColor = color
         self.backColorView.isHidden = false
         
         self.backColorView.layoutIfNeeded()
         self.backColorView.layoutSubviews()
         self.backColorView.setup()
         
     } else {
         self.backColorView.isHidden = true
     }
     
     if let color = data.state.borderColor {
         self.backColorView.brColor = color
         self.backColorView.brWidth = 1
         
         self.backColorView.layoutIfNeeded()
         self.backColorView.layoutSubviews()
         self.backColorView.setup()
         
     }
     
     if let color = data.state.centerColor {
         
         
         self.sselectedView.isHidden = true
         self.unSelectedView.isHidden = true
         
         self.backCenterColorView.isHidden = false
         self.backCenterColorView.fillColor = color
         
         self.backCenterColorView.layoutIfNeeded()
         self.backCenterColorView.layoutSubviews()
         self.backCenterColorView.setup()
     } else {
         self.backCenterColorView.isHidden = true
     }
//     if let v = data.state.firstImage { firstImageView?.image = v }
//        if let v = data.state.secondImage { secondImageView?.image = v }
//        if let v = data.state.image2 { imageView2?.image = v }
//        if let v = data.state.text3 { label3?.text = v }
//        if let v = data.state.text4 { label4?.text = v }
        
  }
    
    func updateColor() {
        guard let data = self.data else { return }
        
        
        if data.state.selectted {
            
            self.sselectedView.isHidden = false
            self.unSelectedView.isHidden = true
            
            self.iconImageView.tintColor = .white
        } else {
            self.sselectedView.isHidden = true
            self.unSelectedView.isHidden = false
            self.iconImageView.tintColor = Colors.hexStr("FF8A00")
        }
    }
}
