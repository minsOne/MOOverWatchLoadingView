//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

var str = "Hello, playground"

let containerView = UIView(frame: CGRectMake(0,0,300,300))
containerView.backgroundColor = .whiteColor()
XCPlaygroundPage.currentPage.liveView = containerView

let v = MOOverWatchLoadingView(frame: containerView.bounds)
containerView.addSubview(v)
