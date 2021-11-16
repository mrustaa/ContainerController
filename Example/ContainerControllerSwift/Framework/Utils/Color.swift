
import UIKit

extension UIColor {
    var redValue: CGFloat{ return CIColor(color: self).red }
    var greenValue: CGFloat{ return CIColor(color: self).green }
    var blueValue: CGFloat{ return CIColor(color: self).blue }
    var alphaValue: CGFloat{ return CIColor(color: self).alpha }
}

class Colors {
    
    class func rgba( _ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
    
    class func rgb( _ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return rgba(red, green, blue, 1)
    }
    
    class func grayLevel(_ gray: CGFloat) -> UIColor {
        return rgb(gray * 255, gray * 255, gray * 255)
    }
    
    class func blackAlpha(_ alpha: CGFloat) -> UIColor {
        return rgba(0, 0, 0, alpha)
    }
    
    // MARK: - Properties
    
    static public let lightGray = blackAlpha(0.1)
    static public let slightlyDark = blackAlpha(0.3)
    static public let halfBlack = blackAlpha(0.5)
    
    static public let black = grayLevel(0) // 0 %
    static public let gray = grayLevel(127) // 49 %
    static public let lightInactiveGray = grayLevel(178) // 69 %
    static public let silver = grayLevel(229) // 89 %
    static public let inactiveGray = grayLevel(246) // 96 %
    static public let white = grayLevel(255) // 100 %
    
    static public let transparentGray = rgba(225, 225, 225, 0.3)
    static public let lightOrange = rgba(255, 105, 0, 0.1)
    
    static public let red = rgb(255, 59, 48)
    static public let blue = rgb(44, 174, 233)
    static public let yellow = rgb(254, 219, 6)
    static public let orange = rgb(255, 105, 0)
    static public let purple = rgb(128, 0, 128)
    static public let gold = rgb(226, 201, 127)
    static public let beige = rgb(245, 245, 220)
    static public let brand = rgb(255, 105, 0)
    static public let approveGreen = rgb(49, 183, 0)
    static public let darkBlue = rgb(74, 144, 226)
    static public let semidarkBlue = rgb(0, 107, 202)
    static public let darkGray = rgb(142, 142, 147)
    static public let lightYellow = rgb(254, 229, 6)
    
}
