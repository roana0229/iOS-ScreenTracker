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

    @IBOutlet private weak var titleLabel: UILabel!

    var pageIndex: Int?
    var nestCount: Int = 0

    func screenName() -> String {
        return "detail"
    }

    func screenParameter() -> [String : Any] {
        var params: [String: Any] = [:]

        if let index = pageIndex {
            params["from_page_index"] = index
        }
        params["next_count"] = nestCount
        return params
    }

    deinit {
        Logger.log()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Logger.log()
        titleLabel.text = "Detail nestCount: \(nestCount)"
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

    @IBAction func actionToNext(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            vc.pageIndex = pageIndex
            vc.nestCount = nestCount + 1
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func actionBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
