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
    
    //MARK: - startMovePlaylistContainer
    
    func startMovePlaylistContainer(_ type: ContainerMoveType) {
        self.container?.move(type: type)
        self.container?.move(type: type)
        main(delay: 0.05) {
            self.container?.move(type: type )
        }
        main(delay: 1.05) {
            self.container?.move(type: type)
        }
    }
    
    //MARK: - createPlaylistContainer
    
    func createPlaylistContainer(position: ContainerPosition,
                               radius: CGFloat,
                               items: [TableAdapterItem]? = nil,
                                 containerColor: UIColor? = nil,
                               addShadow: Bool = false,
                               header: UIView? = nil) {
        
        let layoutC = ContainerLayout()
        layoutC.positions =  position //
        layoutC.insets = .init(right: 0, left: 0)
        let container = ContainerController(addTo: self, layout: layoutC)
        container.view.cornerRadius = radius
        container.view.addShadow()
        container.view.tag = 15
        container.delegate = self
        
        
        if addShadow {
            container.view.layer.shadowOpacity = Float(0.20)
            container.view.layer.shadowOffset = .init(width: 0, height: 13)
            container.view.layer.shadowRadius = 30.0
            container.view.layer.shadowColor = UIColor.black.cgColor
        }
            
        if let header = header { container.add(headerView: header) }
        
        
        
        if let color = containerColor { container.view.backgroundColor = color }
        
        let table = TableAdapterView(frame: CGRect(x: 0, y: 0, width: ContainerDevice.width, height: 0), style: .plain)
        table.indicatorStyle =  .default
        //        container.add(scrollView: addCollectionView())
        
        self.containerTableView = table
        self.container = container
        
        
        
        
        if let items = items {  table.set(items: items) }
        
        container.add(scrollView: table)
        
        containers.append(container)
        
    }
    
    //MARK: - createPlaylistItems
    
    func createPlaylistItems(retro: Bool = false, mix: Bool = false, boris: Bool = false, disco: Bool = false) -> [TableAdapterItem] {
        
        var items: [TableAdapterItem] = []
        
        var types: [ViewCallsPlayerType] = self.musicItems
        if retro {
            types = self.retroItems
        }
        if mix {
            types = self.mixItems
        }
        if boris {
            types = self.borisItems
        }
        if disco {
            types = self.disclosureItems
        }
        
        
//        var types = retro ? self.retroItems : self.musicItems
//        if mix {
//            types = self.mixItems
//        }
        
        types.forEach { type in
            items.append( PlaylistOneItem(state: .init(type: type, radius: 7, handlers: .init(onClickAt: {  [weak self]  selType in
                
                self?.playlistSelectedItem(selType)
                
            }))) )
        }
        return items
    }
    
    //MARK: - playlistSelectedItem
    
    func playlistSelectedItem(_ selType: ViewCallsPlayerType) {
        
        //                self.music(next: type == .right)
        self.updateTableItems(selType)
        
        if (self.container2?.moveType == .bottom) {
            main(delay:0.25) {
                self.container2?.move(type: .top)
            }
        }
        
        if self.count == selType.rawValue { return }
        
        main  {
            self.count = selType.rawValue
            ViewCallsPlayer.shared.stop()
            self.music(play: true, /*updatePlay: true, */next: true)
        }
        
        self.updateCellsPlaylistAllUnselected(selType)
    }
    
    
    func updateTableItems(_ selType: ViewCallsPlayerType) {
        main {
            var newItems: [TableAdapterItem] = []
            
            if selType.retro {
                
                if self.currentMusicSelect != .playlistRetro {
                    self.currentMusicSelect = .playlistRetro
                    
                    newItems = self.createTableItems(  .playlistRetro )
                    self.containerTableView?.set(items: newItems)
                }
                
               
            } else if  selType.mix {
                
                if self.currentMusicSelect != .playlistMix {
                    self.currentMusicSelect = .playlistMix
                    
                    newItems = self.createTableItems(  .playlistMix )
                    self.containerTableView?.set(items: newItems)
                }
                
            } else if  selType.boris {
                
                if self.currentMusicSelect != .playlistBoris {
                    self.currentMusicSelect = .playlistBoris
                    
                    newItems = self.createTableItems(  .playlistBoris )
                    self.containerTableView?.set(items: newItems)
                }
                
            }  else if  selType.disclosure {
                
                if self.currentMusicSelect != .playlistDisclosure {
                    self.currentMusicSelect = .playlistDisclosure
                    
                    newItems = self.createTableItems(  .playlistDisclosure )
                    self.containerTableView?.set(items: newItems)
                }
                
            } else  {
                
                if self.currentMusicSelect != .playlist {
                    self.currentMusicSelect = .playlist
                    
                    
                    newItems = self.createTableItems(  .playlist )
                    self.containerTableView?.set(items: newItems)
                }
                
            }
            
            
            
        }
    }
    
    
}
