//
//  ViewController.swift
//  iOS-ScreenTracker
//
//  Created by Kaoru Tsutsumishita on 2018/05/08.
//  Copyright © 2018年 roana0229. All rights reserved.
//

import UIKit
import ScreenTracker

class ViewController: UIViewController, TrackingMarker {

    func screenName() -> String {
        return "リスト"
    }

    func screenParameter() -> [String : Any] {
        return [:]
    }

    deinit {
        Logger.log()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Logger.log()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Logger.log()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Logger.log()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Logger.log()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Logger.log()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
