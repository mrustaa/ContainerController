

import UIKit

@IBDesignable
class DesignButton: UIButton {
    
    @IBInspectable var hideAnimation: Bool = true
    
    //MARK: Fill
    
    @IBInspectable var fillColor: UIColor = .clear
    
    //MARK: Gradient
    
    @IBInspectable var grColor1: UIColor?
    @IBInspectable var grColor2: UIColor?
    @IBInspectable var grColor3: UIColor?
    @IBInspectable var grColor4: UIColor?
    @IBInspectable var grColor5: UIColor?
    @IBInspectable var grColor6: UIColor?
    
    @IBInspectable var grStartPoint: CGPoint = .zero
    @IBInspectable var grEndPoint:   CGPoint = .zero
    
    //MARK: Inner Shadow
    
    @IBInspectable var inShColor: UIColor = .clear
    @IBInspectable var inShRadius: CGFloat = 0.0
    @IBInspectable var inShOffset: CGSize = .zero
    
    //MARK: Shadow
        
    @IBInspectable var shColor:  UIColor = .clear
    @IBInspectable var shRadius: CGFloat = 0.0
    @IBInspectable var shOffset: CGSize  = .zero
    
    //MARK: Border
    
    @IBInspectable var brColor: UIColor = .clear
    @IBInspectable var brWidth: CGFloat = 0.0
    
    //MARK: Blur
    
    @IBInspectable var blur: CGFloat = 0.0
    
    //MARK: Radius
    
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    
    override func draw(_ rect: CGRect) {
        
        layer.cornerRadius = self.cornerRadius(cornerRadius)
        layer.backgroundColor = fillColor.cgColor
        
        addGradient()
        addInnerShadow()
        addShadow()
        addBorder()
        
        add(blur: blur)
    }
    
    private func addGradient() {
        
        _ = add(gradient: grColor1,
            color2: grColor2,
            color3: grColor3,
            color4: grColor4,
            color5: grColor5,
            color6: grColor6,
            pointStart: grStartPoint,
            pointEnd:   grEndPoint,
            cornerRadius: cornerRadius)
        
    }
    
    private func addInnerShadow() {
        
        addInnerShadow(color: inShColor,
                       radius: inShRadius,
                       offset: inShOffset,
                       cornerRadius: cornerRadius)
        
    }
    
    private func addShadow() {
        layer.shadowOffset     = shOffset
        layer.shadowOpacity    = 1.0
        layer.shadowRadius     = shRadius
        layer.shadowColor      = shColor.cgColor
    }
    
    private func addBorder() {
        layer.borderColor      = brColor.cgColor
        layer.borderWidth      = brWidth
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
                setAlpha(.halfTransluent)
            } else {
                UIView.animate(with: .ms350) {
                    self.setAlpha(.visible)
                }
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
                    UIView.animate(with: .ms350, animations: {
                        view.setAlpha(.invisible)
                    }, completion: { (fin: Bool) in
                        view.removeFromSuperview()
                    })
                    
                    
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
