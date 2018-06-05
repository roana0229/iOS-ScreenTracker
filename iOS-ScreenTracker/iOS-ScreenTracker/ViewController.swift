//
//  ViewController.swift
//  iOS-ScreenTracker
//
//  Created by Kaoru Tsutsumishita on 2018/05/08.
//  Copyright © 2018年 roana0229. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TrackingMarker {

    var screenName: String = "リスト"
    var screenParameter: [String : Any] = [:]

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

    @IBAction func actionTapBtn(_ sender: Any) {
        let alert = UIAlertController.init(title: "test", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "close", style: .default, handler: { (_) in
            TrackingLogger.sendEvent(.tap, widget: .alert, contentID: .topTestAlert, contentType: .button, content: .close)
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: {
            TrackingLogger.sendEvent(.display, widget: .alert, contentID: .topTestAlert)
        })
    }

}
