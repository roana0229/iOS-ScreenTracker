//
//  DetailViewController.swift
//  iOS-ScreenTracker
//
//  Created by Kaoru Tsutsumishita on 2018/05/15.
//  Copyright © 2018年 roana0229. All rights reserved.
//

import UIKit
import ScreenTracker

class DetailViewController: UIViewController, TrackingMarker {

    func screenName() -> String {
        return "詳細"
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


    @IBAction func actionBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
