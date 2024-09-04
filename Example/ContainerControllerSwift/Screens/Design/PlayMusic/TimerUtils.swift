//
//  TimerUtils.swift
//  irbis
//
//  Created by lan on 08.10.2021.
//  Copyright © 2021 &#1048;&#1058;&#1057;&#1086;&#1092;&#1090;. All rights reserved.
//

import Foundation

class TimerControl {
    var running: Bool { timer != nil }
    private var timer: Timer?
    private var ti: TimeInterval
    private var repeats: Bool
    private var target: Any?
    private var selector: Selector?
    private(set) var startTime: Date?

    
    init(_ ti: TimeInterval, repeats: Bool = true) {
        self.ti = ti
        self.repeats = repeats
    }
    
    init(_ ti: TimeInterval, repeats: Bool = true, target: Any, selector: Selector) {
        self.ti = ti
        self.repeats = repeats
        self.target = target
        self.selector = selector
    }
    
    func start(_ block: @escaping (Timer) -> Void) {
        stop()
        startTime = Date()
        timer = Timer.scheduledTimer(withTimeInterval: ti, repeats: repeats, block: block)
    }
    
    func start(target : Any, selector : Selector) {
        stop()
        startTime = Date()
        timer = Timer.scheduledTimer(timeInterval: ti, target: target, selector: selector, userInfo: nil, repeats: repeats)
    }
    
    func start() {
        guard let target = target, let selector = selector else { return }
        start(target: target, selector: selector)
    }

    func stop() {
        guard let _ = timer else { return }
        startTime = nil
        timer?.invalidate()
        timer = nil
    }
}

extension TimerControl {
    static func start(ti: TimeInterval, repeats: Bool, block: @escaping (Timer) -> Void) -> TimerControl {
        let timerControl = TimerControl(ti, repeats: repeats)
        timerControl.start(block)
        return timerControl
    }
    static func start(ti: TimeInterval, repeats: Bool, target : Any, selector : Selector) -> TimerControl {
        let timerControl = TimerControl(ti, repeats: repeats)
        timerControl.start(target: target, selector: selector)
        return timerControl
    }
}
