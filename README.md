# CDFlipView

A view that takes a set of images, make transition from one to another by using flipping effects.

## Demo
![Screencapture GIF](https://github.com/jibeex/CDFlipView/blob/master/demo.gif)

Live Demo: https://appetize.io/app/w0df4gf2wcaxavadr6zjxf2h1m

[![CI Status](http://img.shields.io/travis/jibeex/CDFlipView.svg?style=flat)](https://travis-ci.org/jibeex/CDFlipView)
[![Version](https://img.shields.io/cocoapods/v/CDFlipView.svg?style=flat)](http://cocoapods.org/pods/CDFlipView)
[![License](https://img.shields.io/cocoapods/l/CDFlipView.svg?style=flat)](http://cocoapods.org/pods/CDFlipView)
[![Platform](https://img.shields.io/cocoapods/p/CDFlipView.svg?style=flat)](http://cocoapods.org/pods/CDFlipView)

## Requirements
Swift 3.0 => v1.0.1

Swift 2.3 => v0.1.1

## Installation

CDFlipView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CDFlipView"
```

or

Put the file `CDFlipView/Classes/CDFlipView.swift` into your project

## Usage

```swift
var imageSet:[UIImageView] = [] // use any object of type UIView

for index in 1...5{
    let image = UIImageView(image: UIImage(named: "\(index)"))
    image.contentMode = .ScaleAspectFill
    imageSet.append(image)
}

flipView.layer.zPosition = 100
flipView.durationForOneTurnOver = 0.6
flipView.stillTime = 0.1
flipView.setUp(imageSet)
flipView.startAnimation()
```

## Example project

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

Jianbin LIN, jibeex@gmail.com

## License

CDFlipView is available under the MIT license. See the LICENSE file for more info.
