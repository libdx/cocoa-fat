//
//  NSColor+Colors.swift
//  Links
//
//  Created by Alex Ignatenko on 13/06/16.
//  Copyright © 2016 Alex Ignatenko. All rights reserved.
//

import AppKit

extension NSColor {
    class func softBlue() -> NSColor {
        return NSColor(calibratedRed: 107/255.0, green: 210/255.0, blue: 219/255.0, alpha: 1)
    }

    class func acidGreen() -> NSColor {
        return NSColor(calibratedRed: 0, green: 1, blue: 171/255.0, alpha: 1)
    }

    class func linkGray() -> NSColor {
        return NSColor(calibratedRed: 101/255.0, green: 125/255.0, blue: 138/255.0, alpha: 1)
    }

    class func background() -> NSColor {
        return NSColor(calibratedRed: 245/255.0, green: 243/255.0, blue: 238/255.0, alpha: 1);
    }
}
