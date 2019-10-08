//
//  NSView+Geometry.swift
//  Links
//
//  Created by Alex Ignatenko on 13/06/16.
//  Copyright © 2016 Alex Ignatenko. All rights reserved.
//

import AppKit

extension NSView {

    func setCenter(_ center: NSPoint) {
        let size = self.frame.size
        self.frame.origin = NSPoint(
            x: center.x - ceil(0.5 * size.width),
            y: center.y - ceil(0.5 * size.height)
        )
    }
}
