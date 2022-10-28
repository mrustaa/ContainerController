//
//  ContainerController.swift
//  PatternsSwift
//
//  Created by mrustaa on 21/04/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

#if arch(x86_64) || arch(arm64)

import UIKit
import SwiftUI

@available(iOS 13.0, *)
open class ContainerController: NSObject {
    
    // MARK: Views
    
    public var view: ContainerView!
    
    public var shadowButton: UIButton!
    
    public var controller: UIViewController?
    
    public var scrollView: UIScrollView?
    
    public var headerView: UIView?
    
    public var footerView: UIView?
    
    public var hostingController: UIHostingController<AnyView>?
    
    // MARK: Layout
    
    public var layout: ContainerLayout = ContainerLayout()
    
    // MARK: Delegate
    
    public var delegate: ContainerControllerDelegate?
    
    // MARK: Current Move Type
    
    public var moveType: ContainerMoveType = .hide
    
    public var oldMoveType: ContainerMoveType = .hide
    
    // MARK: - Properties Scroll
    
    private var oldTransform: CGAffineTransform = .identity
    
    private var oldPosition: CGFloat = 0.0
    
    private var panGesture: UIPanGestureRecognizer?
    
    private var panBeginSavePosition: CGFloat = 0.0
    
    private var oldOrientation: ContainerDevice.Orientation = ContainerDevice.orientation
    
    private var isScrolling: Bool = false
    
    private var scrollBordersRunContainer: Bool = false
    
    private var scrollOnceBeginDragging: Bool = false
    
    private var scrollOnceEnded: Bool = false
    
    private var scrollBegin: Bool = false
    
    private var scrollStartPosition: CGFloat = 0.0
    
    private var scrollTransform = CGAffineTransform.identity
    
    // MARK: - Properties Position
        
    public var topBarHeight: CGFloat {
        var result: CGFloat = 0.0
        if let vc = controller?.navigationController, !vc.isNavigationBarHidden {
            let statusBarHeight: CGFloat = ContainerDevice.statusBarHeight
            let navBarHeight: CGFloat = vc.navigationBar.frame.height
            result = statusBarHeight + navBarHeight
        }
        return result
    }
    
    public var topTranslucent: Bool {
        return controller?.navigationController?.navigationBar.isTranslucent ?? false
    }
    
    private var isPortrait: Bool {
        return ContainerDevice.isPortrait
    }
    
    private var deviceHeight: CGFloat {
        var height: CGFloat = 0.0
        if isPortrait {
            height = ContainerDevice.screenMax
        } else {
            height = ContainerDevice.screenMin
        }
        height -= topBarHeight
        return height
    }
    
    private var deviceWidth: CGFloat {
        var width: CGFloat = 0.0
        if isPortrait {
            width = ContainerDevice.screenMin
        } else {
            width = ContainerDevice.screenMax
        }
        return width
    }
    
    // MARK: - Positions Move
    
    private var positionTop: CGFloat {
        var top = layout.positions.top
        if !isPortrait {
            if let landscape = layout.landscapePositions {
                top = landscape.top
            }
        }
        return top
    }
    
    public var positionMiddle: CGFloat {
        var middle = layout.positions.middle ?? layout.positions.bottom
        if !isPortrait {
            if let landscapeMid = layout.landscapePositions?.middle {
                middle = landscapeMid
            }
        }
        return deviceHeight - middle
    }
    
    private var positionBottom: CGFloat {
        var bottom = layout.positions.bottom
        if !isPortrait {
            if let landscape = layout.landscapePositions {
                bottom = landscape.bottom
            }
        }
        return deviceHeight - bottom
    }
    
    private var insetsLeft: CGFloat {
        var left: CGFloat = layout.insets.left
        if !isPortrait {
            if let inset = layout.landscapeInsets {
                left = inset.left
            }
        }
        return left
    }
    
    private var insetsRight: CGFloat {
        var right: CGFloat = layout.insets.right
        if !isPortrait {
            if let inset = layout.landscapeInsets {
                right = inset.right
            }
        }
        return right
    }
    
    private var middleEnable: Bool {
        if isPortrait {
            return layout.positions.middle != nil
        } else {
            if let landscapePositions = layout.landscapePositions {
                return landscapePositions.middle != nil
            } else {
                return layout.positions.middle != nil
            }
        }
    }
    
    // MARK: - Init
    
