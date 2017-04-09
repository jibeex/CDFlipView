#
# Be sure to run `pod lib lint CDFlipView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CDFlipView"
  s.version          = "1.0.1"
  s.summary          = "A view that takes a set of images, make transition from one to another by using flipping effects."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC

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
                       DESC

  s.homepage         = "https://github.com/jibeex/CDFlipView"
  #s.screenshots      = "https://github.com/jibeex/CDFlipView/blob/master/demo.gif"
  s.license          = 'MIT'
  s.author           = { "jibeex" => "jianbin.lin@live.com" }
  s.source           = { :git => "https://github.com/jibeex/CDFlipView.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/jibeex'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CDFlipView/Classes/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
