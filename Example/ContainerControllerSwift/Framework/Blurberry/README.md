# Blurberry

Transparent blur using UIVisualEffectView without subclassing.

![GIF Demo](https://github.com/unboxme/Blurberry/blob/master/Resources/demo.gif)

[[video demo]](https://vimeo.com/457206677)

[[appetize demo]](https://appetize.io/app/u2udhgwh0cgm12at0rmgjxtphr)

## Features
- Based on UIVisualEffectView
- Supports **iOS 14** and animation blocks
- Super safe and super easy

## Usage

Just create a `UIVisualEffectView` in any way. Code, storyboards, XIBs, etc.

Customize it like example bellow via `blur` wrapper:
```swift
visualEffectView.blur.radius = 5.0
visualEffectView.blur.tintColor = .clear
```

Don't forget to set a `tintColor` value, otherwise it will be 30% white like `UIBlurEffect.Style.Light` by default.

## Installation

### Cocoapods

Add the Blurberry pod to your Podfile:
```ruby
platform :ios, '10.0'

use_frameworks!

target 'BlurryApp' do
  pod 'Blurberry' 
end
```

## Next Steps

- [x] iOS 10, 11, 12 support
- [ ] Other platform support (such as macOS)
- [ ] Remove ObjC code or make it private
- [ ] Add manager to check blur availability and other service info
- [ ] Hide private API class names, method names, etc.

## Disclaimer

This framework uses private API, so just keep in mind it before submitting to the AppStore.

## Requirements

- iOS 10.0+
- Swift 5
