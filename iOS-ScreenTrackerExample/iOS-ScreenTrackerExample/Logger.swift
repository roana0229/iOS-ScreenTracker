import UIKit

class Logger {

    class func log(_ function: String = #function, file: String = #file, line: Int = #line) {
//        #if DEBUG
//        let filename = file.components(separatedBy: "/").last!
//        print("\(filename):L\(line):\(function)")
//        #endif
    }

    class func log(_ message: Any?, function: String = #function, file: String = #file, line: Int = #line) {
//        #if DEBUG
//        let filename = file.components(separatedBy: "/").last!
//        if message == nil {
//            print("\(filename):L\(line):\(function)")
//        } else {
//            print("\(filename):L\(line):\(function) \"\(message!)\"")
//        }
//        #endif
    }

}
