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
    
    
    //MARK: - createPlayPanelContainer
    
    func createPlayPanelContainer(
        position: ContainerPosition,
        radius: CGFloat,
        items: [TableAdapterItem]? = nil,
        containerColor: UIColor? = nil,
        addBackShadow: Bool = false,
        scrollInsets: UIEdgeInsets? = nil,
        header: UIView? = nil,
        footer: UIView? = nil,
        back: UIView? = nil) {
        
        let ccc2 = addContainer(position: position, radius: radius, items: items, delegate: self, addBackShadow: addBackShadow, header: header, back: back)
        
        self.container2TableView = ccc2.1
        self.container2 = ccc2.0
            
            self.container2?.set(movingNewEnabled: .disableScroll)
            
//            self.container2?.delegate = self
             
        self.container2TableView?.didScrollCallback = {
            
            
//            if let table = self.container2TableView, let container2 = self.container2 {
//                self.containerControllerHandlePan(container2, pan: table.panGestureRecognizer)
//            }
            
                
            
        }
            
            self.container2?.view.tag = 22
        if let color = containerColor {  self.container2?.view.backgroundColor = color }
        
        if let scrollInsets = scrollInsets { self.container2?.layout.scrollInsets = scrollInsets }
        
        containers.append(ccc2.0)
    }
    
    //MARK: - startMovePlayPanelContainer
    
    func startMovePlayPanelContainer(_ type: ContainerMoveType) {
        
        self.container2?.move(type: type)
        main(delay: 0.15) {
            self.container2?.move(type: type)
        }
        self.container2?.move(type: type)
        
        
        main(delay: 1.05) {
            self.container2?.move(type: type)
//            self.updateCellsRed()
        }
        
    }
    
    
    //MARK: - createPlayPanelItems
    
    func createPlayPanelItems() -> [TableAdapterItem] {
        
        var items2: [TableAdapterItem] = []
        items2.append( PlayMusicItItem(state: .init(handlers: .init(
            onPlayAt: {  [weak self] play in
                self?.music(play: play)
            }, onFastForwardAt: { [weak self] type in
                
                self?.music(next: type == .right)
                self?.music(play: true, /*updatePlay: true,*/ next: true)
                
                main {
                    let selType = ViewCallsPlayerType(rawValue: self?.count ?? 0) ?? .none
                    self?.updateCellsPlaylistAllUnselected(selType)
                }
                
            }, onMoreAt: {  [weak self] ttype in
                
                
                self?.updateTableItems(ttype)
                self?.container?.move(type: .top)
                
                
                
            }, onClickAt: {  [weak self] in
                
//                let moving = self?.container2Moving ?? false
                
//                if !moving {
                
                main(delay: 0.4) {
                    self?.container2?.move(type: .top)
                    
                    self?.container?.move(type: .hide)
                }
//                }
            }, onTimeAt: { time in
                //                self.stopTimer()
                //                self.music(play: false)
                
                //                self.music(play: true, interval: time)
            }, onRedColorAt: {  [weak self] red in
                
                self?.changeRedBlueColorAll(red: red)
                
                
            }))) )
        
        return items2
    }
    
}