    public init(addTo controller: UIViewController, layout: ContainerLayout) {
        super.init()
        
        self.controller = controller
        set(layout: layout)
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        createShadowButton()
        createContainerView()
        
        move(type: layout.startPosition, animation: false)
    }
    
    // MARK: - Remove
    
    public func remove(completion: (() -> Void)? = nil) {
        
        NotificationCenter.default.removeObserver(self)
        
        move(type: .hide, completion:
            
            {  [weak self] in
            guard let _self = self else { return }

            _self.scrollView?.removeFromSuperview()
            _self.headerView?.removeFromSuperview()
            _self.footerView?.removeFromSuperview()
            _self.shadowButton.removeFromSuperview()
            _self.view.removeFromSuperview()

            completion?()
        })
    }
    
    // MARK: - Rotated
    
    @objc func rotated() {
        
        if !UIDevice.current.orientation.isRotateAllowed { return }
        
        if ContainerDevice.orientation == oldOrientation { return }
        oldOrientation = ContainerDevice.orientation
        
        shadowHiddenCheck()
        
        delegate?.containerControllerRotation(self)
        
        calculationView()
        calculationScrollViewHeight(from: .rotation)
        
        move(type: moveType, from: .rotation)
    }
    
    // MARK: - Update Layout
    
    public func set(layout: ContainerLayout) {
        self.layout = layout
        calculationViews()
    }
    
    // MARK: Set
    
    public func set(movingEnabled: Bool) {
        layout.movingEnabled = movingEnabled
        scrollView?.isScrollEnabled = movingEnabled
        panGesture?.isEnabled = movingEnabled
    }
    
    public func set(trackingPosition: Bool) {
        layout.trackingPosition = trackingPosition
    }
    
    public func set(footerPadding: CGFloat) {
        layout.footerPadding = footerPadding
        calculationViews()
    }
    
    // MARK: Scroll Insets
    
    public func set(scrollIndicatorTop: CGFloat) {
        layout.scrollIndicatorInsets = UIEdgeInsets(top: scrollIndicatorTop, left: 0, bottom: layout.scrollIndicatorInsets.bottom, right: 0)
        calculationViews()
    }
    
    public func set(scrollIndicatorBottom: CGFloat) {
        layout.scrollIndicatorInsets = UIEdgeInsets(top: layout.scrollIndicatorInsets.top, left: 0, bottom: scrollIndicatorBottom, right: 0)
        calculationViews()
    }
    
    public func set(scrollInsetsTop: CGFloat) {
        layout.scrollInsets = UIEdgeInsets(top: scrollInsetsTop, left: 0, bottom: layout.scrollInsets.bottom, right: 0)
        calculationViews()
    }
    
    public func set(scrollInsetsBottom: CGFloat) {
        layout.scrollInsets = UIEdgeInsets(top: layout.scrollInsets.top, left: 0, bottom: scrollInsetsBottom, right: 0)
        calculationViews()
    }
    
    // MARK: Portrait
    
    public func set(top: CGFloat) {
        layout.positions.top = top
    }
    
    public func set(middle: CGFloat?) {
        layout.positions.middle = middle
    }
    
    public func set(bottom: CGFloat) {
        layout.positions.bottom = bottom
    }
    
    public func set(right: CGFloat) {
        layout.insets.right = right
        if isPortrait { calculationViews() }
    }
    
    public func set(left: CGFloat) {
        layout.insets.left = left
        if isPortrait { calculationViews() }
    }
    
    public func set(backgroundShadowShow: Bool) {
        layout.backgroundShadowShow = backgroundShadowShow
        if isPortrait { move(type: moveType) }
    }
    
    // MARK: Landscape
    
    public func updateLandscapeLayout() {
        if layout.landscapePositions == nil {
            layout.landscapePositions = ContainerPosition.zero
        }
        if layout.landscapeInsets == nil {
            layout.landscapeInsets = ContainerInsets.zero
        }
    }
    
    public func setLandscape(top: CGFloat) {
        updateLandscapeLayout()
        layout.landscapePositions?.top = top
    }
    
    public func setLandscape(middle: CGFloat?) {
        updateLandscapeLayout()
        layout.landscapePositions?.middle = middle
    }
    
    public func setLandscape(bottom: CGFloat) {
        updateLandscapeLayout()
        layout.landscapePositions?.bottom = bottom
    }
    
    public func setLandscape(right: CGFloat) {
        updateLandscapeLayout()
        layout.landscapeInsets?.right = right
        if !isPortrait { calculationViews() }
    }
    
