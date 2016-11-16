//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

var str = "Hello, playground"

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
containerView.backgroundColor = .white
PlaygroundPage.current.liveView = containerView

let v = MOOverWatchLoadingView(frame: containerView.bounds)
containerView.addSubview(v)

