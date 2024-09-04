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
    
    //MARK: - music Stop
    
    func musicStop() {
        
        ViewCallsPlayer.shared.stop()
    }
    
    //MARK: - music (next:
    
    func music(next: Bool) {
        
        if self.count == 0 {
            ViewCallsPlayer.shared.stop()
            ViewCallsPlayer.shared.play(  .none )
            ViewCallsPlayer.shared.pause()
        }
        
        
//        let typee = ViewCallsPlayerType(rawValue: self.count) ?? .none
        
        var min = 0
        var max = 0
        currentMusicItems.enumerated().forEach {
            if $0 == 0 { min = $1.rawValue }
            else if $0 == (currentMusicItems.count - 1) { max = $1.rawValue }
        }
        
        
        if next {
            self.count = self.count + 1
            if self.count > max {
                self.count = min
            }
        } else if !next {
            self.count = self.count - 1
            if self.count < min {
                self.count = max
            }
        }
        
        
        ViewCallsPlayer.shared.stop()
        //        let typee = ViewCallsPlayerType(rawValue: self.count) ?? .disclosure_you_me
        //        if typee == .none {
        //            ViewCallsPlayer.shared.stop()
        //        } else {
        //            ViewCallsPlayer.shared.play(  typee )
        //        }
    }
    
    //MARK: - music (play update next)
    
    func music(play: Bool, updatePlay: Bool? = nil, next: Bool = false, interval: CGFloat? = nil) {
        if play {
            let typee = ViewCallsPlayerType(rawValue: self.count) ?? .none
            
            if next { ViewCallsPlayer.shared.play(  typee ) }
            else if let _ = interval {
                //                ViewCallsPlayer.shared.play(interval: interval)
                //                ViewCallsPlayer.shared.play()
                //                ViewCallsPlayer.shared.avPlayer?.currentTime = interval
            }
            else { ViewCallsPlayer.shared.play() }
            
            
            if let u = updatePlay {
                self.updatePlayerCell(play: u)
            }
            
            self.startTimer()
            
        } else {
            
            if let u = updatePlay {
                self.updatePlayerCell(play: u)
            }
            
            ViewCallsPlayer.shared.pause()
            
            
            self.stopTimer()
        }
    }
    
    //MARK: - updatePlayerCell play
    
    func updatePlayerCell(play: Bool? = nil) {
//        let typee = ViewCallsPlayerType(rawValue: self.count) ?? .none
        
        
        
        let t1 =  (ViewCallsPlayer.shared.avPlayer?.duration ?? 0)
        let t2 =  (ViewCallsPlayer.shared.avPlayer?.currentTime ?? 0)
        
        if t1 < (t2 + 0.5) {
            self.music(next: true)
            self.music(play: true, next: true)
            
            return
        }
        
        if (t1 == 0 && t2 == 0) {
            ViewCallsPlayer.shared.stop()
            self.stopTimer()
            //            self.music(play: true, next: true)
            //            ViewCallsPlayer.shared.play(  typee )
            //            self.startTimer()
            
            return
            
        }
        else if t1 == t2 {
            self.music(next: true)
            self.music(play: true, next: true)
            
            return
        }
        
        self.updateCellsPlayMusicAvPlayerTimerSet(play: play)
    
    }
    
}