    public func setLandscape(left: CGFloat) {
        updateLandscapeLayout()
        layout.landscapeInsets?.left = left
        if !isPortrait { calculationViews() }
    }
    
    public func setLandscape(backgroundShadowShow: Bool) {
        layout.landscapeBackgroundShadowShow = backgroundShadowShow
        if !isPortrait { move(type: moveType) }
    }
    
    
    // MARK: - Create Shadow-Button
    
    private func createShadowButton() {
        shadowButton = UIButton(frame: CGRect(x: 0, y: 0, width: ContainerDevice.screenMax, height: ContainerDevice.screenMax))
        shadowButton.isUserInteractionEnabled = false
        shadowButton.backgroundColor = .black
        shadowButton.alpha = 0.0
        shadowButton.addTarget(self, action: #selector(shadowButtonAction), for: .touchUpInside)
        controller?.view.addSubview(shadowButton)
    }
    
    @objc private func shadowButtonAction() {
        delegate?.containerControllerShadowClick(self)
    }
    
    // MARK: - Create Container-View
    
    private func createContainerView() {
        let frame = CGRect(x: 0, y: 0, width: deviceWidth, height: deviceHeight * 2)
        view = ContainerView(frame: frame)
        view.backgroundColor = .systemBackground
        controller?.view.addSubview(view)
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        panGesture?.isEnabled = layout.movingEnabled
        if let panGesture = panGesture {
            view.addGestureRecognizer(panGesture)
        }
    }
    
    // MARK: - Add Header
    
    public func removeHeaderView() {
        if let headerView = self.headerView {
            headerView.removeFromSuperview()
        }
        headerView = nil
        calculationViews()
    }
    
    public func add(headerView: UIView) {
        removeHeaderView()
        self.headerView = headerView
        view.contentView?.addSubview(headerView)
        calculationViews()
    }
    
    // MARK: - Add Footer
    
    public func removeFooterView() {
        if let footerView = self.footerView {
            footerView.removeFromSuperview()
        }
        footerView = nil
        calculationViews()
    }
    
    public func add(footerView: UIView) {
        removeFooterView()
        self.footerView = footerView
        controller?.view.addSubview(footerView)
        calculationViews()
    }
    
    // MARK: - Add ScrollView
    
    public func removeScrollView() {
        if let scroll = self.scrollView {
            scroll.removeFromSuperview()
        }
        scrollView = nil
        calculationViews()
    }
    
    public func add(scrollView: UIScrollView) {
        removeScrollView()
        self.scrollView = scrollView
        
        scrollView.isScrollEnabled = layout.movingEnabled
        scrollView.autoresizingMask = [.flexibleLeftMargin,
                                       .flexibleWidth,
                                       .flexibleRightMargin,
                                       .flexibleTopMargin,
                                       .flexibleHeight,
                                       .flexibleBottomMargin]
        
        scrollView.isScrollEnabled = (moveType == .top)
        
        if scrollView.delegate == nil {
            scrollView.delegate = self
        }
        
        if let tableAdapterView = scrollView as? TableAdapterView {
            tableAdapterView.delegate = self
            tableAdapterView.dataSource = self
        }

        if let collectionAdapterView = scrollView as? CollectionAdapterView {
            collectionAdapterView.delegate = self
            collectionAdapterView.dataSource = self
        }
        
        view.contentView?.addSubview(scrollView)
        calculationViews()
    }
    
    // MARK: - Add SwiftUI View
    
    public func removeSwiftUIView() {
        self.hostingController?.willMove(toParent: nil)
        self.hostingController?.view.removeFromSuperview()
        self.hostingController?.removeFromParent()
        self.hostingController = nil
    }
    
    public func add<V: View>(swiftUIView: V, parentViewController: UIViewController? = nil) {
        guard let contentView = self.view.contentView else {
            return
        }
        removeSwiftUIView()
        let hostingController = UIHostingController(rootView: AnyView(swiftUIView))
        self.hostingController = hostingController
        let parent = parentViewController ?? self.controller
        parent?.addChild(hostingController)
        hostingController.view.frame = contentView.bounds
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(hostingController.view)
        hostingController.didMove(toParent: parent)
    }
    
    // MARK: - Pan Gesture
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        
        view.layer.removeAllAnimations()
        scrollView?.layer.removeAllAnimations()
        
        switch gesture.state {
        case .began:
            
            panBeginSavePosition = view.transform.ty
            
        case .changed:
            
            var transform = view.transform
            transform.ty = (panBeginSavePosition + gesture.translation(in: view).y)
            
            if transform.ty < 0 {
                
                transform.ty = (positionTop / 2)
                
            } else if transform.ty < positionTop {
                
                transform.ty = ((positionTop / 2) + (transform.ty / 2))
            }
            
            let position = transform.ty
            let type: ContainerMoveType = moveType
            let from: ContainerFromType = .pan
            let animation = false
            
            changeView(transform: transform)
            shadowLevelAlpha(position: position, animation: false)
            changeFooterView(position: position)
            calculationScrollViewHeight(from: from)
            changeMove(position: position, type: type, animation: animation)
            
        case .ended:
            
            let velocityY = gesture.velocity(in: view).y
            
            let type = calculatePositionTypeFrom(velocity: velocityY)
            
            move(type: type, animation: true, velocity: velocityY, from: .pan)
            
        default: break
        }
    }
    
    
    // MARK: - Calculation Views Size
    
