//
//  LinksView.swift
//  Links
//
//  Created by Alex Ignatenko on 13/06/16.
//  Copyright © 2016 Alex Ignatenko. All rights reserved.
//

import AppKit

class LinksView: BaseView {
    var links: [SceneView.Link] = [] {
        didSet {
            self.setNeedsDisplay(self.bounds)
        }
    }

    override func draw(_ dirtyRect: NSRect) {
        for link in links {
            drawLink(link)
        }
    }

    func drawLink(_ link: SceneView.Link) {
        let c = NSGraphicsContext.current()?.cgContext

        c?.saveGState()

        let color = NSColor.linkGray()

        c?.move(to: CGPoint(x: link.source.x, y: link.source.y))
        c?.addLine(to: CGPoint(x: link.target.x, y: link.target.y))
        c?.setStrokeColor(red: color.redComponent, green: color.greenComponent, blue: color.blueComponent, alpha: 1)
        c?.setLineWidth(2)
        c?.strokePath()

        c?.restoreGState()
    }
}
