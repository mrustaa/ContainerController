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
    
    //MARK: - header Update (open height)
    
    func headerUpdate(open: Bool, height: CGFloat = 54.0, grib: Bool) {
        
        let heightt = open ? height : PlayMusicItGribView.rrect().height
        if  self.container2HeaderView?.height != heightt {
            self.container2HeaderView?.height = heightt
            self.container2?.headerView?.height = heightt
            UIView.animate(withDuration: 0.15) {
                
                self.container2?.calculationViews()
            }
        }
        UIView.animate(withDuration: 0.75) {
            self.container2HeaderView?.grib(visible: !open, open: grib)
        }
        
    }
    
    
    override func containerControllerHandlePan(_ containerController: ContainerController, pan: UIPanGestureRecognizer) {
        
        
        
        if containerController == self.container2, containerController.moveType == .top {
            
            let inViewLocationY: CGFloat = pan.location(in: containerController.view).y
            let inViewVelocityY: CGFloat = pan.velocity(in: containerController.view).y
            let inViewTranslationY: CGFloat = pan.translation(in: containerController.view).y
            
            
            switch pan.state {
            case .began:
                self.container2MovingDelegateAnim = .start
                
                if inViewVelocityY < 0 {
                    self.container2MovingDelegateInViewTop = true
                    self.container2MovingDelegate = true
                } else {
                    self.container2MovingDelegateInViewTop = false
                    self.container2MovingDelegate = false
                }
            case .changed:
                
                
                if self.container2MovingDelegateInViewTop, containerController.view.transform.ty <= 0 {
                    self.container2MovingDelegate = true
                    
                    self.container2?.handleChangeAnimation = false
                    
//                    let result = ScreenSize.height + inViewTranslationY * 1.1
                    
                    if self.container2MovingDelegateAnim == .start {
                        self.container2MovingDelegateAnim = .procces
                        
                        UIView.animate(withDuration: 0.22) {
                        
                            self.container?.move(position: /*result*/ inViewLocationY , animation: false, type: .top, from: .pan, completion: {
                                
                                self.container2MovingDelegateAnim = .ended
                            })
                        }
                    } else if self.container2MovingDelegateAnim == .procces {
                        
                    } else if self.container2MovingDelegateAnim == .ended {
                        self.container?.move(position: /*result*/ inViewLocationY , animation: false, type: .top, from: .pan)
                    }
                    
                    
                } else {
                    self.container2MovingDelegate = false
                    
                    self.container2MovingDelegateAnim = .ended
                    
                    self.container2MovingDelegate = false
                    if self.container?.moveType == .hide {
                        
                        
                        
                    } else {
                        self.container?.move(type: .hide, animation: false)
                    }
                }
                
                
            case .ended:
                
                
                self.container2?.handleChangeAnimation = true
                
                if containerController.view.transform.ty > 0 {
                    
                    self.container2MovingDelegateOff = true
                    self.container?.move(type: .hide)
                    self.container2?.handleEndAnimation = true
                    self.container?.move(type: .hide)
                    
                    
                } else {
                    self.container2?.handleEndAnimation = false
                    
                    main(delay: 0.25) {
                        self.container2?.handleEndAnimation = true
                    }
                    
                    if self.container2MovingDelegateInViewTop {
                        
                        self.container?.move(type: inViewVelocityY < 0 ? .top : .bottom)
                        
                    } else {
                        self.container?.move(type: .bottom)
                    }
                    
                    
                }
                
                
                
            default: break
            }
            
            
            
            
            
            print(" \(containerController.view.tag == 22 ? "PlayMusic 2" : "Playlist -" ) | \(inViewLocationY) | \(containerController.view.transform.ty ) | \(inViewVelocityY) | \(inViewTranslationY) ")
            
            
//            print("container2PPan \(inViewLocationY) | \(containerController.view.transform.ty ) | \(inViewVelocityY) | \(inViewTranslationY) ")
        } else {
            self.container2MovingDelegate = false
        }
        
    }
    
    
    //MARK: - container Move Delegate
    
    override func containerControllerMove(_ containerController: ContainerController, position: CGFloat, type: ContainerMoveType, animation: Bool) {
        
//        if !animation, containerController == self.container2, self.container2?.moveType == .top, position <= 0  {
//            return
//        }
        
        
        if self.container2MovingDelegateOn {
            self.container2MovingDelegateOff = false
            self.container2MovingDelegate = false
            self.container2MovingDelegateOn = false
            
        }
       else  if self.container2MovingDelegateOff {
            self.container2MovingDelegateOff = false
            self.container2MovingDelegate = false
            self.container2MovingDelegateOn = false
            return
        } else if containerController == self.container2, self.container2MovingDelegate {
            return
        }
//        else if  animation, containerController == self.container2, self.container2MovingDelegate {
//            return
//        }
//        
        if  !animation, containerController == self.container2 ||  containerController == self.container {
            
            self.container2Moving = true
            
            if let cell = self.container2TableView?.cellForRow(at: .init(row: 0, section: 0)) as? PlayMusicItCell,
               let cellData = cell.cellData as? PlayMusicItCellData
            //                   let cellData = cell.cellData as? PlayMusicItCellData
            {
                //                    cellData.state.box = self.box
                
                let maxSize: CGFloat = (ScreenSize.width - 50)
                let nimSize: CGFloat = 60
                
                let header:  CGFloat = 87
                let footer:  CGFloat = 98
                let insets:  CGFloat = 19
                
                
                let sum: CGFloat = maxSize + (insets * 3.3) + header
                let topMaxResult = ScreenSize.height - sum + ((containerController == self.container) ? 50 : 0)
                
                let bottom: CGFloat = footer + 22 // + (header / 1.0)
                let bottomMaxResult = ScreenSize.height - bottom
                
                var pos: CGFloat = nimSize
                var sizeHeader: CGFloat = header
                var percent: CGFloat = 1.0
                var percentUn: CGFloat = 0.0
                var minAlpha: CGFloat = 1.0
                
                let resultAllSize = bottomMaxResult - topMaxResult
                let mediumMaxResult = (topMaxResult + (resultAllSize / 2))
                
                
//                let superTopMaxResult: CGFloat = (ScreenSize.height - (sum * 2))
//                var superTopPercent: CGFloat = 1.0
                
                let newPosition = (containerController == self.container) ? (ScreenSize.height - position + 30) : position
                
                if newPosition > bottomMaxResult  {
                    
                    percent = 1.0
                    percentUn = 1.0
                    pos = nimSize
                    sizeHeader = 0.0
                    minAlpha = 1.0
                    
//                    superTopPercent = 0.0
                    
                } else if newPosition > topMaxResult  {
                    
                    if newPosition > mediumMaxResult {
                        
                        let startLevelMini = (newPosition - mediumMaxResult)
                        let percentMini = (startLevelMini / (resultAllSize / 2))

                        minAlpha = percentMini
                    } else {
                        
                        minAlpha = 0.0
                    }
                    
                    let startLevel = (newPosition - topMaxResult)
                    percent = (startLevel / resultAllSize)
                    percentUn = percent
                    
                    pos = ((maxSize * (1.0 - percent)) + (nimSize * percent)) // (ScreenSize.height) - newPosition
                    sizeHeader = (header * (1.0 - percent))
                    
                }
                else {
                    
//                    superTopPercent = 1.0
                    percentUn = 0.0
                    percent = 1.0
                    pos = maxSize
                    sizeHeader = header
                    
                    minAlpha = 0.0
                }
                
                    //
                if (containerController == self.container) {
                    self.container2HeaderView?.firstImageView?.alpha = (1.0 - percentUn)
                    self.container2HeaderView?.secondImageView?.alpha = 0.0
                } else {
                    self.container2HeaderView?.firstImageView?.alpha = 0.0
                    self.container2HeaderView?.secondImageView?.alpha = (1.0 - percentUn)
                }
                    
//                if (containerController == self.container2) {
                    
                if (containerController == self.container) {
                    sizeHeader =  ((header * 0.6) + (sizeHeader * 0.4))
                }
                
                self.container2?.headerView?.height = sizeHeader
                    
//                }
                cellData.state.boxSet = nil
                
//                self.container2?.calculationViews()
                self.container2?.calculationScrollViewHeight()
                cell.miniView.alpha = minAlpha
                cell.subtitleLabel?.alpha = 1.0 - minAlpha
                cell.titleLabel?.alpha = 1.0 - minAlpha
                cell.imageWidth.constant = pos
                cell.imageHeight.constant = pos
                
                let plusAlpha =  (1.0 - percentUn)
                
                let padding = cellData.state.paddingSave
                
                if padding == .zero {
                    
                    cell.firstImageViewBorderPaddingLeft.constant    = 0
                    cell.firstImageViewBorderPaddingTop.constant     = 0
                    cell.firstImageViewBorderPaddingBottom.constant  = 0
                    cell.firstImageViewBorderPaddingRight.constant   = 0
                    
                    cell.firstaImagePaddingLeft.constant = 5
                    cell.firstaImagePaddingRight.constant = 5
                    cell.firstaImagePaddingTop.constant = 5
                    cell.firstaImagePaddingBottom.constant = 5
                } else if padding.horizontal != 0 {
                    let verticalPadding = ((padding.horizontal / 2) * plusAlpha) - 5
                    
                    cell.firstImageViewBorderPaddingTop.constant     = 0
                    cell.firstImageViewBorderPaddingBottom.constant  = 0
                    cell.firstImageViewBorderPaddingLeft.constant    = verticalPadding
                    cell.firstImageViewBorderPaddingRight.constant   = verticalPadding
                    
                    
                    cell.firstaImagePaddingTop.constant =    5
                    cell.firstaImagePaddingBottom.constant = 5
                    cell.firstaImagePaddingLeft.constant =   verticalPadding + 5
                    cell.firstaImagePaddingRight.constant =  verticalPadding + 5
                    
                } else if padding.vertical != 0 {
                    let horizontalPadding = ((padding.vertical / 2) * plusAlpha)  - 5
                    
                    cell.firstImageViewBorderPaddingTop.constant     = horizontalPadding
                    cell.firstImageViewBorderPaddingBottom.constant  = horizontalPadding
                    cell.firstImageViewBorderPaddingLeft.constant    = 0
                    cell.firstImageViewBorderPaddingRight.constant   = 0
                    
                    
                    cell.firstaImagePaddingTop.constant =    horizontalPadding + 5
                    cell.firstaImagePaddingBottom.constant = horizontalPadding + 5
                    cell.firstaImagePaddingLeft.constant =   5
                    cell.firstaImagePaddingRight.constant =  5
                }
                
                
                
                
                
                
                
            }
        }
        
        
//        print(" \(containerController.view.tag == 22 ? "PlayMusic 2" : "Playlist -" ) | position: 🙅 \(position)| moveType: \(type.string()) | animation: \(animation) ")
        
        if  animation {
            
            if containerController == self.container2 {
                
                
                self.container2TableView?.isScrollEnabled = false
                self.container2Moving = false
                
                self.updateCellsPlayMusicViewsAplha()
                
                
                self.headerUpdate(open: type == .bottom, height: 0, grib: type == .top)
                
                //                UIView.animate(withDuration: 2) {
                
                //                    self.headerUpdate(open: type == .bottom )
                
                self.box = type == .bottom
                
                self.updateCellsPlayMusicBox()
                
                //                self.container2?.set(movingEnabled:  ((type == .top) && self.box))
                
                //                }
                main(delay: 0.05) {
                    if type == .bottom {
                        self.container?.move(type: .hide)
                    }
                }
            }
            else if containerController == self.container {
                
                self.container2Moving = false
                
                self.updateCellsPlayMusicViewsAplha()
                
                if type == .top || type == .middle {
                    
                    self.headerUpdate(open: type == .top, height: 54.0, grib: self.container2?.moveType == .top)
                    
                    
                    self.box = type == .top
                    
                    self.updateCellsPlayMusicBox()
                    
                    let moving = !((type == .top) && self.box)
                    self.container2?.set(movingNewEnabled: moving ? .disableScroll :  .disableAll  )
                    
                    //                    if type == .middle {
                    //                        self.container2?.move(type: .bottom)
                    //
                    //                    }
                    //                }
                } else if type == .bottom  {
                    self.box = (self.container2?.moveType == .bottom) || ((self.container2?.moveType == .top) && (type == .top))
                    
                    self.updateCellsPlayMusicBox()
                    
                    if let moveType = self.container2?.moveType {
                        self.headerUpdate(open: moveType == .bottom, height: 0, grib: moveType == .top)
                    }
                    
                    
//                    self.headerUpdate(open: type == .top, height: 54.0, grib: self.container2?.moveType == .top)
                    
                    let moving = !self.box
                    self.container2?.set(movingNewEnabled:  moving ? .disableScroll :  .disableAll   )
                }
                
                
                //
                
                
                
                
            }
        }
    }
}