    public func calculationViews() {
        calculationView()
        calculationScrollViewHeight()
    }
    
    private func calculationView() {
        guard let view = view else { return }
        
        let x: CGFloat = insetsLeft
        let width: CGFloat = (deviceWidth - insetsRight - insetsLeft)
        
        view.frame.origin.x = x
        view.frame.size.width = width
        view.frame.size.height = deviceHeight * 2
        
        if let headerView = headerView {
            headerView.frame.origin.x = 0.0
            headerView.frame.origin.y = 0.0
            headerView.frame.size.width = width
        }
        
        if let footerView = footerView {
            footerView.frame.origin.x = x
            footerView.frame.size.width = width
            changeFooterView()
        }
    }
    
    // MARK: - Calculation ScrollView Size
    
    private func calculationScrollViewHeight(position: CGFloat = -1.0,
                                             animation: Bool = false,
                                             from: ContainerFromType = .custom,
                                             velocity: CGFloat = 0.0,
                                             moveType: ContainerMoveType = .custom,
                                             moveTypeOld: ContainerMoveType = .custom) {
        
        guard let scrollView = scrollView else { return }
        scrollView.layer.removeAllAnimations()
        
        let headerHeight: CGFloat = headerView?.frame.height ?? 0.0
        
        var footerInsets: CGFloat = 0.0
        if let footerView = footerView {
            footerInsets = deviceHeight - footerView.frame.origin.y
        }
        
        var scrollInsetsBottom: CGFloat = ContainerDevice.isIphoneXBottom
        if scrollInsetsBottom < footerInsets {
            scrollInsetsBottom = 0.0
        }
        
        let top: CGFloat = layout.scrollInsets.top
        let bottom: CGFloat = layout.scrollInsets.bottom + scrollInsetsBottom
        
        let indicatorTop: CGFloat = layout.scrollIndicatorInsets.top
        let indicatorBottom: CGFloat = layout.scrollIndicatorInsets.bottom + scrollInsetsBottom
        
        var containerViewPositionY: CGFloat = 0.0
        if position == -1.0 {
            containerViewPositionY = view.transform.ty
        } else {
            containerViewPositionY = position
        }
        
        let width: CGFloat = (deviceWidth - insetsRight - insetsLeft)
        var height: CGFloat = (deviceHeight - (headerHeight + footerInsets + containerViewPositionY))
        
        if height < 0 {
            height = 0
        }
        
        if animation ,
            !isScrolling,
            footerView == nil,
            oldPosition < position,
            ((moveType == .middle) && (0 < velocity)) || (moveType == .bottom) {
            
            height = scrollView.frame.height
        }
        
        scrollView.frame = CGRect(x: 0, y: headerHeight, width: width, height: height)
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: indicatorTop , left: 0, bottom: indicatorBottom, right: 0)
        scrollView.contentInset = UIEdgeInsets(top: top, left: 0, bottom: bottom, right: 0)
    }
    
    // MARK: - Position-Type From Velocity
    
    private func calculatePositionTypeFrom(velocity: CGFloat) -> ContainerMoveType {
        
        var type: ContainerMoveType
        
        let position = view.transform.ty
                
        if middleEnable {
        
            if position < positionTop { /// <<< (70 Top)
                
                if 750 < velocity {
                    
                    if 2500 < velocity {
                        type = .bottom /// ↓↓↓
                    } else {
                        type = .middle /// ↓
                    }
                    
                } else {
                    type = .top /// Default
                }
                
            } else if position > positionBottom { /// (300 Bottom) >>>
                
                if velocity < -750 {
                    
                    if velocity < -2000 {
                        type = .top /// ↑↑↑
                    } else {
                        type = .middle /// ↑
                    }
                    
                } else {
                    type = .bottom /// Default
                }
                
            } else {
                
                let centerMiddleTop = (((positionMiddle - positionTop) / 2) + positionTop)
                let centerBottomMiddle = (((positionBottom - positionMiddle) / 2) + positionMiddle)
                
                if position < centerMiddleTop { /// ↑↑↑ top   ...70
                    
                    if 150 < velocity {
                        
                        if 2500 < velocity {
                            type = .bottom /// ↓↓↓
                        } else {
                            type = .middle /// ↓
                        }
                        
                    } else {
                        type = .top /// Default
                    }
                    
                } else if position < centerBottomMiddle { /// ---
                    
                    if velocity < 0 {
                        
                        if velocity < -150 {
                            type = .top /// ↑↑↑
                        } else {
                            type = .middle /// ↑
                        }
                        
                    } else {
                        
                        if 150 < velocity {
                            type = .bottom /// ↓↓↓
                        } else {
                            type = .middle /// ↓
                        }
                    }
                    
                } else { /// ↓↓↓
                    
                    if velocity < -150 {
                        
                        if velocity < -2000 {
                            type = .top /// ↑↑↑
                        } else {
                            type = .middle /// ↑
                        }
                        
                    } else {
                        type = .bottom /// Default
                    }
                }
            }
            
            
        } else {
            
            if position < positionTop { /// <<< (70 Top)
                
                if 750 < velocity {
                    type = .bottom /// ↓↓↓
                } else {
                    type = .top /// Default
                }
                
            } else if position > positionBottom { /// (300 Bottom) >>>
                
                if velocity < -750 {
                    type = .top /// ↑↑↑
                } else {
                    type = .bottom /// Default
                }
                
            } else { /// (pos 150) -  Center    top...!...bottom
                
                /// (((300 - 70 = 230) / 2 = 115) + 70) = 185
                
                let centerTopBottom = (((positionBottom - positionTop) / 2) + positionTop)
                
                if position < centerTopBottom { /// ↑↑↑
                    
                    if 150 < velocity {
                        type = .bottom
                    } else {
                        type = .top /// Default
                    }
                    
                } else { /// ↓↓↓
                    
                    if velocity < -150 {
                        type = .top
                    } else {
                        type = .bottom /// Default
                    }
                }
            }
        }
        return type
    }
    
    // MARK: - Move
    
    public func move(type: ContainerMoveType,
                     animation: Bool = true,
                     velocity: CGFloat = 0.0,
                     from: ContainerFromType = .custom,
                     completion: (() -> Void)? = nil) {
        
        let position = positionMoveFrom(type: type)
        
        move(position: position,
             animation: animation,
             type: type,
             velocity: velocity,
             from: from,
             completion: completion)
    }
    
    // MARK: - Move Position
    
    public func positionMoveFrom(type: ContainerMoveType) -> CGFloat {
        
        switch type {
        case .top: return positionTop
        case .middle:
            if !middleEnable { return positionBottom }
            else { return positionMiddle }
        case .bottom: return positionBottom
        case .hide: return deviceHeight
        case .custom: return 0.0
        }
    }
    
    // MARK: - Move Animtaion
    
    private var displayVelocity: CGFloat = 0.0
    
    public func move(position: CGFloat,
                     animation: Bool,
                     type: ContainerMoveType,
                     velocity: CGFloat = 0.0,
                     from: ContainerFromType,
                     completion: (() -> Void)? = nil) {
        
        if layout.movingEnabled {
            scrollView?.isScrollEnabled = (type == .top)
        } else {
            scrollView?.isScrollEnabled = false
        }
        
        displayVelocity = velocity
        
        oldMoveType = moveType
        let oldMove = moveType
        moveType = type
        
        shadowLevelAlpha(position: position, animation: true)
        
        let transform = CGAffineTransform(translationX: 0, y: position)
        
        let animationComp = { [weak self] in
            guard let _self = self else { return }
            
            _self.changeView(transform: transform)
            if !_self.layout.trackingPosition {
                _self.changeFooterView(position: position)
                _self.calculationScrollViewHeight(position: position, animation: animation, from: from, velocity: velocity, moveType: type, moveTypeOld: oldMove)
            }
            _self.changeMove(position: position, type: type, animation: true)
        }
        
        if animation {
            
            animationSpringFrom(force: velocity, type: type, animation: animationComp, completion: completion)
            
        } else {
            
            changeFooterView(position: position)
            changeView(transform: transform)
            calculationScrollViewHeight(position: position, animation: animation, from: from, velocity: velocity, moveType: type, moveTypeOld: oldMove)
            changeMove(position: position, type: type, animation: false)
            
            completion?()
        }
    }
    
    // MARK: - Tracking Position
    
    @objc func animationDidUpdate(displayLink: CADisplayLink) {
        guard layout.trackingPosition else { return }
        guard let presentationLayer = self.view.layer.presentation() else { return }
        
        let position = presentationLayer.frame.origin.y
        changeFooterView(position: position)
        calculationScrollViewHeight(position: position, from: .tracking, velocity: displayVelocity, moveType: moveType, moveTypeOld: oldMoveType)
    }
    
    private func changeView(transform: CGAffineTransform) {
        oldPosition = view.frame.origin.y
        oldTransform = view.transform
        view.transform = transform
    }
    
    private func changeMove(position: CGFloat,
                            type: ContainerMoveType,
                            animation: Bool) {
        
        delegate?.containerControllerMove(self, position: position, type: type, animation: animation)
    }
    
    //MARK: - Shadow Alpha Level
    
    func shadowLevelAlpha(position: CGFloat,
                          animation: Bool) {
        
        if animation {
            animationSpring(duration: 0.45) { [weak self] in
                guard let _self = self else { return }
                _self.shadowLevelAlpha(positionY: position)
            }
        } else {
            shadowLevelAlpha(positionY: position)
        }
    }
    
    func animationSpring(duration: CGFloat = 0.45, animations: @escaping () -> Void) {
        UIView.animate(withDuration: TimeInterval(duration),
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 6.0,
                       options: [.allowUserInteraction],
                       animations: animations,
                       completion: nil)
        
    }
    
    func shadowHiddenCheck() {
        
        if isPortrait {
            shadowButton.isHidden = !layout.backgroundShadowShow
        } else {
            if let landscapeShadowShow = layout.landscapeBackgroundShadowShow {
                shadowButton.isHidden = !landscapeShadowShow
            } else {
                shadowButton.isHidden = !layout.backgroundShadowShow
            }
        }
    }
    
    func shadowLevelAlpha(positionY: CGFloat) {
        
        shadowHiddenCheck()
        
        let alphaMax: CGFloat = 0.45
        
        if positionY < positionTop {

            shadowButton.alpha = alphaMax
            
        } else if positionY < positionMiddle {
            let m = positionMiddle - positionTop
            let p = positionY - positionTop
            let percent = (1.0 - (p / m))
            let result = percent * alphaMax
            
            shadowButton.alpha = result
        } else {
            shadowButton.alpha = 0.0
        }
        
    }
    
    //MARK: - Change FooterView Position
    
    func changeFooterView(position: CGFloat? = nil) {
        guard let footer = footerView else { return }
        
        let pos = position ?? positionMoveFrom(type: moveType)
        
        let header = headerView?.frame.height ?? 0.0
        let rr = deviceHeight - header - footer.frame.height
        let result = ((rr - pos) - layout.footerPadding)
        
        let footerViewPositionDefault = (deviceHeight - footer.frame.height)
        
        if result < 0 {
            footer.frame.origin.y = (footerViewPositionDefault + (result * (-1)))
        } else {
            footer.frame.origin.y = footerViewPositionDefault
        }
        
    }
    
    // MARK: - Animation Spring + Force
    
    func animationSpringFrom(force: CGFloat,
                             type: ContainerMoveType,
                             animation: @escaping (() -> Void),
                             completion: (() -> Void)? = nil) {
        
        var velocity: CGFloat = 0
        let transformY = view.transform.ty
        
        if type == .top {
            
            if force < 0 {
                velocity = force * (-1)
            }
            
        } else if type == .bottom {
            
            velocity = force
            
        } else if type == .middle {
            
            if force < 0 {
                velocity = force * (-1)
            } else {
                velocity = force
            }
        }
        
        velocity = velocity / 10000
        velocity = velocity * 300
        
        
        if type == .top {
            
            if (transformY - positionTop) < 0 {
                velocity = velocity * (-1)
            }
            
        } else if type == .bottom {
            
            if 0 < (transformY - positionBottom) {
                velocity = velocity * (-1)
            }
        }
        
        var positionY: CGFloat = 0
        
        if type == .top {
            positionY = (transformY - positionTop)
        } else if type == .bottom {
            positionY = (transformY - positionBottom)
        } else if type == .middle {
            positionY = (transformY - positionMiddle)
        } else if type == .hide {
            positionY = (transformY - deviceHeight)
        }
        
        if positionY < 0 {
            positionY = positionY * (-1)
        }
        
        var damping: CGFloat = 0.75
        var duration: CGFloat = 0.65
        
        let percent = (1.0 - (transformY / deviceHeight))
        
         if 350 < positionY { /// 350...
            
            velocity = (velocity * percent) / 3.5
            
            if 6.5...13.5 ~= velocity {
                if velocity < 9.0 {
                    velocity = 6.5
                } else {
                    velocity = 13.5
                }
            }
            
            damping = 0.8
            duration = 0.45
            
         } else if 200 < positionY { /// 200...350
            
            velocity = (velocity * percent) / 2.0
            
            if 6.5...13.5 ~= velocity {
                if velocity < 9.0 {
                    velocity = 6.5
                } else {
                    velocity = 13.5
                }
            }
            
            damping = 0.8
            duration = 0.45
            
        } else if 150 < positionY { /// 150...200
            
            damping = 0.7
            duration = 0.55
            
            velocity = (velocity * percent) / 2.5
            
            if 4.7...8.6 ~= velocity {
                if velocity < 6.5 {
                    velocity = 8.6
                } else {
                    velocity = 4.7
                }
            }
            
        } else if 100 < positionY { /// 100...150
            
            velocity = (velocity * percent) / 2.0
            
        } else if 50 < positionY { /// 50...100
            
            velocity = velocity / 1.5
            
        } else if 25 < positionY { /// 25...50
            
            // velocity = velocity * 1.5
            
        } else if 10 < positionY { /// 10...25
            
            velocity = velocity * 1.5
            
        } else { /// ...10

            velocity = velocity * 3.0
            
        }
        
        if duration == 0.65, damping == 0.75 {
            if 4.3...7.4 ~= velocity {
                if velocity < 5.85 {
                    velocity = 7.4
                } else {
                    velocity = 4.3
                }
            }
        }
        
        var displayLink: CADisplayLink?
        if layout.trackingPosition {
            displayLink = CADisplayLink(target: self, selector: #selector(animationDidUpdate))
            displayLink?.preferredFramesPerSecond = 60
            displayLink?.add(to: .main, forMode: .default)
        }
        
        UIView.animate( withDuration: TimeInterval(duration),
                        delay: 0.0,
                        usingSpringWithDamping: damping,
                        initialSpringVelocity: velocity,
                        options: [ .allowUserInteraction ],
                        animations: animation,
                        completion: { _ in
                            
                            if let displayLink = displayLink {
                                displayLink.invalidate()
                            }
                            completion?()
        })
        
    }
}

