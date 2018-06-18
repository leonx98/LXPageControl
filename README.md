# LXPageControl

![Xcode 9.0+](https://img.shields.io/badge/Xcode-9.0%2B-blue.svg)
![iOS 9.0+](https://img.shields.io/badge/iOS-9.0%2B-blue.svg)
![Swift 4.0+](https://img.shields.io/badge/Swift-4.0%2B-orange.svg)
![CocoaPods Compatible](https://img.shields.io/badge/pod-1.0.0-blue.svg)  
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![Platform](https://img.shields.io/badge/platform-ios-lightgray.svg)
[![License][license-image]][license-url]

LXPageControl is a simple PageControl with lines.

![](Screenshots/LXPageControl-Preview.gif)


## Requirements

- Swift 4+
- iOS 9.0+
- Xcode 9+

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `LXPageControl` by adding it to your `Podfile`:

```ruby
pod 'LXPageControl'
```

## Usage

Either you can create the 'LXPageControl' programmatically or via Interface Builder.

Via Interface Builder:<br />
Create a 'UIView' and assign 'LXPageControl' class to it. Customize your Pages within the Xcode Attribute Inspector.

Programmatically:<br />
Create a 'LXPageControl' Instance.

The buttons height are equal to the height of the view.

```swift
let pageControl = LXPageControl()

self.view.addSubview(pageControl)
```

## Additional methods & properties
Public Methods:
```swift
pageControl.set(progress: Int, animated: Bool) // to change the current progress
```

Public Properties:
```swift
pageControl.leftBtn: UIButton // button to decrease progress
pageControl.rightBtn: UIButton // button to increase progress
pageControl.pages: Int // count of Pages
pageControl.elementWidth: CGFloat // width of an element
pageControl.elementHeight: CGFloat // height of an element
pageControl.spacing: CGFloat // spacing between elements
pageControl.inactiveColor: UIColor // color of inactive elements
pageControl.activeColor: UIColor // color of active element
pageControl.cornerRadius: CGLoat // corner radius of the elements
pageControl.fillWidthAutomatically: Bool // determines automatically the width of each element and fill the entire view width depending on the spacing
```

Delegate:
```swift
pageControl.delegate = self
```

Delegate protocol:
```swift
public protocol LXPageControlDelegate {
func pageControl(_ pageControl: LXPageControl, didPressedOn button: UIButton)
func pageControl(_ pageControl: LXPageControl, changeProgress to: Int)
}
```

## Donation

If you like my open source libraries, you can sponsor it! ☺️

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.me/leonx98)

## Author

Leon Hoppe, leonhoppe98@gmail.com

## License

Distributed under the MIT license. See ``LICENSE`` for more information.


[license-image]: https://img.shields.io/badge/License-MIT-green.svg
[license-url]: LICENSE
