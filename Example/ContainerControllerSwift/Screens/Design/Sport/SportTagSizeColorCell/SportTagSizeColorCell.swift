import UIKit
import ContainerControllerSwift

// MARK: - State

extension SportTagSizeColorItem {
  struct State {
      
      var first: Bool?
      var index: Int = 0
      var selectted: Bool = true
      var selecttedColor: UIColor?
      var text: String?
      var icon: UIImage?
//    var firstImage: UIImage?
//    var secondImage: UIImage?
//    var image2: UIImage?
      var radius: CGFloat?
      var borderColor: UIColor?
    var backColor: UIColor?
    var centerColor:  UIColor?
      var firstOpen: Bool?
      var neww: Bool = true
      var sport: Bool = false
      var newwIconColors: Bool = true
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
    @IBOutlet weak var firstImageView: UIImageView?
    @IBOutlet weak var secondImageView: UIImageView?
    @IBOutlet private weak var imageView2: UIImageView?
    @IBOutlet private weak var label3: UILabel?
    @IBOutlet private weak var label4: UILabel?
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var iconImageView2: UIImageView!
    
    @IBOutlet var unSelectedView: DesignnView!
    @IBOutlet var unSelectedLabel: UILabel!
    
    @IBOutlet var backCenterColorView: DesignnView!
    @IBOutlet var backColorView: DesignnView!
    
    
    @IBOutlet var sselectedViewMain: UIView!
    @IBOutlet var sselectedViewWhite: DesignnView!
    @IBOutlet var sselectedView: DesignnView!
    @IBOutlet var sselectedView2: DesignnView?
    @IBOutlet var sselectedLabel: UILabel!
    var ccardView3: UIView?
    // MARK: Initialize
  
    var firstOpen: Bool = false
    
