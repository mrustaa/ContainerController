//
//  ContainerDevice.swift
//  PatternsSwift
//
//  Created by mrustaa on 21/04/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
public extension ContainerDevice {
    enum Orientation {
        case portrait
        case landscapeLeft
        case landscapeRight
    }
}

@available(iOS 13.0, *)
open class ContainerDevice {
    
    // MARK: - Size
    
    class public var width:  CGFloat { UIScreen.main.bounds.size.width }
    class public var height: CGFloat { UIScreen.main.bounds.size.height }
    
    class public var frame: CGRect { CGRect(x: 0, y: 0, width: width, height: height) }
    
    // MARK: - Max/Min
    
    class public var screenMax: CGFloat { max(width, height) }
    class public var screenMin: CGFloat { min(width, height) }
    
    // MARK: - Type
    
    static public let isIpad   = UIDevice.current.userInterfaceIdiom == .pad
    static public let isIphone = UIDevice.current.userInterfaceIdiom == .phone
    static public let isRetina = UIScreen.main.scale >= 2.0
    
    class public var isIphone4:   Bool { (isIphone && screenMax <  568.0) }
    class public var isIphone5:   Bool { (isIphone && screenMax == 568.0) } // SE
    class public var isIphone8:   Bool { (isIphone && screenMax == 667.0) } // 8
    class public var isIphone8P:  Bool { (isIphone && screenMax == 736.0) } // 8 Plus
    class public var isIphone11P: Bool { (isIphone && screenMax == 812.0) } // X, 11 Pro
    class public var isIphone11:  Bool { (isIphone && screenMax == 896.0) } // 11 Max
    
    class public var isIpad9_7:   Bool { (isIpad   && screenMax == 1024.0) } //  768 1024
    class public var isIpad10_2:  Bool { (isIpad   && screenMax == 1080.0) } //  810 1080
    class public var isIpad10_5:  Bool { (isIpad   && screenMax == 1112.0) } //  834 1112 Air
    class public var isIpad11:    Bool { (isIpad   && screenMax == 1194.0) } //  834 1194
    class public var isIpad12_9:  Bool { (isIpad   && screenMax == 1366.0) } // 1024 1366
    
    class public var isBigIphone: Bool { (isIphone && screenMax > 568.0) }
    class public var isIphoneX:   Bool { (isIphone && screenMax > 736.0) }
    
    // MARK: - X Padding
    
    class public var isIphoneXTop:    CGFloat { (isIphoneX ? 24.0 : 0.0) }
    class public var isIphoneXBottom: CGFloat { (isIphoneX ? 34.0 : 0.0) }
    
    // MARK: - StatusBar Height
    
    class public var statusBarHeight: CGFloat {
        var height: CGFloat = 0
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        height = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        return height
    }
    
    // MARK: - Orientation
    
    class public var isPortrait: Bool {
        
        var portrait: Bool = false
        
        let size: CGSize = UIScreen.main.bounds.size
        if size.width / size.height > 1 {
            portrait = false
        } else {
            portrait = true
        }
        
        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight:
            portrait = false
        case .portrait:
            portrait = true
        default: break
        }
        
        return portrait
    }
    
    class var statusBarOrientation: UIInterfaceOrientation? {
        get {
            guard let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation else {
                #if DEBUG
                fatalError("Could not obtain UIInterfaceOrientation from a valid windowScene")
                #else
                return nil
                #endif
            }
            return orientation
        }
    }
    
    class public var orientation: ContainerDevice.Orientation {
        if isPortrait {
            return .portrait
        } else {
            if let statusBarOrientation = statusBarOrientation {
                if statusBarOrientation == .landscapeLeft {
                    return .landscapeLeft
                } else if statusBarOrientation == .landscapeRight {
                    return .landscapeRight
                }
            }
            return .landscapeLeft
        }
    }
}

public extension UIDeviceOrientation {
    
    var isRotateAllowed: Bool {
        return !(face || self == .portraitUpsideDown)
    }
    
    var face: Bool {
        switch self {
        case .faceUp, .faceDown: return true
        default: return false
        }
    }
}
