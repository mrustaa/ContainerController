//
//  UIButton+Extention.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 06.11.2021.
//  Copyright © 2021 mrusta. All rights reserved.
//

import UIKit

class Button: UIButton {
    
    var onPressed: (() -> Void)?
    var onReleased: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        addTarget(self, action: #selector(self.pressed), for: .touchDown)
        addTarget(self, action: #selector(self.released), for: .touchUpInside)
        addTarget(self, action: #selector(self.released), for: .touchUpOutside)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }
    
    @objc func setup() {}
    
    @objc func pressed() {
        onPressed?()
    }
    
    @objc func released() {
        onReleased?()
    }
}

/// Simple tap implementation
typealias Closure = () -> ()


class ClosureSleeve {
    let closure: Closure
    init(_ closure: @escaping Closure) {
        self.closure = closure
    }
    @objc func invoke () {
        closure()
    }
}

extension UIControl {
    func tap(for controlEvents: UIControl.Event = .touchUpInside,
             _ closure: @escaping Closure) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self,
                                 String(format: "[%d]", arc4random()),
                                 sleeve,
                                 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}

