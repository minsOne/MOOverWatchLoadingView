# MOOverWatchLoadingView
[![License](https://img.shields.io/cocoapods/l/DOFavoriteButton.svg?style=flat)](https://github.com/minsOne/MOOverWatchLoadingView/blob/master/LICENSE)

Animation like OverWatch Loading written in Swift.

![Demo](https://raw.githubusercontent.com/minsOne/MOOverWatchLoadingView/master/resource/demo.gif)

## Requirements
* iOS 7.0+
* Swift 2.2

## Installation
#### Manual

You just drag MOOverWatchLoadingView.swift to your project.

## How to use
#### Create a View
```swift
let loadingViewFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
var loadingView: MOOverWatchLoadingView(frame: loadingViewFrame, autoStartAnimation: true)
self.view.addSubview(loadingView)
```

## Demo
You can see demo project and playground. PlayGround show MOOverWatchLoadingView animation.

## Credit/Inspiration
MOOverWatchLoadingView was inspired by [DOFavoriteButton](https://github.com/okmr-d/DOFavoriteButton) and [OverWatch](https://playoverwatch.com)

## License
This software is released under the MIT License.
