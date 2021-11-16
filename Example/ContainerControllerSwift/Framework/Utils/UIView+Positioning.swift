//
//  UIView+Positioning.swift
//
//  Created by Shai Mishali on 1/19/15.
//  Copyright (c) 2015 Shai Mishali. All rights reserved.
//

import UIKit

public extension UIView {
    
    // MARK: - Basic Properties

    /// X Axis value of UIView.
    var x: CGFloat {
        set { self.frame = CGRect(x: _pixelIntegral(newValue),
                                  y: self.y,
                                  width: self.width,
                                  height: self.height)
            }
        get { return self.frame.origin.x }
    }

    /// Y Axis value of UIView.
    var y: CGFloat {
        set { self.frame = CGRect(x: self.x,
                                  y: _pixelIntegral(newValue),
                                  width: self.width,
                                  height: self.height)
            }
        get { return self.frame.origin.y }
    }

    /// Width of view.
    var width: CGFloat {
        set { self.frame = CGRect(x: self.x,
                                  y: self.y,
                                  width: _pixelIntegral(newValue),
                                  height: self.height)
            }
        get { return self.frame.size.width }
    }

    /// Height of view.
    var height: CGFloat {
        set { self.frame = CGRect(x: self.x,
                                  y: self.y,
                                  width: self.width,
                                  height: _pixelIntegral(newValue))
            }
        get { return self.frame.size.height }
    }

    // MARK: - Origin and Size

    /// View's Origin point.
    var origin: CGPoint {
        set { self.frame = CGRect(x: _pixelIntegral(newValue.x),
                                  y: _pixelIntegral(newValue.y),
                                  width: self.width,
                                  height: self.height)
            }
        get { return self.frame.origin }
    }

    /// View's size.
    var size: CGSize {
        set { self.frame = CGRect(x: self.x,
                                  y: self.y,
                                  width: _pixelIntegral(newValue.width),
                                  height: _pixelIntegral(newValue.height))
            }
        get { return self.frame.size }
    }

    // MARK: - Extra Properties

    /// View's right side (x + width).
    var right: CGFloat {
        set { self.x = newValue - self.width }
        get { return self.x + self.width }
    }

    /// View's bottom (y + height).
    var bottom: CGFloat {
        set { self.y = newValue - self.height }
        get { return self.y + self.height }
    }

    /// View's top (y).
    var top: CGFloat {
        set { self.y = newValue }
        get { return self.y }
    }

    /// View's left side (x).
    var left: CGFloat {
        set { self.x = newValue }
        get { return self.x }
    }

    /// View's center X value (center.x).
    var centerX: CGFloat {
        set { self.center = CGPoint(x: newValue, y: self.centerY) }
        get { return self.center.x }
    }

    /// View's center Y value (center.y).
    var centerY: CGFloat {
        set { self.center = CGPoint(x: self.centerX, y: newValue) }
        get { return self.center.y }
    }

    /// Last subview on X Axis.
    var lastSubviewOnX: UIView? {
        return self.subviews.reduce(UIView(frame: .zero)) {
            return $1.x > $0.x ? $1 : $0
        }
    }

    /// Last subview on Y Axis.
    var lastSubviewOnY: UIView? {
        return self.subviews.reduce(UIView(frame: .zero)) {
            return $1.y > $0.y ? $1 : $0
        }
    }

    // MARK: - Bounds Methods

    /// X value of bounds (bounds.origin.x).
    var boundsX: CGFloat {
        set { self.bounds = CGRect(x: _pixelIntegral(newValue),
                                   y: self.boundsY,
                                   width: self.boundsWidth,
                                   height: self.boundsHeight)
            }
        get { return self.bounds.origin.x }
    }

    /// Y value of bounds (bounds.origin.y).
    var boundsY: CGFloat {
        set { self.frame = CGRect(x: self.boundsX,
                                  y: _pixelIntegral(newValue),
                                  width: self.boundsWidth,
                                  height: self.boundsHeight)
            }
        get { return self.bounds.origin.y }
    }

    /// Width of bounds (bounds.size.width).
    var boundsWidth: CGFloat {
        set { self.frame = CGRect(x: self.boundsX,
                                  y: self.boundsY,
                                  width: _pixelIntegral(newValue),
                                  height: self.boundsHeight)
            }
        get { return self.bounds.size.width }
    }

    /// Height of bounds (bounds.size.height).
    var boundsHeight: CGFloat {
        set { self.frame = CGRect(x: self.boundsX,
                                  y: self.boundsY,
                                  width: self.boundsWidth,
                                  height: _pixelIntegral(newValue))
            }
        get { return self.bounds.size.height }
    }

    // MARK: - Useful Methods

    /// Center view to it's parent view.
//    func centerToParent() {
//        guard let superview = self.superview else { return }
//
//        switch UIApplication.shared.statusBarOrientation {
//            case .landscapeLeft, .landscapeRight:
//                self.origin = CGPoint(x: (superview.height / 2) - (self.width / 2),
//                                      y: (superview.width / 2) - (self.height / 2))
//            case .portrait, .portraitUpsideDown:
//                self.origin = CGPoint(x: (superview.width / 2) - (self.width / 2),
//                                      y: (superview.height / 2) - (self.height / 2))
//            case .unknown:
//                return
//            }
//    }

    // MARK: - Private Methods
    fileprivate func _pixelIntegral(_ pointValue: CGFloat) -> CGFloat {
        let scale = UIScreen.main.scale
        return (round(pointValue * scale) / scale)
    }
}
