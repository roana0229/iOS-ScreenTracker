//
//  ViewController.swift
//  iOS-ScreenTracker
//
//  Created by Kaoru Tsutsumishita on 2018/05/08.
//  Copyright © 2018年 roana0229. All rights reserved.
//

import UIKit
import ScreenTracker

class ViewController: UIViewController, PagingParentTrackingMarker {

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
        }
    }
    @IBOutlet weak var page1Container: UIView!
    @IBOutlet weak var page2Container: UIView!
    @IBOutlet weak var page3Container: UIView!

    var currentPosition: Int = 0

    deinit {
        Logger.log()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabScrollViewForTracking(scrollView)

        let vc1 = UIStoryboard(name: "PagingChildViewController", bundle: nil).instantiateInitialViewController() as! PagingChildViewController
        vc1.pageIndex = 1
        vc1.view.frame = page1Container.bounds
        vc1.view.backgroundColor = UIColor.init(red: 255, green: 0, blue: 0, alpha: 0.2)
        page1Container.addSubview(vc1.view)
        addChildViewController(vc1)
        vc1.didMove(toParentViewController: self)

        let vc2 = UIStoryboard(name: "PagingChildViewController", bundle: nil).instantiateInitialViewController() as! PagingChildViewController
        vc2.pageIndex = 2
        vc2.view.frame = page2Container.bounds
        vc2.view.backgroundColor = UIColor.init(red: 0, green: 255, blue: 0, alpha: 0.2)
        page2Container.addSubview(vc2.view)
        addChildViewController(vc2)
        vc2.didMove(toParentViewController: self)

        let vc3 = UIStoryboard(name: "PagingChildViewController", bundle: nil).instantiateInitialViewController() as! PagingChildViewController
        vc3.pageIndex = 3
        vc3.view.frame = page3Container.bounds
        vc3.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 255, alpha: 0.2)
        page3Container.addSubview(vc3.view)
        addChildViewController(vc3)
        vc3.didMove(toParentViewController: self)

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

    @IBAction func onTap1Page(_ sender: Any) {
        showDetail(index: 1)
    }

    @IBAction func onTap2Page(_ sender: Any) {
        showDetail(index: 2)
    }

    @IBAction func onTap3Page(_ sender: Any) {
        showDetail(index: 3)
    }

    private func showDetail(index: Int) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            vc.pageIndex = index
            present(vc, animated: true, completion: nil)
        }
    }

}

extension ViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let newPosition = Int(round(scrollView.contentOffset.x / scrollView.bounds.width))
        if currentPosition != newPosition {
            currentPosition = newPosition
            notifyTabChangedForTracking(index: newPosition)
        }
    }

}
