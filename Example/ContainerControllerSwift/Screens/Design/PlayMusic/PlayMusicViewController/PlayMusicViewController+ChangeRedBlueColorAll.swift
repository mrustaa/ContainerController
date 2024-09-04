//
//  PlayMusicViewController+ChangeRedBlueColorAll.swift
//  ContainerControllerSwift_Example
//
//  Created by Рустам Мотыгуллин on 01.08.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import ContainerControllerSwift
import AVFAudio


extension PlayMusicViewController {
    
    func changeRedBlueColorAll(red: Bool) { 
        
        guard self.redColor != red else { return }
        
        self.redColor = red
        
        
        self.updateCellsRed()
    }
    
}
