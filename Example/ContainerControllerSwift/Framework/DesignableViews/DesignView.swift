

import UIKit

@IBDesignable
class DesignView: UIView {
    
    @IBInspectable var fillColor: UIColor = .clear
    
    //MARK: - Gradient
    
    @IBInspectable var gradientColor: UIColor?
    @IBInspectable var gradientColor2: UIColor?
    @IBInspectable var gradientColor3: UIColor?
    @IBInspectable var gradientStartPoint: CGPoint = CGPoint.zero
    @IBInspectable var gradientOffset: CGPoint = CGPoint(x: 0, y: 1)
    
    //MARK: - Shadow
    
    @IBInspectable var shadowColor: UIColor = .clear
    @IBInspectable var shadowOffset: CGSize = CGSize.zero
    @IBInspectable var shadowRadius: CGFloat = 0.0
    @IBInspectable var shadowOpacity: CGFloat = 0.0
    
    //MARK: - Radius
    
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    //MARK: - Border
    
    @IBInspectable var borderColor: UIColor = .clear
    @IBInspectable var borderWidth: CGFloat = 0.0
    
    override func draw(_ rect: CGRect) {
        
        if let gradientColor = gradientColor {
            
            var colors: [CGColor] = []
            colors.append(fillColor.cgColor)
            colors.append(gradientColor.cgColor)
            if let gradientColor2 = gradientColor2 { colors.append(gradientColor2.cgColor) }
            if let gradientColor3 = gradientColor3 { colors.append(gradientColor3.cgColor) }
            
            let glayer = CAGradientLayer()
            glayer.frame = bounds
            glayer.colors = colors
            glayer.startPoint = gradientStartPoint
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
    
    func radius() -> CGFloat {
        let minSize = min(width, height)
        let radius = ((cornerRadius < 0) ? (minSize / 2) : cornerRadius)
        return radius
    }
    
}
