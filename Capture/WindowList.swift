//
//  WindowList.swift
//  Capture
//
//  Created by Ehlen, David on 08.07.19.
//  Copyright © 2019 David Ehlen. All rights reserved.
//

import Foundation

struct Window {
    let frame: CGRect
    let applicationName: String

    init(frame: CGRect, applicationName: String) {
        self.frame = frame.flippedScreenBounds
        self.applicationName = applicationName
    }

    var isCapture: Bool {
        return applicationName.caseInsensitiveCompare("Capture") == .orderedSame
    }
}

struct WindowList {
    static func all() -> [Window] {
        let options = CGWindowListOption(arrayLiteral: .excludeDesktopElements, .optionOnScreenOnly)
        let windowsListInfo = CGWindowListCopyWindowInfo(options, CGMainDisplayID()) //current window
        let infoList = windowsListInfo as! [[String: Any]]
        return infoList
            .filter { $0["kCGWindowLayer"] as! Int == 0 }
            .map { Window(
                frame: CGRect(x: ($0["kCGWindowBounds"] as! [String: Any])["X"] as! CGFloat,
                       y: ($0["kCGWindowBounds"] as! [String: Any])["Y"] as! CGFloat,
                       width: ($0["kCGWindowBounds"] as! [String: Any])["Width"] as! CGFloat,
                       height: ($0["kCGWindowBounds"] as! [String: Any])["Height"] as! CGFloat),
                applicationName: $0["kCGWindowOwnerName"] as! String)}
    }

    static func window(at point: CGPoint) -> Window? {
        // TODO: only if frontmost
        let list = all()
        return list.filter { $0.frame.contains(point) }.first
    }
}
