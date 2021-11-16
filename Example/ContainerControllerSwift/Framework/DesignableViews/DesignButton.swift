

import UIKit

@IBDesignable
class DesignButton: UIButton {
    
    @IBInspectable var hideAnimation: Bool = true
    
    @IBInspectable var fillColor: UIColor = .clear
    
    @IBInspectable var gradientColor: UIColor?
    @IBInspectable var gradientOffset: CGPoint = CGPoint(x: 0, y: 1)
    
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    @IBInspectable var shadowColor: UIColor = .clear
    @IBInspectable var shadowOffset: CGSize = CGSize.zero
    @IBInspectable var shadowRadius: CGFloat = 0.0
    @IBInspectable var shadowOpacity: CGFloat = 0.0
    
    @IBInspectable var borderColor: UIColor = .clear
    @IBInspectable var borderWidth: CGFloat = 0.0
    
    override func draw(_ rect: CGRect) {
        
        if let gradientColor = gradientColor {
            
            let glayer = CAGradientLayer()
            glayer.frame = bounds
            glayer.colors = [fillColor.cgColor, gradientColor.cgColor]
            glayer.startPoint = CGPoint.zero
            glayer.endPoint = gradientOffset
            glayer.cornerRadius = radius()
            layer.insertSublayer(glayer, at: 0)
            
        } else {
            layer.backgroundColor = fillColor.cgColor
        }
        
        layer.cornerRadius     = radius()
        
        layer.shadowOffset     = shadowOffset
        layer.shadowOpacity    = Float(shadowOpacity / 10.0)
        layer.shadowRadius     = shadowRadius
        layer.shadowColor      = shadowColor.cgColor
        
        layer.borderColor      = borderColor.cgColor
        layer.borderWidth      = borderWidth
    }
    
    override var isSelected: Bool {
        didSet {
            super.isSelected = isSelected
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            // super.isHighlighted = isHighlighted
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        selectedLayer(show: true)
        return super.beginTracking(touch, with: event)
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let point = touch.location(in: self)
        let someFrame = bounds
        let highlighted = someFrame.contains(point)
        selectedLayer(show: highlighted)
        return super.continueTracking(touch, with: event)
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        selectedLayer(show: false)
        super.endTracking(touch, with: event)
    }
    
    override func cancelTracking(with event: UIEvent?) {
        selectedLayer(show: false)
        super.cancelTracking(with: event)
    }
    
    func radius() -> CGFloat {
        let minSize = min(frame.size.width, frame.size.height)
        let radius = ((cornerRadius < 0) ? (minSize / 2) : cornerRadius)
        return radius
    }
    
    func selectedLayer(show: Bool) {
        
        func selectAnimationHide(show: Bool) {
            if show {
                alpha = 0.5
            } else {
                UIView.animate(withDuration: 0.35, animations: {
                    self.alpha = 1
                })
            }
        }
        
        func selectAnimationShadow(show: Bool) {
            let tag = 1
            let view = viewWithTag(tag)
            if show {
                if view == nil {
                    let view = UIView(frame: bounds)
                    view.backgroundColor = UIColor.init(white: 0.0, alpha: 0.2)
                    view.tag = tag
                    view.layer.cornerRadius = radius()
                    addSubview(view)
                }
            } else {
                if let view = view {
                    UIView.animate(withDuration: 0.35, animations: {
                        view.alpha = 0
                    }) { (fin: Bool) in
                        view.removeFromSuperview()
                    }
                }
            }
        }
        
        if hideAnimation {
            selectAnimationHide(show: show)
        } else {
            selectAnimationShadow(show: show)
        }
        
    }
}
