//
//  PlayMusicViewController+ContainerTableItems.swift
//  ContainerControllerSwift_Example
//
//  Created by Рустам Мотыгуллин on 01.08.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//


import UIKit
import ContainerControllerSwift
import AVFAudio


extension PlayMusicViewController {
    
    //MARK: - startTimer
    
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: timerUpdateInterval,
                                         repeats: true) { [weak self] _ in
                guard let strongSelf = self else { return }
                main {
                    if !strongSelf.container2Moving {
                        strongSelf.updatePlayerCell()
                    }
                }
            }
        }
    }
    
    //MARK: - stopTimer
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}
