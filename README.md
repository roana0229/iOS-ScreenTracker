# iOS-ScreenTracker

The minimum library to track screen `UIViewController`.  
Hook screen `viewWillAppear`, `viewWillDisappear`. And hook screen only ViewController in ScrollView.  
If you use for Android, see [Android-ScreenTracker](https://github.com/roana0229/Android-ScreenTracker).

![demo](https://raw.githubusercontent.com/roana0229/iOS-ScreenTracker/master/demo.gif)

## Usage

#### 1. Import this library

```
github "roana0229/iOS-ScreenTracker" >= 1.0
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

##### Track `UIViewController`

use `TrackingMarker`

```.swift
import ScreenTracker

class DetailViewController: UIViewController, TrackingMarker {

    var id: Int?

    func screenName() -> String {
        return "detail"
    }

    func screenParameter() -> [String : Any] {
        var params: [String: Any] = [:]

        if let id = id {
            params["id"] = id
        }
        return params
    }

    ...
}
```

[Look at the sample code](https://github.com/roana0229/iOS-ScreenTracker/blob/master/iOS-ScreenTrackerExample/iOS-ScreenTrackerExample/DetailViewController.swift#L12)


##### Track PagingViewController(`UIViewController in UIScrollView`)

use `PagingParentTrackingMarker` and `PagingChildTrackingMarker`

```.swift
import UIKit
import ScreenTracker

class ViewController: UIViewController, PagingParentTrackingMarker {
    ...

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabScrollViewForTracking(scrollView)

        let vc1 = ...
        page1Container.addSubview(vc1.view)
        addChildViewController(vc1)
        vc1.didMove(toParentViewController: self)

        let vc2 = ...
        page2Container.addSubview(vc2.view)
        addChildViewController(vc2)
        vc2.didMove(toParentViewController: self)

        let vc3 = ...
        page3Container.addSubview(vc3.view)
        addChildViewController(vc3)
        vc3.didMove(toParentViewController: self)
    }

    ...
}
```

[Look at the sample code](https://github.com/roana0229/iOS-ScreenTracker/blob/master/iOS-ScreenTrackerExample/iOS-ScreenTrackerExample/ViewController.swift#L12)

```.swift
import UIKit
import ScreenTracker

class PagingChildViewController: UIViewController, PagingChildTrackingMarker {

    var pageIndex: Int!

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

    ....
}
```

[Look at the sample code](https://github.com/roana0229/iOS-ScreenTracker/blob/master/iOS-ScreenTrackerExample/iOS-ScreenTrackerExample/PagingChildViewController.swift#L12)


If you are tracking everything, you should write `TrackingMarker` in `BaseViewController`.

## Sample Tracking Logger Utility

[Look at the sample code](https://github.com/roana0229/iOS-ScreenTracker/blob/master/iOS-ScreenTrackerExample/iOS-ScreenTrackerExample/TrackingLogger.swift)


## LICENSE

see `LICENSE` file.

Copyright (c) 2018 Kaoru Tsutsumishita <roana.enter@gmail.com>
