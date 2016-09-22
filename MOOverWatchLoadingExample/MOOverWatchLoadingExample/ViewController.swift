//
//  ViewController.swift
//  MOOverWatchLoadingExample
//
//  Created by JungMin Ahn on 9/23/16.
//  Copyright © 2016 minsone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var loadingView: MOOverWatchLoadingView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        loadingView = MOOverWatchLoadingView(frame: CGRectMake(0, 0, view.frame.width, view.frame.width),
                                             autoStartAnimation: true)
        self.view.addSubview(loadingView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

