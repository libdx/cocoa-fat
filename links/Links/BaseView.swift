//
//  BaseView.swift
//  Links
//
//  Created by Alex Ignatenko on 11/03/16.
//  Copyright © 2016 Alex Ignatenko. All rights reserved.
//

import AppKit

class BaseView: NSView {
    var backgroundColor: NSColor? {
        didSet {
            self.layer?.backgroundColor = self.backgroundColor?.cgColor
        }
    }

    override var isFlipped: Bool {
        get {
            return true
        }
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.wantsLayer = true
    }
}
