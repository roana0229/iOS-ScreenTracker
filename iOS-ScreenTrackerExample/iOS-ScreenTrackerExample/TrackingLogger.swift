//
//  TrackingLogger.swift
//  iOS-ScreenTracker
//
//  Created by Kaoru Tsutsumishita on 2018/06/05.
//  Copyright © 2018年 roana0229. All rights reserved.
//

import Foundation
import ScreenTracker

struct TrackingLogger {

    static func track(_ trackingMarker: TrackingMarker) {
        print("show >>> screenName: \(trackingMarker.screenName()), parameter: \(trackingMarker.screenParameter())")
    }

    static func sendExposureEvent(_ trackingMarker: TrackingMarker, exposureTime: Int = 0) {
        print("hide <<< screenName: \(trackingMarker.screenName()), parameter: \(trackingMarker.screenParameter()), exposureTime: \(exposureTime)")
    }

}
