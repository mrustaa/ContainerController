//
//  ButtonAnimationView.swift
//  ButtonLayersClickStyle
//
//  Created by Рустам Мотыгуллин on 09.03.2022.
//

import UIKit

extension CGFloat {
  static func random() -> CGFloat {
    return CGFloat(arc4random()) / CGFloat(UInt32.max)
  }
}

extension UIColor {
  static func random() -> UIColor {
    return UIColor(
      red:   .random(),
      green: .random(),
      blue:  .random(),
      alpha: 1.0
    )
  }
}

@IBDesignable
class ButtonAnimationView: UIView {
  
  @IBInspectable var cornerRadius: CGFloat = 0.0
  @IBInspectable var animationType: Int = 0
                 var animationTypeValue: CGFloat?
  @IBInspectable var allSubviews: Bool = false
  @IBInspectable var startClick: Bool = false
  
  
  var addViews: [UIView]?
  
  var setupDone = false
  
  public var type: UIButton.TapType = .alpha(0.5)
  private var subviewsAnimation = false
  public var button: UIButton?
//  public var mainView: UIView?
  
  
//  override func draw(_ rect: CGRect) {
//    super.draw(rect)
//
//    updateSubviews()
//  }
  
  // MARK: - Initialize
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
//    updateSubviews()
  }
  
//  public init() {
//    super.init(frame: .zero)
//    updateSubviews()
//  }
  
  
  
  public init(
    frame: CGRect,
    radius: CGFloat = 0.0,
    animation: Int = 0,
    value: CGFloat? = nil,
    addViews: [UIView]? = nil,
    startClick: Bool = false
  ) {
    super.init(frame: frame)
    self.cornerRadius = radius
    self.animationType = animation
    self.animationTypeValue = value
    self.addViews = addViews
    self.startClick = startClick
    //    updateSubviews()
  }
  
  
  // MARK: - layout subViews Update
  
  override func layoutSubviews() {
    updateSubviews()
  }
  
  public func updateSubviews() {
    
    if setupDone {
      return
    }
    
    
    if button == nil {
      createButton()
    }
//    if animationType == 9 {
//      createMainViewCopy()
//    }
    
    if animationType != 0 {
      
      let type: UIButton.TapType = {
        switch animationType {
        case 1: return .alpha(animationTypeValue ?? 0.5)
        case 2: return .layerGray(animationTypeValue ?? 0.22)
        case 3: return .pulsate(new: false)
        case 4: return .pulsate(new: true)
        case 5: return .shake(new: false)
        case 6: return .shake(new: true)
        case 7: return .flash
        case 8: return .color(value: UIColor.random())
        case 9: return .androidClickable(dark: false)
        case 10: return .androidClickable(dark: true)
        default: return .alpha(0.5)
        }
      }()
      
      setAnimation(type: type)
      
      if startClick {
        startClick = false
        
        let nviews = getViews()
        button?.onClick(views: nviews, radius: cornerRadius, type: type)
      }
    }
    
    
    
    setupDone = true
  }
  
  func getType(value: CGFloat? = nil) -> UIButton.TapType {
    
    let type: UIButton.TapType = {
      switch animationType {
      case 1: return .alpha(value ?? 0.5)
      case 2: return .layerGray(value ?? 0.22)
      case 3: return .pulsate(new: false)
      case 4: return .pulsate(new: true)
      case 5: return .shake(new: false)
      case 6: return .shake(new: true)
      case 7: return .flash
      case 8: return .color(value: UIColor.random())
      case 9: return .androidClickable(dark: false)
      case 10: return .androidClickable(dark: true)
      default: return .alpha(0.5)
      }
    }()
    return type
  }
  
  public func onClick() {
    button?.onClick(views: getViews(), radius: cornerRadius, type: getType())
  }
  
//  public func createMainViewCopy() {
//    let view = UIView(frame: bounds)
//    view.backgroundColor = .clear
//    view.layer.cornerRadius = cornerRadius
//    view.maskAll()
//    addSubview(view)
//    self.mainView = view
//  }
  
  public func createButton() {
    var fr: CGRect = bounds
    if subviews.count != 0 {
      let mainView = subviews[0]
      fr = mainView.frame
    }
    
    let btn = UIButton(type: .system)
    btn.frame = fr
    btn.backgroundColor = .clear
    btn.setTitle(nil, for: .normal)
    
//    btn.contentVerticalAlignment = .center
    btn.layer.cornerRadius = cornerRadius
    btn.clipsToBounds = true
//    btn.maskAll()
    addSubview(btn)
    self.button = btn
  }
  
  func getViews(views: [UIView]? = nil) -> [UIView] {
    
    var nviews: [UIView] = []
    if let views = views {
      nviews = views
    } else {
      if allSubviews {
        nviews.append(self)
        subviews.forEach {
          nviews.append($0)
        }
      } else {
        
        
            
        
        if animationType == 8, let v = button {
          nviews.append(v)
        } else if ((animationType == 9) || (animationType == 10)), let v = button {
          nviews.append(v)
        } else if subviews.count != 0 {
          
          if let addViews = addViews {
            
            nviews = addViews
          
//          if let tagsID = viewsTagsID {
//            let tags = tagsID.components(separatedBy: ",")
//              for str in tags {
//                let tagNumb = Int(str) ?? 0
//                for viww in subviews {
//                  if viww.tag == tagNumb {
//                    nviews.append(viww)
//                  }
//                }
//              }
          } else {
            let mainView = subviews[0]
            nviews.append(mainView)
          }
        }
      }
    }
    return nviews
  }
  
  public func setAnimation(type: UIButton.TapType, views: [UIView]? = nil) {
    self.type = type
    //    updateSubviews()
    
    layer.cornerRadius = cornerRadius
    
    let nviews = getViews(views: views)
    
    button?.tapHideAnimation(views: nviews, radius: cornerRadius, type: type, callback: { type in
      if type == .touchUpInside {
        
      }
    })
    subviewsAnimation = true
  }
  
}
