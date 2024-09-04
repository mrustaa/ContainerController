//
//  PlayMusicViewController+UpdateCells.swift
//  ContainerControllerSwift_Example
//
//  Created by Рустам Мотыгуллин on 05.08.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//


import UIKit
import ContainerControllerSwift
import AVFAudio


extension PlayMusicViewController {
    
    
    //MARK: - upd Background Start Anim
    
    func updateCellsBackgroundStartShowAnimation() {
        
        if let visibleCells = self.tableView?.visibleCells {
            visibleCells.forEach { itemCell1 in
                itemCell1.alpha = 0.0
            }
        }
        
        if let visibleCells = self.tableView?.visibleCells {
            background {
                visibleCells.forEach { itemCell1 in
                    Thread.sleep(forTimeInterval: 0.25)
                    main {
                        UIView.animate(withDuration: 0.75) {
                            itemCell1.alpha = 1.0
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - upd PlayMusic Box Set
    
    func updateCellsPlayMusicBox() {
        
        if let cell = self.container2TableView?.cellForRow(at: .init(row: 0, section: 0)) as? PlayMusicItCell,
           let cellData = cell.cellData as? PlayMusicItCellData {
            
            if let stateBox = cellData.state.boxSet {
                if stateBox != self.box {
                    cellData.state.box = self.box
                }
            } else {
                cellData.state.box = self.box
            }
            
            cell.updateImage()
        }
    }
    
    //MARK: - upd PlayMusic ViewsAplha
    
    func updateCellsPlayMusicViewsAplha() {
        
        if let cell = self.container2TableView?.cellForRow(at: .init(row: 0, section: 0)) as? PlayMusicItCell {
            
            if self.container?.moveType == .hide {
                /// в top   container2    .top  или .bottom
                cell.miniView.alpha = self.container2?.moveType == .top ? 0.0 : 1.0
            }
            if self.container?.moveType == .top {
                /// в top   container2 всегда .top box
                cell.miniView.alpha = 1.0
            }
            if self.container?.moveType == .middle {
                /// в middle  container2 всегда .top !box
                cell.miniView.alpha = 0.0
            }
            
            cell.subtitleLabel?.alpha =  self.container2?.moveType == .bottom ? 0.0 : 1.0
            cell.titleLabel?.alpha    =  self.container2?.moveType == .bottom ? 0.0 : 1.0
        }
    }
    
    //MARK: - upd PlayMusic Player Timer
    
    func updateCellsPlayMusicAvPlayerTimerSet(play: Bool? = nil) {
        
        let typee = ViewCallsPlayerType(rawValue: self.count) ?? .none
        
        let t1 =  (ViewCallsPlayer.shared.avPlayer?.duration ?? 0)
        let t2 =  (ViewCallsPlayer.shared.avPlayer?.currentTime ?? 0)
        
        
        let vol = AVAudioSession.sharedInstance().outputVolume
        let time =  String(format: "%02d:%02d", ((Int)((t2))) / 60, ((Int)((t2))) % 60 )
        
        if let cell = self.container2TableView?.cellForRow(at: .init(row: 0, section: 0)) as? PlayMusicItCell {
            
            if let stateBox = cell.data?.state.boxSet {
                if stateBox != self.box {
                    cell.data?.state.box = self.box
                }
            } else {
                cell.data?.state.box = self.box
            }
            
            //            cell.data?.state.box = self.box
            cell.data?.state.paddingSave = .zero
            cell.data?.state.type = typee
            cell.data?.state.duration = t1
            cell.data?.state.currentTime = t2
            cell.data?.state.volume = vol
            cell.data?.state.time = time
            if let play = play {
                cell.data?.state.play = play
            }
            cell.data?.state.play = true
            cell.updateImage()
        }
        
        main {
            
            self.containerTableView?.visibleCells.enumerated().forEach {
                if let cell = $1 as? PlaylistOneCell,
                   let cellData = cell.cellData as? PlaylistOneCellData,
                   cellData.state.selectted || cellData.state.type == typee {
                    cellData.state.selectted = true
                    cellData.state.durationTime = time
                    cell.updateDuration()
                    cell.updateSelected()
                }
            }
            
            self.tableView?.visibleCells .enumerated().forEach {
                if let cell = $1 as? PlaylistOneCell, let cellData = cell.cellData as? PlaylistOneCellData, cellData.state.selectted || cellData.state.type == typee {
                    cellData.state.selectted = true
                    cellData.state.durationTime = time
                    cell.updateDuration()
                    cell.updateSelected()
                }
                
                if let cell = $1 as? BuyStockOneCell, let cellData = cell.cellData as? BuyStockOneCellData,  cellData.state.selectted ||   cellData.state.musicType == typee {
                    cellData.state.selectted = true
                    cellData.state.durationTime = time
                    cell.updateDuration()
                    cell.updateSelected()
                }
            }
            
        }
        
    }
    
    //MARK: - upd Playlist All Unselected
    
    func updateCellsPlaylistAllUnselected(_ selType: ViewCallsPlayerType) {
        
        
        self.tableView?.items.enumerated().forEach {
            
            if let cellData = $1.cellData as? PlaylistOneCellData {
                cellData.state.redColor = self.redColor
                if cellData.state.type != selType {
                    cellData.state.selectted = false
                    cellData.state.durationTime = nil
                }
            }
            if let cellData = $1.cellData as? BuyStockOneCellData {
                cellData.state.redColor = self.redColor
                if cellData.state.musicType != selType {
                    cellData.state.selectted = false
                    cellData.state.durationTime = nil
                }
            }
            
            if let cell = self.tableView?.cellForRow(at: .init(row: $0, section: 0)) as? PlaylistOneCell,
               let cellData = cell.cellData as? PlaylistOneCellData
            {
                cellData.state.redColor = self.redColor
                if cellData.state.type != selType {
                    cellData.state.selectted = false
                    cellData.state.durationTime = nil
                    cell.updateDuration()
                    cell.updateSelected()
                }
            }
            
            if let cell = self.tableView?.cellForRow(at: .init(row: $0, section: 0)) as? BuyStockOneCell,
               let cellData = cell.cellData as? BuyStockOneCellData
            {
                cellData.state.redColor = self.redColor
                if cellData.state.musicType != selType {
                    cellData.state.selectted = false
                    cellData.state.durationTime = nil
                    cell.updateDuration()
                    cell.updateSelected()
                }
            }
        }
        
        self.containerTableView?.items.enumerated().forEach {
            if let cellData = $1.cellData as? PlaylistOneCellData {
                cellData.state.redColor = self.redColor
                if cellData.state.type != selType {
                    cellData.state.selectted = false
                    cellData.state.durationTime = nil
                }
            }
            
            if let cell = self.tableView?.cellForRow(at: .init(row: $0, section: 0)) as? PlaylistOneCell,
               let cellData = cell.cellData as? PlaylistOneCellData
            {
                cellData.state.redColor = self.redColor
                if cellData.state.type != selType {
                    cellData.state.selectted = false
                    cellData.state.durationTime = nil
                    cell.updateDuration()
                    cell.updateSelected()
                }
            }
        }
        
//        if let visibleCells = self.containerTableView?.visibleCells {
//            visibleCells.forEach {
//                if let cell = $0 as? PlaylistOneCell, let cellData = cell.cellData as? PlaylistOneCellData {
//                    cellData.state.redColor = self.redColor
//                    if cellData.state.type != selType {
//                        cellData.state.selectted = false
//                        cellData.state.durationTime = nil
//                        cell.updateDuration()
//                        cell.updateSelected()
//                        
//                    }
//                }
//            }
//        }
    }
    
    
    //MARK: - upd All Cells RedStyle
    
    func updateCellsRed() {
        
        //            self.tableView?.visibleCells.forEach { itemCell1 in
        //                if let cell = itemCell1 as? MyCardsCollectionCell  {
        //                    cell.collectionView.items.enumerated().forEach { iC, itemColl1 in
        //                        if let cell = itemColl1 as? PlayMusicCatalogItem, let cellData = cell.cellData as? PlayMusicCatalogCellData {
        //                            cellData.state.redColor = red
        //                        }
        //                    }
        //                }
        
        //                if let cell = itemCell1 as? SportCatalogFilterCell {
        //                    cell.collectionView.items.enumerated().forEach { iC, itemColl1 in
        //                        if let cellItem = itemColl1 as? SportTagSizeColorItem, let cellTagsData = cellItem.cellData as? SportTagSizeColorCellData {
        //                            cellTagsData.state.selecttedColor = self.redColor ? .playMusicColor :
        //                                .playlistColor
        //
        //                            if let cellTag = cell.collectionView.cellForItem(at: .init(row: iC, section: 0)) as? SportTagSizeColorCell {
        //                                cellTag.updateColor()
        //                            }
        //                        }
        //                    }
        //                }
        //            }
        
        self.tableView?.items.enumerated().forEach { i, item1 in
            
            if let _ = item1 as? MyCardsCollectionItem {
                if let cell = self.tableView.cellForRow(at: .init(row: i, section: 0)) as? MyCardsCollectionCell {
                    cell.collectionView.items.enumerated().forEach { iC, itemColl1 in
                        if let cellItem = itemColl1 as? PlayMusicCatalogItem,
                           let cellTagsData = cellItem.cellData as? PlayMusicCatalogCellData {
                            cellTagsData.state.redColor = self.redColor
                            
                            
                            if let cellTag = cell.collectionView.cellForItem(at: .init(row: iC, section: 0)) as? PlayMusicCatalogCell {
                                cellTag.updateRed()
                            }
                        }
                    }
                }
            }
            
            
            if let _ = item1 as? SportCatalogFilterItem {
                if let cell = self.tableView.cellForRow(at: .init(row: i, section: 0)) as? SportCatalogFilterCell {
                    cell.collectionView.items.enumerated().forEach { iC, itemColl1 in
                        if let cellItem = itemColl1 as? SportTagSizeColorItem,
                            let cellTagsData = cellItem.cellData as? SportTagSizeColorCellData {
                            cellTagsData.state.selecttedColor = self.redColor ? .playMusicColor :
                                .playlistColor
                            
                            if let cellTag = cell.collectionView.cellForItem(at: .init(row: iC, section: 0)) as? SportTagSizeColorCell,
                               let cellTagsData = cellTag.cellData as? SportTagSizeColorCellData {
                                cellTagsData.state.selecttedColor = self.redColor ? .playMusicColor :
                                    .playlistColor
                                
                                cellTag.updateColor()
                            }
                        }
                    }
                    cell.collectionView.reloadSections(.init(integer: 0))
                }
                self.tableView.reloadRows(at: [.init(row: i, section: 0)], with: .fade)
                
            }
            
            if let item = item1 as? BuyStockOneItem, let cellData = item.cellData as? BuyStockOneCellData {
                cellData.state.redColor = self.redColor
                if let cell = self.tableView.cellForRow(at: .init(row: i, section: 0)) as? BuyStockOneCell {
                    cell.updateSelected()
                }
            }
            
            if let item = item1 as? PlaylistTitleItem, let cellData = item.cellData as? PlaylistTitleCellData {
                cellData.state.redColor = self.redColor
                if let cell = self.tableView.cellForRow(at: .init(row: i, section: 0)) as? PlaylistTitleCell {
                    cell.updateSelected()
                }
            }
        }
        
        
        self.containerTableView?.items.enumerated().forEach { i, item1 in
            if let item = item1 as? PlaylistTitleItem, let cellData = item.cellData as? PlaylistTitleCellData {
                cellData.state.redColor = self.redColor
                
                if let cell = self.containerTableView?.cellForRow(at: .init(row: i, section: 0)) as? PlaylistTitleCell {
                    cell.updateSelected()
                }
                
            }
            if let cellData = item1.cellData as? PlaylistOneCellData {
                cellData.state.redColor = self.redColor
                
                if let cell = self.containerTableView?.cellForRow(at: .init(row: i, section: 0)) as? PlaylistOneCell,
                   let cellDataa = cell.cellData as? PlaylistOneCellData {
                    cellDataa.state.redColor = self.redColor
                    cell.updateSelected()
                }
            }
        }
        
        
        if let header = self.container?.headerView as? PlaylistHeaderView {
            header.updateSelected(red: self.redColor)
        }
        
        //        if let visibleCells = self.containerTableView?.visibleCells {
        //            visibleCells.forEach {
        //                if let cell = $0 as? PlaylistOneCell, let cellData = cell.cellData as? PlaylistOneCellData {
        //                    cellData.state.redColor = red
        //                    cell.updateSelected()
        //                }
        //            }
        //        }
        
        
    }
    
    
    func step1() {
        
        
        
        
        UIView.animate(withDuration: 1, animations: {
            
            
            if let cell = self.container2TableView?.cellForRow(at: .init(row: 0, section: 0)) as? PlayMusicItCell {
                cell.miniProgressTimeView.alpha = 0
                cell.miniProgressTimeView2.alpha = 1
            }
            
            
            if let header = self.container?.headerView as? PlaylistHeaderView {
                header.ccardView?.alpha = 0
                header.ccardView2?.alpha = 1
            }
            
            
            
            
            self.containerTableView?.visibleCells.enumerated().forEach {
                if let cell = $1 as? PlaylistOneCell {
                    cell.blue = !self.redColor
                    cell.updateSelected()
                }
            }
            
            self.tableView?.items.enumerated().forEach { i, item1 in
                if let item = item1 as? PlaylistOneItem, let  _ = item.cellData as? PlaylistOneCellData {
                    if let cell = self.tableView.cellForRow(at: .init(row: i, section: 0)) as? PlaylistOneCell {
                        cell.blue = !self.redColor
                        cell.updateSelected()
                    }
                }
                if let item = item1 as? PlaylistTitleItem, let _ = item.cellData as? PlaylistTitleCellData {
                    if let cell = self.tableView.cellForRow(at: .init(row: i, section: 0)) as? PlaylistTitleCell {
                        cell.ccardView3?.alpha = 1
                    }
                }
                if let _ = item1 as? SportCatalogFilterItem {
                    if let cell = self.tableView.cellForRow(at: .init(row: i, section: 0)) as? SportCatalogFilterCell {
                        cell.collectionView.items.enumerated().forEach { iC, itemColl1 in
                            if let cellTag = cell.collectionView.cellForItem(at: .init(row: iC, section: 0)) as? SportTagSizeColorCell {
                                cellTag.iconImageView?.alpha = 0
                                cellTag.iconImageView2?.alpha = 1
                            }
                        }
                    }
                }
            }
            
            
        }) { _ in
            main {
                self.step2()
            }
        }
    }
    
    func step2() {
        
        
        
        UIView.animate(withDuration: 1, animations: {
            
            if let cell = self.container2TableView?.cellForRow(at: .init(row: 0, section: 0)) as? PlayMusicItCell {
                cell.miniProgressTimeView.alpha = 1
                cell.miniProgressTimeView2.alpha = 0
            }
            
            
            if let header = self.container?.headerView as? PlaylistHeaderView {
                header.ccardView?.alpha = 1
                header.ccardView2?.alpha = 0
            }
            
            
            
            
            
            self.containerTableView?.visibleCells.enumerated().forEach {
                if let cell = $1 as? PlaylistOneCell {
                    cell.blue = !self.redColor
                    cell.updateSelected()
                }
            }
            
            
            self.tableView?.items.enumerated().forEach { i, item1 in
                if let item = item1 as? PlaylistOneItem, let  _ = item.cellData as? PlaylistOneCellData {
                    if let cell = self.tableView.cellForRow(at: .init(row: i, section: 0)) as? PlaylistOneCell {
                        cell.blue = !self.redColor
                        cell.updateSelected()
                    }
                }
                if let item = item1 as? PlaylistTitleItem, let _ = item.cellData as? PlaylistTitleCellData {
                    if let cell = self.tableView.cellForRow(at: .init(row: i, section: 0)) as? PlaylistTitleCell {
                        cell.ccardView3?.alpha = 0
                    }
                }
                if let _ = item1 as? SportCatalogFilterItem {
                    if let cell = self.tableView.cellForRow(at: .init(row: i, section: 0)) as? SportCatalogFilterCell {
                        cell.collectionView.items.enumerated().forEach { iC, itemColl1 in
                            if let cellTag = cell.collectionView.cellForItem(at: .init(row: iC, section: 0)) as? SportTagSizeColorCell {
                                cellTag.iconImageView?.alpha = 1
                                cellTag.iconImageView2?.alpha = 0
                            }
                        }
                    }
                }
            }
            
        }) { _ in
            main {
                self.step1()
            }
        }
    }
    
}
