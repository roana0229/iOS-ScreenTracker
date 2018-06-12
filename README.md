# iOS-ScreenTracker

`UIViewController` track library

## Usage

#### 1. Import this library

```
github "roana0229/iOS-ScreenTracker" >= 1.0.0
```

[Look at the sample code](https://github.com/roana0229/iOS-ScreenTracker/blob/master/iOS-ScreenTrackerExample/Cartfile)

#### 2. Initialize `ScreenTracker`

##### Track `UIViewController`

```.swift
import UIKit
import ScreenTracker

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        ScreenTracker.initialize(trackStarted: { trackingMarker in
            // tracked viewWillAppear
        }, trackEnded: { trackingMarker, exposureTime in
            // tracked viewWillDisappear
        })

        return true
    }

    ...
}
```

[Look at the sample code](https://github.com/roana0229/iOS-ScreenTracker/blob/master/iOS-ScreenTrackerExample/iOS-ScreenTrackerExample/AppDelegate.swift#L20)


#### 3. Implement Protocol `TrackingMarker`

```.swift
import ScreenTracker

class ViewController: UIViewController, TrackingMarker {

    func screenName() -> String {
        return "リスト"
    }

    func screenParameter() -> [String : Any] {
        return [:]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    ...

```

[Look at the sample code](https://github.com/roana0229/iOS-ScreenTracker/blob/master/iOS-ScreenTrackerExample/iOS-ScreenTrackerExample/ViewController.swift#L12)

If you are tracking everything, you should write `TrackingMarker` in `BaseViewController`.

## Sample Tracking Logger Utility

[Look at the sample code](https://github.com/roana0229/iOS-ScreenTracker/blob/master/iOS-ScreenTrackerExample/iOS-ScreenTrackerExample/TrackingLogger.swift)


## LICENSE

see `LICENSE` file.

Copyright (c) 2018 Kaoru Tsutsumishita <roana.enter@gmail.com>
