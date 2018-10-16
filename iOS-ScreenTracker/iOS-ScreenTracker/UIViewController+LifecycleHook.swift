//
//  UIViewController+LifecycleHook.swift
//  iOS-ScreenTracker
//
//  Created by Kaoru Tsutsumishita on 2018/05/08.
//  Copyright © 2018年 roana0229. All rights reserved.
//

import UIKit

public protocol TrackingMarker {
    func screenName() -> String
    func screenParameter() -> [String: Any]
}

public protocol PagingChildTrackingMarker: TrackingMarker {
}

public protocol PagingParentTrackingMarker {
}


public class ScreenTracker {
    fileprivate static var instance: ScreenTracker?

    fileprivate let trackStartedObserver: (TrackingMarker) -> ()
    fileprivate let trackEndedObserver: (TrackingMarker, Int) -> ()

    public static func initialize(trackStarted: @escaping (TrackingMarker) -> (), trackEnded: @escaping (TrackingMarker, Int) -> ()) {
        ScreenTracker.instance = ScreenTracker(trackStarted, trackEnded)
        adaptViewController()
    }

    private init(_ trackStarted: @escaping (TrackingMarker) -> (), _ trackEnded: @escaping (TrackingMarker, Int) -> ()) {
        trackStartedObserver = trackStarted
        trackEndedObserver = trackEnded
    }

    private static func adaptViewController() {
        UIViewController.adaptHookMethod(originalSelector: #selector(UIViewController.viewDidLoad), hookSelector: #selector(UIViewController.hookViewDidLoad))
    }

}

extension UIViewController {

    fileprivate static func adaptHookMethod(originalSelector: Selector, hookSelector: Selector) {
        guard let originalMethod = class_getInstanceMethod(UIViewController.self, originalSelector), let hookMethod = class_getInstanceMethod(UIViewController.self, hookSelector) else {
            return
        }

        let didAddMethod = class_addMethod(UIViewController.self, originalSelector, method_getImplementation(hookMethod), method_getTypeEncoding(hookMethod))
        if didAddMethod {
            class_replaceMethod(UIViewController.self, hookSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, hookMethod)
        }
    }

    @objc fileprivate func hookViewDidLoad() {
        func addChildViewController(_ viewController: UIViewController) {
            addChild(viewController)
            view.insertSubview(viewController.view, at: 0)
            viewController.didMove(toParent: self)
        }

        if self is PagingParentTrackingMarker {
            addChildViewController(PagingParentLifecycleNotifyViewController())
        } else if self is TrackingMarker && !(self is PagingChildTrackingMarker) {
            addChildViewController(LifecycleNotifyViewController())
        }

        hookViewDidLoad() // call original ViewController.viewDidLoad()
    }

    public func setTabScrollViewForTracking(_ scrollView: UIScrollView) {
        if let v = getTabParentLifecycleNotifyViewController(self) {
            v.scrollView = scrollView
        }
    }

    public func notifyTabChangedForTracking(index: Int) {
        if let v = getTabParentLifecycleNotifyViewController(self) {
            v.tabChenged(index: index)
        }
    }

    private func getTabParentLifecycleNotifyViewController(_ viewController: UIViewController?) -> PagingParentLifecycleNotifyViewController? {
        guard let vc = viewController, vc is PagingParentTrackingMarker else {
            return nil
        }

        for child in vc.children {
            if let v = child as? PagingParentLifecycleNotifyViewController {
                return v
            }
        }

        return nil
    }

}

private final class LifecycleNotifyViewController: UIViewController {

    private var startedTime: Date!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.isHidden = true
        view.isUserInteractionEnabled = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let trackingMarker = parent as? TrackingMarker {
            startedTime = Date()
            ScreenTracker.instance?.trackStartedObserver(trackingMarker)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let trackingMarker = parent as? TrackingMarker {
            let ms = round(Date().timeIntervalSince(startedTime) * 1000)
            ScreenTracker.instance?.trackEndedObserver(trackingMarker, Int(ms))
        }
    }

}

private final class PagingParentLifecycleNotifyViewController: UIViewController, UIScrollViewDelegate {

    private var startedTime: Date!
    private var currentPosition: Int!
    fileprivate weak var scrollView: UIScrollView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.isHidden = true
        view.isUserInteractionEnabled = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resume()
        trackStarted(currentPosition)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        trackEnded(currentPosition)
    }

    private func trackStarted(_ index: Int) {
        ScreenTracker.instance?.trackStartedObserver(getCurrentTab(index: index))
    }

    private func trackEnded(_ index: Int) {
        let ms = round(Date().timeIntervalSince(startedTime) * 1000)
        ScreenTracker.instance?.trackEndedObserver(getCurrentTab(index: index), Int(ms))
    }

    private func resume() {
        resume(getCurrentIndex())
    }

    private func resume(_ index: Int) {
        startedTime = Date()
        currentPosition = index
    }

    private func getCurrentIndex() -> Int {
        guard let scrollView = scrollView else {
            fatalError("not set UIScrollView")
        }
        return Int(round(scrollView.contentOffset.x / scrollView.frame.width))
    }

    private func getCurrentTab(index: Int) -> TrackingMarker {
        let trackingTabs = parent!.children.filter { $0 is TrackingMarker }.map { $0 as! TrackingMarker }
        return trackingTabs[index]
    }

    fileprivate func tabChenged(index: Int) {
        trackEnded(currentPosition)
        resume(index)
        trackStarted(index)
    }

}