// MARK: - Gesture Delegate

@available(iOS 13.0, *)
extension ContainerController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
}

// MARK: - Table Delegate

@available(iOS 13.0, *)
extension ContainerController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let tableAdapterView = scrollView as? TableAdapterView {
            return tableAdapterView.tableView(tableView, heightForRowAt: indexPath)
        }
        return 0
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let tableAdapterView = scrollView as? TableAdapterView {
            return tableAdapterView.tableView(tableView, didSelectRowAt: indexPath)
        }
    }

}

// MARK: - Table DataSource

@available(iOS 13.0, *)
extension ContainerController: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableAdapterView = scrollView as? TableAdapterView {
            return tableAdapterView.tableView(tableView, numberOfRowsInSection: section)
        }
        return 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tableAdapterView = scrollView as? TableAdapterView {
            return tableAdapterView.tableView(tableView, cellForRowAt: indexPath)
        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if let tableAdapterView = scrollView as? TableAdapterView {
            return tableAdapterView.tableView(tableView, canEditRowAt: indexPath)
        }
        return false
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if let tableAdapterView = scrollView as? TableAdapterView {
            return tableAdapterView.tableView(tableView, commit: editingStyle, forRowAt: indexPath)
        }
    }
}

// MARK: - Collection Delegate

@available(iOS 13.0, *)
extension ContainerController: UICollectionViewDelegate {

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let collectionAdapterView = scrollView as? CollectionAdapterView {
            collectionAdapterView.collectionView(collectionView, didSelectItemAt: indexPath)
        }
    }

}

