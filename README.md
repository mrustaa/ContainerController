![image(Landscape)](https://github.com/mrustaa/gif_presentation/blob/master/ContainerControllerSwift/screenLandscape9.png)

# ContainerController 

[![Version](https://img.shields.io/cocoapods/v/ContainerControllerSwift.svg?style=flat)](https://cocoapods.org/pods/ContainerControllerSwift)
[![License](https://img.shields.io/cocoapods/l/ContainerControllerSwift.svg?style=flat)](https://cocoapods.org/pods/ContainerControllerSwift)
[![Platform](https://img.shields.io/cocoapods/p/ContainerControllerSwift.svg?style=flat)](https://cocoapods.org/pods/ContainerControllerSwift)
[![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat)](https://swift.org/)
[![Swift 5.1](https://img.shields.io/badge/Swift-5.1-orange.svg?style=flat)](https://swift.org/)
[![Swift 5.2](https://img.shields.io/badge/Swift-5.2-orange.svg?style=flat)](https://swift.org/)

UI Component. This is a copy swipe-panel from app: https://www.apple.com/ios/maps/

## Preview
![image](https://github.com/mrustaa/gif_presentation/blob/master/ContainerControllerSwift/maps.gif)
![image](https://github.com/mrustaa/gif_presentation/blob/master/ContainerControllerSwift/examples.gif)
![image(Landscape)](https://github.com/mrustaa/gif_presentation/blob/master/ContainerControllerSwift/mapsLandscape.gif)

<!-- TOC -->

- [Requirements](#requirements)
- [Installation](#installation)
  - [CocoaPods](#cocoapods)
  - [Swift Package Manager with Xcode 11](#swift-package-manager-with-xcode-11)
- [Getting Started](#getting-started)
- [Action](#action)
  - [Move position with an animation](#move-position-with-an-animation)
- [Adding possible custom subviews in ContainerController view](#adding-possible-custom-subviews-in-containercontroller-view)
  - [Add `ScrollView`📃](#add-scrollview)
    - [`Delegate` to self 👆](#delegate-to-self-)
  - [Add `HeaderView`](#add-headerview)
  - [Add `FooterView`](#add-footerview)
  - [Add Custom `View`](#add-custom-view)
- [Settings ⚙️](#settings-)
  - [Layout](#layout)
    - [Customize the layout with create subclass `ContainerLayout` on initialization](#customize-the-layout-with-create-subclass-containerlayout-on-initialization)
    - [Or create object `ContainerLayout`](#or-create-object-containerlayout)
  - [Change settings right away](#change-settings-right-away)
  - [ContainerController `View`](#containercontroller-view)
    - [Use a ready-made solution](#use-a-ready-made-solution)
    - [Change `CornerRadius`](#change-cornerradius)
    - [Add Layer `Shadow`](#add-layer-shadow)
    - [Add Background `Blur`](#add-background-blur)
  - [More details](#more-details)
    - [Change positions on screen Top Middle Bottom](#change-positions-on-screen-top-middle-bottom)
    - [Customize indentations for View](#customize-indentations-for-view)
    - [Customize for landscape orientation](#customize-for-landscape-orientation)
    - [Parameters for control footerView](#parameters-for-control-footerview)
- [ContainerController `Delegate`](#containercontroller-delegate)
- [Author](#author)
- [License](#license)

<!-- /TOC -->

## Requirements 

✏️ ContainerController is written in Swift 5.0+. It can be built by Xcode 11 or later. Compatible with iOS 13.0+.

## Installation 

### CocoaPods

ContainerControllerSwift is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ContainerControllerSwift'
```
### Swift Package Manager with Xcode 11

Follow [this doc](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app).

## Getting Started

```swift

import UIKit
import ContainerControllerSwift

class ViewController: UIViewController, ContainerControllerDelegate {
    
    var container: ContainerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create ContainerController Layout object
        let layout = ContainerLayout()
        layout.startPosition = .hide
        layout.backgroundShadowShow = true
        layout.positions = ContainerPosition(top: 70, middle: 250, bottom: 70)
        
        // Create ContainerController object, along with the container.view
        // Pass the current UIViewController 
        let container = ContainerController(addTo: self, layout: layout)
        container.view.cornerRadius = 15
        container.view.addShadow()
        
        // Create subclass scrollView
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        // Add scrollView to container
        container.add(scrollView: tableView)
        
        // Finishing settings ContainerController,
        // Animated move position Top
        container.move(type: .top)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Remove the subviews ContainerController
        container.remove()
        container = nil
    }
}
```

## Action

### Move position with an animation

```swift

container.move(type: .top)
container.move(type: .middle)
container.move(type: .bottom)

```

## Adding possible custom subviews in ContainerController view

### Add `ScrollView`

```swift 

let tableView = UITableView()
tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
tableView.backgroundColor = .clear
tableView.tableFooterView = UIView()
tableView.delegate = self
tableView.dataSource = self

// Add scrollView to container
container.add(scrollView: tableView)

```


#### `Delegate` to self 👆
#### If you implement delegate ScrollView (TableView, CollectionView, TextView) to `self`, then you need to call 4 functions in ContainerController

```swift
extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        container.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        container.scrollViewWillBeginDragging(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        container.scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        container.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }
}

extension ViewController: UITableViewDelegate {
    ...
}

extension ViewController: UITableViewDataSource {
    ...
}

```

### Add `HeaderView`

```swift

let headerView = ExampleHeaderGripView()
headerView.height = 20

container.add(headerView: headerView)

```

### Add `FooterView`

```swift

let tabBarView = HeaderTabBarView()
tabBarView.height = 49.0

container.add(footerView: tabBarView)

```
### Add Custom `View`

```swift

// Add custom shadow
let layer = container.view.layer
layer.shadowOpacity = 0.5
layer.shadowColor = UIColor.red.cgColor
layer.shadowOffset = CGSize(width: 1, height: 4)
layer.shadowRadius = 5

// Add view in container.view
let viewRed = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
viewRed.backgroundColor = .systemRed
container.view.addSubview(viewRed)

// Add view under scrollView container.view
let viewGreen = UIView(frame: CGRect(x: 25, y: 25, width: 50, height: 50))
viewGreen.backgroundColor = .systemGreen
container.view.insertSubview(viewGreen, at: 0)

```

## Settings ⚙️

### Layout 

#### Customize the layout with create subclass `ContainerLayout` on initialization 

```swift

class NewContainerLayout: ContainerLayout {
    
    override init() {
        super.init()
        
        // Initialization start position.
        startPosition = .hide
        
        // Disables any moving with gestures.
        movingEnabled = true
        
        // Sets the new value for positions of animated movement (top, middle, bottom).
        positions = ContainerPosition(top: 70, middle: 250, bottom: 70)
        
        // Sets insets container.view  (left, right).
        insets = ContainerInsets(right: 20, left: 20)
    }
}

class ViewController: UIViewController {

    var container: ContainerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container = ContainerController(addTo: self, layout: NewContainerLayout())
        container.move(type: .top)
    }
}

```

#### Or create object `ContainerLayout` 

```swift

override func viewDidLoad() {
    super.viewDidLoad()
    
    // Create ContainerController Layout object
    let layout = ContainerLayout()
    layout.startPosition = .hide
    layout.backgroundShadowShow = true
    layout.positions = ContainerPosition(top: 70, middle: 250, bottom: 70)
    
    container = ContainerController(addTo: self, layout: layout)
}

```

### Change settings right away


```swift

// Properties
container.set(movingEnabled: true)
container.set(trackingPosition: false)
container.set(footerPadding: 100)

// Add ScrollInsets Top/Bottom
container.set(scrollIndicatorTop: 5) // ↓
container.set(scrollIndicatorBottom: 5) // ↑

// Positions
container.set(top: 70) // ↓
container.set(middle: 250) // ↑
container.set(bottom: 80) // ↑

// Middle Enable/Disable
container.set(middle: 250)
container.set(middle: nil)

// Background Shadow
container.set(backgroundShadowShow: true)

// Insets View
container.set(left: 5) // →
container.set(right: 5) // ←

// Landscape params
container.setLandscape(top: 30)
container.setLandscape(middle: 150)
container.setLandscape(bottom: 70)
container.setLandscape(middle: nil)

container.setLandscape(backgroundShadowShow: false)

container.setLandscape(left: 10)
container.setLandscape(right: 100)

```

## ContainerController `View`

#### Use a ready-made solution

`ContainerView` is generated automatically when you create ContainerController
Use a ready-made solution to change the radius, add shadow, and blur.

#### Change `CornerRadius`

```swift
// Change cornerRadius global for all subviews
container.view.cornerRadius = 15 
```
#### Add Layer `Shadow`

```swift
container.view.addShadow(opacity: 0.1) 
```
#### Add Background `Blur`

```swift
// add blur UIVisualEffectView
container.view.addBlur(style: .dark) 

```

### More details

#### Change positions on screen Top Middle Bottom

```swift

// These parameters set the new position value.
container.layout.positions = ContainerPosition(top: 70, middle: 250, bottom: 70)

// Change settings right away
container.set(top: 70) // ↓
container.set(middle: 250) // ↑
container.set(bottom: 80) // ↑

```

#### Customize indentations for View

```swift

// Sets insets container.view  (left, right).
container.layout.insets = ContainerInsets(right: 20, left: 20)

container.layout.landscapeInsets = ContainerInsets(right: 20, left: 100)


// Change settings right away
container.set(left: 5) // →
container.set(right: 5) // ←

container.setLandscape(left: 10)
container.setLandscape(right: 100)

```

#### Customize for landscape orientation

```swift

// Sets the background shadow under container. (Default: backgroundShadowShow).
container.layout.landscapeBackgroundShadowShow = false

// Sets the new value for positions of animated movement (top, middle, bottom). (Default: positions).
container.layout.landscapePositions = ContainerPosition(top: 20, middle: 150, bottom: 70)

// Sets insets container.view (left, right). (Default: insets).
container.layout.landscapeInsets = ContainerInsets(right: 20, left: 100)


// Change settings right away

container.setLandscape(top: 30)
container.setLandscape(middle: 150)
container.setLandscape(bottom: 70)
container.setLandscape(middle: nil)

container.setLandscape(backgroundShadowShow: false)

container.setLandscape(left: 10)
container.setLandscape(right: 100)

```

#### Parameters for control footerView

```swift

// Padding-top from container.view, if headerView is added, then its + height is summed.
container.layout.footerPadding = 100

// Tracking position container.view during animated movement.
container.layout.trackingPosition = false

// Change settings right away

container.set(footerPadding: 100)
container.set(trackingPosition: false)

```

![image](https://github.com/mrustaa/gif_presentation/blob/master/ContainerControllerSwift/footerPadding.gif)
![image](https://github.com/mrustaa/gif_presentation/blob/master/ContainerControllerSwift/trackingPosition.gif)

## ContainerController `Delegate`

```swift

class ViewController: UIViewController, ContainerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let container = ContainerController(addTo: self, layout: layout)
        container.delegate = self
    }
}

/// Reports rotation and orientation changes
func containerControllerRotation(_ containerController: ContainerController) {
    ...
}

/// Reports a click on the background shadow
func containerControllerShadowClick(_ containerController: ContainerController) {
    ...
}

/// Reports the changes current position of the container, after its use
func containerControllerMove(_ containerController: ContainerController, position: CGFloat, type: ContainerMoveType, animation: Bool) {
    ...
}

```

## Author

<motionrustam@gmail.com> 📩| [mrustaa](https://github.com/mrustaa/) JUNE 2020

## License

ContainerController is available under the MIT license. See the LICENSE file for more info.

