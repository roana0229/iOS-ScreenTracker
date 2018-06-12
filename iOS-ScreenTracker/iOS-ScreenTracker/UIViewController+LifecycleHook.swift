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

public class ScreenTracker {
    fileprivate static var instance: ScreenTracker?

    fileprivate let trackStartedObserver: (TrackingMarker) -> ()
    fileprivate let trackEndedObserver: (TrackingMarker, Int) -> ()

    static func initialize(trackStarted: @escaping (TrackingMarker) -> (), trackEnded: @escaping (TrackingMarker, Int) -> ()) {
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
        hookViewDidLoad() // call original ViewController.viewDidLoad()

        if self is LifecycleNotifyViewController {
            return
        }

        let lifecycleNotify = LifecycleNotifyViewController()
        addChildViewController(lifecycleNotify)
        view.insertSubview(lifecycleNotify.view, at: 0)
        lifecycleNotify.didMove(toParentViewController: self)
    }

}

private class LifecycleNotifyViewController: UIViewController {

    private var startedTime: Date?

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
            if let started = startedTime {
                let ms = round(Date().timeIntervalSince(started) * 1000)
                ScreenTracker.instance?.trackEndedObserver(trackingMarker, Int(ms))
            } else {
                ScreenTracker.instance?.trackEndedObserver(trackingMarker, 0)
            }
        }
    }

}