 override func awakeFromNib() {
     
     
     button?.tapHideAnimation(
        views: [unSelectedView,
                backCenterColorView,
                sselectedView
               ],
        type: .layerGray(0.5),
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
     
     let index = (self.data?.state.index ?? 0) 
     
     if !firstOpen {
         firstOpen = true
         main(delay: 3.0 * (0.5 * Double(index))) {
//             self.sselectedView?.layer.removeAllAnimations()
//             self.sselectedView?.layoutSubviews()
             self.updateVIew3(add: false)
             self.updateVIew3(add: true)
         }
     } else {
         //          }
     }
     
//     self.updateColor()
     
     let r = data.state.radius ?? 20
     self.unSelectedView.cornerRadius = r
     self.backColorView.cornerRadius = r
     self.sselectedView.cornerRadius = r
     
     self.sselectedView.layer.cornerRadius = r
     
     self.sselectedView2?.cornerRadius = r
     
     self.unSelectedView.layoutSubviews()
     self.unSelectedView.layoutIfNeeded()
     self.backColorView.layoutSubviews()
     self.backColorView.layoutIfNeeded()
     self.sselectedView.layoutSubviews()
     self.sselectedView.layoutIfNeeded()
     self.sselectedView2?.layoutSubviews()
     self.sselectedView2?.layoutIfNeeded()
     
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
         
         
         
         self.iconImageView2.isHidden = false
         self.iconImageView2.image = icon
     
         
     } else {
         self.iconImageView.isHidden = true
         self.iconImageView2.isHidden = true
     }
     
     if let color = data.state.backColor {
         
         self.sselectedViewMain.isHidden = true
         self.sselectedView2?.isHidden = true
         self.unSelectedView?.isHidden = true
         
         
         self.backColorView.fillColor = color
         self.backColorView.isHidden = true
         
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
         
         
         self.sselectedViewMain.isHidden = true
         self.sselectedView2?.isHidden = true
//         self.unSelectedView.isHidden = true
         
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
    
     
     self.updateColor()
     
     
     
     if let f = data.state.firstOpen {
         firstOpen = f
     }
     
     
     if firstOpen {
         main(delay: 1.0) {

             data.state.firstOpen = true
             self.updateVIew3(add: false)
             self.updateVIew3(add: true)
         }
//         data.state.firstOpen = true
//         updateVIew3(add: false)
//         updateVIew3(add: true)
     }
     
//     self.sselectedViewWhite.isHidden = false
  }
    
    func updateColor() {
        
        guard let data = self.data else { return }
        
        var color11: UIColor = data.state.selectted ? .white : .playlistColor
        var color22: UIColor = data.state.selectted ? .white : .playMusicColor
        
        if data.state.neww {
            self.ccardView3?.alpha = 0
            
            
            color11 =  .white //.playlistColor
            color22 = .white  //.playMusicColor
            
            if data.state.selectted {
                color11 = .playlistColor
                color22 = .playMusicColor
                
            }
        }
        
        if data.state.sport {
            let orange = data.state.selectted ? .white : Colors.hexStr("F38A0E")
            color22 = orange
            
        }
        
        self.iconImageView2.tintColor = color11
        self.iconImageView.tintColor = color22
        
//         
        self.sselectedView.fillColor = data.state.sport ? Colors.hexStr("F38A0E") : .playMusicColor
        
        self.sselectedView.layoutSubviews()
        self.sselectedView.layoutIfNeeded()
         
        
        self.sselectedViewMain.isHidden = false
        if data.state.selectted && !data.state.neww {
            
            
            self.sselectedView.isHidden = false
            self.backColorView.isHidden = true
            
            self.updateWhiteView(show: false)
            
        
            
        } else {
            
            
            self.sselectedView.isHidden = true
            self.backColorView.isHidden = true
            
            
            
            self.updateWhiteView(show: true)
            
            
            
//            self.sselectedView.isHidden = true
//            self.unSelectedView.isHidden = false
           
        }
        
        if data.state.sport {
            
            if let _ = data.state.backColor {
                self.sselectedView.isHidden = true
                self.backColorView.isHidden = false
            } else {
                
                if data.state.selectted {
                    self.sselectedView.isHidden = false
                    self.backColorView.isHidden = true
                    self.updateWhiteView(show: false)
                } else {
                    self.sselectedView.isHidden = true
                    self.backColorView.isHidden = true
                    
                    self.updateWhiteView(show: true)
                    
                }
            }
            
        }
        
//        self.updateVIew3(add: false)
    }
    
    
    func updateWhiteView(show: Bool = true) {
        
        guard let data = self.data else { return }
        if show {
            if  data.state.neww {
                self.sselectedViewWhite.isHidden = false
                self.unSelectedView.isHidden = true
            } else {
                
                self.sselectedViewWhite.isHidden = true
                self.unSelectedView.isHidden = false
            }
            
            if data.state.sport {
                self.sselectedViewWhite.isHidden = true
                self.unSelectedView.isHidden = false
            }
        } else {
            
            self.unSelectedView.isHidden = true
            self.sselectedViewWhite.isHidden = true
            
        }
    }
    
    
    func updateVIew3(add: Bool) {
        
        if add {
            if self.ccardView3 == nil {
                let view3 = UIView(frame: .zero)
                view3.frame.origin = .zero
                view3.frame = .init(x: 0, y: 0, width: 54, height: 54)
                
                view3.layer.cornerRadius = 20
                var backgroundColor: UIColor = .playMusicColor
                
                
                if self.data?.state.sport ?? false {
                    let orange = Colors.hexStr("F38A0E")
                    backgroundColor = orange
                }
                
                
                view3.alpha = (self.data?.state.selectted ?? false) ? 1 : 0
                //      ccardView2.backgroundColor = .playMusicColor
                view3.layer.backgroundColor = backgroundColor.cgColor
                
                self.ccardView3 = view3
                
//                if let sselectedView = self.sselectedView {
                    
                    self.sselectedView?.insertSubview(view3, at: 0)
//                }
                
                
//                button?.tapHideAnimation(
//                    views: [unSelectedView,
//                            backCenterColorView,
//                            sselectedView, sselectedView2],
//                    type: .layerGray(0.5),
//                    callback: { [weak self] type in
//                        if type == .touchUpInside {
//                            self?.data?.state.handlers.onClickAt?(self?.data?.state.index ?? 0)
//                        }
//                    }
//                )
                var arr: [UIColor] = [ .playMusicColor, .playlistColor]
                
                if self.data?.state.sport ?? false {
                    arr = [ Colors.hexStr("F38A0E"), .playlistColor]
                }
                
                if self.data?.state.selectted ?? false {
                    arr =  [ .white, .gray]
                    
                }
                
                guard let data = self.data else { return }
                
                if data.state.selectted {
                    self.button?.tapHideAnimation(
                        view: ccardView3,
                        type: data.state.selectted ? .color(arr) : .alpha(0.5),
                        hideSpeed: .s1,
                        callback: { [weak self] type in
                            if type == .touchUpInside {
                                self?.data?.state.handlers.onClickAt?(self?.data?.state.index ?? 0)
                            }
                        }
                    )
                }
                
                let index = (self.data?.state.index ?? 0)
                
                main(delay: 1.5 + 0.5 * Double(index)) {
//                    if data.state.selectted {
                        self.ccardView3?.animationColor(duration: .s2, colors: arr)
//                    } else {
//                        self.iconImageView?.animationOpacity(duration: 5, value: 1)
//                    }
                }
                
                
            }
            
//            self.ccardView3?.width = self.mainCardView.width
            
        } else {
            self.ccardView3?.layer.removeAllAnimations()
            self.ccardView3?.removeFromSuperview()
            self.ccardView3 = nil
        }
    }
}