// MARK: - Collection DataSource

@available(iOS 13.0, *)
extension ContainerController: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let collectionAdapterView = scrollView as? CollectionAdapterView {
            return collectionAdapterView.collectionView(collectionView, numberOfItemsInSection: section)
        }
        return 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let collectionAdapterView = scrollView as? CollectionAdapterView {
            return collectionAdapterView.collectionView(collectionView, cellForItemAt: indexPath)
        }
        return UICollectionViewCell()
    }
}

// MARK: - Collection DelegateFlowLayout

@available(iOS 13.0, *)
extension ContainerController: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let collectionAdapterView = scrollView as? CollectionAdapterView {
            return collectionAdapterView.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
        }
        return CGSize.zero
    }
}

// MARK: - Scroll Delegate

@available(iOS 13.0, *)
extension ContainerController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if let tableAdapterView = scrollView as? TableAdapterView {
            tableAdapterView.scrollViewDidScroll(tableAdapterView)
        }
        
        let gesture: UIPanGestureRecognizer = scrollView.panGestureRecognizer
        
        let inViewVelocityY: CGFloat = gesture.velocity(in: controller?.view).y
        let inViewTranslationY: CGFloat = gesture.translation(in: controller?.view).y
        
        if gesture.state != .possible, scrollView.contentOffset.y <= 0 {
            scrollView.showsVerticalScrollIndicator = false
            scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: 0)
        } else {
            scrollView.showsVerticalScrollIndicator = true
        }
        
        if scrollView.contentOffset.y == 0, 0 < inViewVelocityY {
            scrollBordersRunContainer = true
        } else {
            scrollBordersRunContainer = false
        }
        
        scrollTransform = view.transform
        
        let top: CGFloat = positionTop
        
        if gesture.state == .ended {
            scrollOnceBeginDragging = false
        }
        
        if scrollBordersRunContainer {
            
            view.layer.removeAllAnimations()
            
            scrollOnceEnded = false
            scrollOnceBeginDragging = false
            
            scrollTransform.ty = ((top - scrollStartPosition) + inViewTranslationY)
            
            if scrollTransform.ty < top {
                scrollTransform.ty = top
            }
            
            if scrollBegin {
                
                animationSpring(duration: 0.325) { [weak self] in
                    guard let _self = self else { return }
                    _self.changeView(transform: _self.scrollTransform)
                }
                
                scrollBegin = false
                
            } else {
                changeView(transform: scrollTransform)
            }
            
            let position = scrollTransform.ty
            let type: ContainerMoveType = .top
            let from: ContainerFromType = .scrollBorder
            let animation = false
            
            shadowLevelAlpha(position: position, animation: false)
            changeFooterView(position: position)
            calculationScrollViewHeight(from: from)
            changeMove(position: position, type: type, animation: animation)
            
            if gesture.state == .ended {
                move(type: moveType, animation: true, velocity: inViewVelocityY, from: from)
            }
            
        } else {
            
            if top == scrollTransform.ty, !scrollOnceBeginDragging {
                scrollOnceBeginDragging = true
            }
            
            if top < scrollTransform.ty {
                
                if inViewVelocityY < 0.0 {
                    
                    if moveType == .top {
                        scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: 0)
                    }
                    
                    scrollTransform = view.transform
                    scrollTransform.ty = (top - scrollStartPosition) + inViewTranslationY
                    
                    if scrollTransform.ty < top {
                        scrollTransform.ty = top
                    }
                    
                    let position = scrollTransform.ty
                    let type: ContainerMoveType = .top
                    let from: ContainerFromType = .scroll
                    let animation = false
                    
                    changeView(transform: scrollTransform)
                    shadowLevelAlpha(position: position, animation: false)
                    changeFooterView(position: position)
                    calculationScrollViewHeight(from: from)
                    changeMove(position: position, type: type, animation: animation)
                }
            }
        }
    }
    
    // MARK: - Scroll Begin/End Dragging
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isScrolling = true
        
        scrollStartPosition = scrollView.contentOffset.y
        
        scrollBegin = true
        
        if scrollStartPosition < 0 {
            scrollStartPosition = 0.0
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        isScrolling = false
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if !decelerate {
           isScrolling = false
        }
        
        let gesture: UIPanGestureRecognizer = scrollView.panGestureRecognizer
        
        let inViewVelocityY: CGFloat = gesture.velocity(in: controller?.view).y
        
        if !scrollOnceEnded {
            scrollOnceEnded = true
            
            let type = calculatePositionTypeFrom(velocity: inViewVelocityY)
            
            move(type: type, velocity: inViewVelocityY)
        }
    }
    
}

#endif

