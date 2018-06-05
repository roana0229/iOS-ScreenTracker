//
//  TrackingLogger.swift
//  iOS-ScreenTracker
//
//  Created by Kaoru Tsutsumishita on 2018/06/05.
//  Copyright © 2018年 roana0229. All rights reserved.
//

import Foundation

struct TrackingLogger {

    enum Event {
        case display
        case tap
    }
    enum Widget {
        case screen
        case alert
    }
    enum ContentID {
        case topTestAlert
    }
    enum ContentType {
        case milliseconds
        case button
    }
    enum Content {
        case close
    }

    static func track(_ trackingMarker: TrackingMarker) {
        Logger.log("====================================> screenName: \(trackingMarker.screenName()), parameter: \(trackingMarker.screenParameter())")
    }

    static func sendExposureEvent(_ trackingMarker: TrackingMarker, exposureTime: Int = 0) {
        Logger.log("<==================================== screenName: \(trackingMarker.screenName()), parameter: \(trackingMarker.screenParameter()), exposureTime: \(exposureTime)")
    }

    static func sendEvent(_ event: Event, widget: Widget, contentID: ContentID? = nil, contentType: ContentType? = nil, content: Content? = nil, position: Int? = nil) {

        let logTime = Date().timeIntervalSince1970
        let userID = "uniqu_user_id"
        let sessionID = "uniqu_session_id"
        let pvCount = 0

        Logger.log("=====================================")
        Logger.log("LogTime: \(logTime), UserID: \(userID), SessionID: \(sessionID), PVCount: \(pvCount)")
        Logger.log("Event: \(event), Widget: \(widget), Position: \(position), ContentID: \(contentID), ContentType: \(contentType), Content: \(content)")
        Logger.log("=====================================")
    }

}
