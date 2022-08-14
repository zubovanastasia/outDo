//
//  ScheduledTimer.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import Foundation

class ScheduledTimer {
    
    private var timer: Timer?
    private var completion: (() -> Void)?
    
    func start(delay: TimeInterval, completion: @escaping () -> Void) {
        stop()
        self.completion = completion
        timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(onTimer), userInfo: nil, repeats: false)
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        self.completion = nil
    }
    
    @objc private func onTimer() {
        completion?()
        stop()
    }
}
