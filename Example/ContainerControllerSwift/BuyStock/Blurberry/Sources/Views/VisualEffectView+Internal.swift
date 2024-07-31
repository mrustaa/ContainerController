//
//  VisualEffectView+Internal.swift
//  Blurberry
//
//  Created by Pavel Puzyrev on 07.09.2020.
//
//  Copyright (c) 2020 Pavel Puzyrev <cannedapp@yahoo.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

internal extension BlurWrapper where Base: UIVisualEffectView {
    
    // MARK: iOS 13, 14

    var backdropView: UIView? {
        base.subviews.first {
            type(of: $0) == NSClassFromString("_UIVisualEffectBackdropView")
        }
    }

    var overlayView: UIView? {
        base.subviews.first {
            type(of: $0) == NSClassFromString("_UIVisualEffectSubview")
        }
    }

    var gaussianBlurFilter: NSObject? {
        backdropView?.arrayValue(getter: "filters")?.first {
            $0.stringValue(getter: "filterType") == "gaussianBlur"
        }
    }

    var sourceOverEffect: NSObject? {
        overlayView?.arrayValue(getter: "viewEffects")?.first {
            $0.stringValue(getter: "filterType") == "sourceOver"
        }
    }
    
    // MARK: iOS 10, 11, 12
    
    var blurEffect: NSObject? {
        guard let effect = base.effect, type(of: effect) == NSClassFromString("_UICustomBlurEffect") else {
            return nil
        }
        return base.effect
    }
    
    func updateBlurEffect(blurRadius: CGFloat, tintColor: UIColor?) {
        let effect = (NSClassFromString("_UICustomBlurEffect") as? UIBlurEffect.Type)?.init()
        effect?.setValueSafe(value: blurRadius, key: "blurRadius")
        effect?.setValueSafe(value: tintColor ?? UIColor(white: 1.0, alpha: 0.3), key: "colorTint")
        effect?.setValueSafe(value: 1.0, key: "scale")
        effect?.setValueSafe(value: 1.0, key: "colorTintAlpha")
        base.effect = effect
    }
    
    // MARK: Changes
    
    func prepareForChanges() {
        if #available(iOS 13, *) {
            base.effect = UIBlurEffect(style: .light)
            gaussianBlurFilter?.setIVarValue(value: 1.0, getter: "requestedScaleHint")
        }
    }

    func applyChanges() {
        if #available(iOS 13, *) {
            backdropView?.callMethod(named: "applyRequestedFilterEffects")
        }
    }
}
