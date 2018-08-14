//
//  TrackingLogger.swift
//  iOS-ScreenTracker
//
//  Created by Kaoru Tsutsumishita on 2018/06/05.
//  Copyright © 2018年 roana0229. All rights reserved.
//

import Foundation
import ScreenTracker

class TrackingLogger {

    static let shared = TrackingLogger()
    private var pvCount = 0

    func track(_ trackingMarker: TrackingMarker) {
        pvCount = pvCount + 1
        print(">================================================================")
        print("screenName: \(trackingMarker.screenName())(pv:\(pvCount)), parameter: \(trackingMarker.screenParameter())")
    }

    func sendExposureEvent(_ trackingMarker: TrackingMarker, exposureTime: Int = 0) {
        print("hidden exposureTime: \(exposureTime)ms")
        print("<================================================================")
    }

}
