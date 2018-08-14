//
//  PagingChildViewController.swift
//  iOS-ScreenTrackerExample
//
//  Created by Kaoru Tsutsumishita on 2018/07/24.
//  Copyright © 2018年 roana0229. All rights reserved.
//

import UIKit
import ScreenTracker

class PagingChildViewController: UIViewController, PagingChildTrackingMarker {

    var pageIndex: Int!

    @IBOutlet weak var nextButton: UIButton!

    func screenName() -> String {
        return "tab"
    }

    func screenParameter() -> [String : Any] {
        var params: [String: Any] = [:]

        if let index = pageIndex {
            params["page_index"] = index
        }
        return params
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.setTitle("Page \(String(describing: pageIndex ?? 0))", for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onTapNext(_ sender: Any) {
        if let vc = parent?.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            vc.pageIndex = pageIndex
            present(vc, animated: true, completion: nil)
        }
    }

}
