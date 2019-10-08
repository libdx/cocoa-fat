//
//  NodeView.swift
//  Links
//
//  Created by Alex Ignatenko on 13/06/16.
//  Copyright © 2016 Alex Ignatenko. All rights reserved.
//

import AppKit

class NodeView: BaseView {
    var editable: Bool = false

    // TODO: update position on size change
    var position = NSPoint(x: 0, y: 0) {
        didSet {
            let size = self.frame.size
            self.frame.origin = NSPoint(
                x: position.x - ceil(0.5 * size.width),
                y: position.y - ceil(0.5 * size.height)
            )
        }
    }

    // TODO: update text position on size change
    var text: String = "" {
        didSet {
            label.stringValue = self.text
            label.sizeToFit()
            label.frame.size.width = bounds.size.width - 10
            let center = NSPoint(
                x: ceil(0.5 * bounds.size.width),
                y: ceil(0.5 * bounds.size.height)
            )
            label.frame.origin = NSPoint(
                x: center.x - ceil(0.5 * label.bounds.size.width),
                y: center.y - ceil(0.5 * label.bounds.size.height)
            )
        }
    }

    class TextField: NSTextField {
        override func becomeFirstResponder() -> Bool {
            isEditable = true
            return super.becomeFirstResponder()
        }
    }

    fileprivate lazy var label: TextField = {
        [unowned self] in
        let label = TextField()
        label.isEditable = false
        label.backgroundColor = NSColor.clear
        label.isBezeled = false
        label.alignment = .center
        return label
    }()

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.addSubview(label)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidMoveToWindow() {
        if editable {
            window?.makeFirstResponder(label)
        }
    }
}
