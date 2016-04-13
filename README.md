# CDFlipView

A view that takes a set of images, make transition from one to another by using flipping effects.

### Demo
![Screencapture GIF](https://github.com/jibeex/CDFlipView/blob/master/demo.gif)

Live Demo: https://appetize.io/app/w0df4gf2wcaxavadr6zjxf2h1m


### How to install

Put the file `CDFlipView/CDFlipView.swift` into your project

### How to use

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

