
import UIKit

extension UIColor {
    var redValue: CGFloat{ return CIColor(color: self).red }
    var greenValue: CGFloat{ return CIColor(color: self).green }
    var blueValue: CGFloat{ return CIColor(color: self).blue }
    var alphaValue: CGFloat{ return CIColor(color: self).alpha }
    

    
    static let playFullPanelOld = UIColor(named: "PlayFullPanelOld")!
    static let playFullBackground = UIColor(named: "PlayFullBackground")!
    static let playFullBackgroundOld = UIColor(named: "PlayFullBackgroundOld")!
    static let playlistColor = UIColor(named: "PlaylistColor")!
    static let playMusicColor = UIColor(named: "PlayMusicColor")! // red
    static let sportColor = UIColor(named: "SportColor")!
}

class Colors {
    
    class func hex(_ hex: Int) -> UIColor {
        let mask = 0xFF
        let r = CGFloat((hex >> 16) & mask) / 255
        let g = CGFloat((hex >> 8) & mask) / 255
        let b = CGFloat((hex) & mask) / 255
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
    
    class func hexStr(_ hex: String) -> UIColor {
        let input = hex.replacingOccurrences(of: "#", with: "").uppercased()
        var a: CGFloat = 1.0, r: CGFloat = 0.0, b: CGFloat = 0.0, g: CGFloat = 0.0
        func colorComponent(from string: String, start: Int, length: Int) -> CGFloat {
            let substring = (string as NSString).substring(with: NSRange(location: start, length: length))
            let fullHex = length == 2 ? substring : "\(substring)\(substring)"
            var hexComponent: UInt64 = 0
            Scanner(string: fullHex).scanHexInt64(&hexComponent)
            return CGFloat(Double(hexComponent) / 255.0)
        }
        switch (input.count) {
        case 3 /* #RGB */:
            r = colorComponent(from: input, start: 0, length: 1)
            g = colorComponent(from: input, start: 1, length: 1)
            b = colorComponent(from: input, start: 2, length: 1)
        case 4 /* #ARGB */:
            a = colorComponent(from: input, start: 0, length: 1)
            r = colorComponent(from: input, start: 1, length: 1)
            g = colorComponent(from: input, start: 2, length: 1)
            b = colorComponent(from: input, start: 3, length: 1)
        case 6 /* #RRGGBB */:
            r = colorComponent(from: input, start: 0, length: 2)
            g = colorComponent(from: input, start: 2, length: 2)
            b = colorComponent(from: input, start: 4, length: 2)
        case 8 /* #AARRGGBB */:
            a = colorComponent(from: input, start: 0, length: 2)
            r = colorComponent(from: input, start: 2, length: 2)
            g = colorComponent(from: input, start: 4, length: 2)
            b = colorComponent(from: input, start: 6, length: 2)
        default:
            break
        }
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
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
